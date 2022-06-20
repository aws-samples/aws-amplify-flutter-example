/* Amplify Params - DO NOT EDIT
	API_POWERTOOLKIT_OCRRECORDTABLE_ARN
	API_POWERTOOLKIT_OCRRECORDTABLE_NAME
	ENV
	REGION
Amplify Params - DO NOT EDIT */

const AWS = require('aws-sdk');
var rp = require('request-promise');
const dynamoDb = new AWS.DynamoDB.DocumentClient();

exports.handler = async function (event) {
    console.log('Received S3 event:', JSON.stringify(event, null, 2));
    const record = event.Records[0];
    const s3Record = record.s3;
    const bucket = s3Record.bucket.name;
    const key = decodeURIComponent(s3Record.object.key);
    const env = process.env.ENV;
    const region = process.env.REGION;
    const ocrRecordTableARN = process.env.API_POWERTOOLKIT_OCRRECORDTABLE_ARN;
    const ocrRecordTableName = process.env.API_POWERTOOLKIT_OCRRECORDTABLE_NAME;

    console.log(`Bucket: ${bucket}`, `Key: ${key}`, `env: ${env}`, `region: ${region}`,
        `ocrRecordTableARN: ${ocrRecordTableARN}`,
        `ocrRecordTableName: ${ocrRecordTableName}`
    );

    // ignore events except for ObjectCreated
    if (!record.eventName.startsWith("ObjectCreated:")) {
        return {
            statusCode: 200,
            body: "ok",
        }
    }

    // get object from S3
    const params = {
      Bucket: bucket,
      Key: key
    }
    var s3 = new AWS.S3();
    const data = await s3.getObject(params).promise();
    let buf = Buffer.from(data.Body);
    let base64 = buf.toString('base64');
    console.log(`get object from S3`)

    const AIKitsInvokeURL = process.env.AIKitsInvokeURL;
    var options = {
      method: 'POST',
      uri: AIKitsInvokeURL,
      body: {img: base64},
      json: true
    };
    var ocrBody = await rp(options);
    var content = JSON.stringify(ocrBody)
    console.log(`ocr finished.`, `${content}`)

    // update record
    const id = _parseId(key);
    const updateParams = {
        TableName: ocrRecordTableName,
        Key: {
          id: id,
        },
        UpdateExpression: 'SET content = :content',
        ExpressionAttributeValues: {
          ':content': content,
        },
    };
    await dynamoDb.update(updateParams, (error) => {
        if (error) {
          console.error(error);
          return error
        }

        console.log('Content updated.')
        return {}
    }).promise();

    return {
        statusCode: 200,
        body: "ok"
    };
};

function _parseId(key) {
    var arr = key.split('/')
    var fileName = arr[arr.length - 1]
    return fileName.split('.')[0]
}
// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '/app_nav_cubit.dart';
import '/solution/ocr/list/list_event.dart';
import '../ocr_nav_cubit.dart';
import 'list_bloc.dart';
import 'list_state.dart';

class OCRListView extends StatelessWidget {
  const OCRListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OCRListBloc, OCRListState>(
      listener: (context, state) {
        if (state.imageSourceActionSheetIsVisible) {
          _showImageSourceActionSheet(context);
        }
      },
      child: Scaffold(
        appBar: _appBar(context),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add_a_photo),
          onPressed: () =>
              {context.read<OCRListBloc>().add(const UploadImageRequest())},
        ),
        body: Stack(
          children: [
            _linearProgressIndicator(),
            RefreshIndicator(
              child: _gridViewLoader(),
              onRefresh: () async {
                context.read<OCRListBloc>().add(const OCRListRefreshEvent());
              },
            ),
            // _uploadImageButton(context),
          ],
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () => context.read<AppNavCubit>().showHome(),
        child: const Icon(Icons.arrow_back_outlined),
      ),
      title: const Text('OCR Solution'),
      actions: [
        IconButton(
          icon: const Icon(Icons.add_a_photo),
          onPressed: () =>
              {context.read<OCRListBloc>().add(const UploadImageRequest())},
        ),
      ],
    );
  }

  Widget _linearProgressIndicator() {
    return BlocBuilder<OCRListBloc, OCRListState>(
      builder: (context, state) {
        return state.uploading
            ? const LinearProgressIndicator(
                backgroundColor: Colors.white,
                semanticsLabel: 'uploading progress',
              )
            : const SizedBox.shrink();
      },
    );
  }

  BlocBuilder<OCRListBloc, OCRListState> _gridViewLoader() {
    return BlocBuilder<OCRListBloc, OCRListState>(
      builder: (context, state) {
        if (state.loadingState == LoadingState.inProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.loadingState == LoadingState.success) {
          return _gridView();
        } else if (state.loadingState == LoadingState.failed) {
          return Center(
            child: Text(state.error.toString()),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _gridView() {
    return BlocBuilder<OCRListBloc, OCRListState>(
      builder: (context, state) {
        if (state.records!.isEmpty) {
          return const Center(
            child: Text('No date. Please upload a new image.'),
          );
        }
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: state.records!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(3),
              child: GestureDetector(
                onTap: () => BlocProvider.of<OCRNavCubit>(context)
                    .showOCRDetail(state.records![index].id),
                child: CachedNetworkImage(
                  imageUrl: state.records![index].url,
                  fit: BoxFit
                      .contain, // Ref: https://www.jianshu.com/p/8810bacfe5d4
                  placeholder: _loader,
                  errorWidget: _error,
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showImageSourceActionSheet(BuildContext context) {
    void selectImageSource(ImageSource imageSource) {
      context
          .read<OCRListBloc>()
          .add(OpenImagePicker(imageSource: imageSource));
    }

    if (Platform.isIOS) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              child: const Text('Camera'),
              onPressed: () {
                Navigator.pop(context);
                selectImageSource(ImageSource.camera);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Gallery'),
              onPressed: () {
                Navigator.pop(context);
                selectImageSource(ImageSource.gallery);
              },
            )
          ],
        ),
      );
    } else {
      showModalBottomSheet<void>(
        context: context,
        builder: (context) => Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                selectImageSource(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_album),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                selectImageSource(ImageSource.gallery);
              },
            ),
          ],
        ),
      );
    }
  }

  Widget _error(BuildContext context, String url, dynamic error) {
    return const Center(child: Icon(Icons.error));
  }

  Widget _loader(BuildContext context, String url) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.blue,
      ),
    );
  }
}

// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/solution/ocr/detail/detail_event.dart';
import 'detail_bloc.dart';
import 'detail_state.dart';

class OCRDetailView extends StatelessWidget {
  const OCRDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OCR Result'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => {
              context.read<OCRDetailBloc>().add(const OCRDetailRefreshEvent())
            },
          )
        ],
      ),
      body: BlocBuilder<OCRDetailBloc, OCRDetailState>(
        builder: (context, state) {
          if (state.loadingState == LoadingState.inProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.loadingState == LoadingState.success) {
            return Center(
              child: _body(),
            );
          } else if (state.loadingState == LoadingState.failed) {
            return Center(
              child: Text(state.error.toString()),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _body() {
    return BlocBuilder<OCRDetailBloc, OCRDetailState>(
      builder: (context, state) {
        return Scaffold(
          body: _contentWithScore(state),
        );
      },
    );
  }

  ListView _contentWithScore(OCRDetailState state) {
    final list = state.contentList!;
    return ListView.builder(
      itemCount: list.length + 1,
      itemBuilder: (context, index) {
        return index == 0
            ? Card(
                child: CachedNetworkImage(
                  imageUrl: state.record!.url,
                  placeholder: _loader,
                  errorWidget: _error,
                ),
              )
            : ListTile(
                title: Text('words: ${list[index - 1].words}'),
                subtitle: Text('score: ${list[index - 1].score}'),
                trailing: const Icon(Icons.copy),
                onTap: () => {
                  Clipboard.setData(ClipboardData(text: list[index - 1].words))
                },
              );
      },
    );
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

// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '/auth/form_submission_status.dart';
import '/profile/profile_bloc.dart';
import '/profile/profile_event.dart';
import '/profile/profile_state.dart';
import '/repository/storage_repository.dart';
import '/repository/user_repository.dart';
import '/session/session_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionCubit = context.read<SessionCubit>();
    return BlocProvider(
      create: (context) => ProfileBloc(
        dataRepo: context.read<UserRepository>(),
        storageRepo: context.read<StorageRepository>(),
        user: sessionCubit.currentUser,
      ),
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.imageSourceActionSheetIsVisible) {
            _showImageSourceActionSheet(context);
          }

          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            _showSnackBar(context, formStatus.exception.toString());
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF2F2F7),
          appBar: _appBar(),
          body: _profilePage(),
        ),
      ),
    );
  }

  PreferredSize _appBar() {
    final appBarHeight = AppBar().preferredSize.height;
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return AppBar(
            title: const Text('Profile'),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  BlocProvider.of<SessionCubit>(context).signOut();
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _profilePage() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _linearProgressIndicator(),
                const SizedBox(height: 30),
                _avatar(),
                _changeAvatarButton(),
                const SizedBox(height: 25),
                _usernameTile(),
                _emailTile(),
                const SizedBox(height: 15),
                _signOutButton()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _linearProgressIndicator() {
    return BlocBuilder<ProfileBloc, ProfileState>(
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

  Widget _avatar() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Container(
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
          width: 100,
          height: 100,
          child: state.avatarPath == null
              ? const Icon(Icons.person, size: 50)
              : ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  // child: Icon(Icons.person, size: 50),
                  child: CachedNetworkImage(
                    imageUrl: state.avatarPath!,
                    fit: BoxFit.cover,
                    placeholder: _loader,
                    errorWidget: _error,
                  ),
                ),
        );
      },
    );
  }

  Widget _changeAvatarButton() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return TextButton(
          onPressed: () =>
              context.read<ProfileBloc>().add(const ChangeAvatarRequest()),
          child: const Text('Change Avatar'),
        );
      },
    );
  }

  Widget _usernameTile() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return ListTile(
          tileColor: Colors.white,
          leading: const Icon(Icons.person),
          title: Text(state.user.username ?? ''),
        );
      },
    );
  }

  Widget _emailTile() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return ListTile(
          tileColor: Colors.white,
          leading: const Icon(Icons.mail),
          title: Text(state.user.email ?? ''),
        );
      },
    );
  }

  Widget _signOutButton() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () => BlocProvider.of<SessionCubit>(context).signOut(),
          child: const Text('Sign Out'),
        );
      },
    );
  }

  void _showImageSourceActionSheet(BuildContext context) {
    void selectImageSource(ImageSource imageSource) {
      context
          .read<ProfileBloc>()
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

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _error(BuildContext context, String url, dynamic error) {
    return const Center(child: Icon(Icons.error));
  }

  Widget _loader(BuildContext context, String url) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}

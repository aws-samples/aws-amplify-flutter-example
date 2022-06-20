// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/auth/auth_cubit.dart';
import '/auth/auth_repository.dart';
import '/auth/confirm/confirmation_bloc.dart';
import '/auth/confirm/confirmation_event.dart';
import '/auth/confirm/confirmation_state.dart';
import '/auth/form_submission_status.dart';

class ConfirmationView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  ConfirmationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ConfirmationBloc(
          authRepo: context.read<AuthRepository>(),
          authCubit: context.read<AuthCubit>(),
        ),
        child: _confirmationForm(),
      ),
    );
  }

  Widget _confirmationForm() {
    return BlocListener<ConfirmationBloc, ConfirmationState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            _showSnackBar(context, formStatus.exception.toString());
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _codeField(),
                const SizedBox(
                  height: 10,
                ),
                _confirmButton(),
              ],
            ),
          ),
        ));
  }

  Widget _codeField() {
    return BlocBuilder<ConfirmationBloc, ConfirmationState>(builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
          icon: Icon(Icons.confirmation_num),
          hintText: 'Confirmation Code',
        ),
        validator: (value) => state.isValidCode ? null : 'Invalid confirmation code',
        onChanged: (value) => context.read<ConfirmationBloc>().add(
              ConfirmationCodeChanged(code: value),
            ),
      );
    });
  }

  Widget _confirmButton() {
    return BlocBuilder<ConfirmationBloc, ConfirmationState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? const SizedBox(
              child: CircularProgressIndicator(strokeWidth: 2.0),
              width: 20,
              height: 20,
            )
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<ConfirmationBloc>().add(ConfirmationSubmitted());
                }
              },
              child: const Text('Confirm'),
            );
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

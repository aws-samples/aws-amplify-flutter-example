// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:flutter_bloc/flutter_bloc.dart';

import '/auth/auth_cubit.dart';
import '/auth/auth_repository.dart';
import '/auth/form_submission_status.dart';
import '/service/analytics/analytics_events.dart';
import '/service/analytics/analytics_service.dart';
import 'confirmation_event.dart';
import 'confirmation_state.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  ConfirmationBloc({
    required this.authRepo,
    required this.authCubit,
  }) : super(const ConfirmationState()) {
    // Confirmation code updated
    on<ConfirmationCodeChanged>(
      (event, emit) => emit(state.copyWith(code: event.code)),
    );
    // Form submitted
    on<ConfirmationSubmitted>(_confirmationSubmitted);
  }
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  void _confirmationSubmitted(
    ConfirmationSubmitted event,
    Emitter<ConfirmationState> emit,
  ) async {
    emit(state.copyWith(formStatus: const FormSubmitting()));

    try {
      final username = authCubit.credentials!.username;
      await authRepo.confirmSignUp(
        username: username,
        confirmationCode: state.code,
      );
      AnalyticsService.log(ConfirmationCodeEvent(true));
      emit(state.copyWith(formStatus: const SubmissionSuccess()));

      // login by username and password after confirm sign up.
      final userId = await authRepo.login(
        username: username,
        password: authCubit.credentials!.password,
      );
      authCubit.createSessionAfterAuth(userId, username);
    } on Exception catch (e) {
      AnalyticsService.log(ConfirmationCodeEvent(false));
      emit(state.copyWith(formStatus: SubmissionFailed(exception: e)));
    }
  }
}

// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:flutter_bloc/flutter_bloc.dart';
import '/auth/auth_cubit.dart';
import '/auth/auth_repository.dart';
import '/auth/form_submission_status.dart';
import '/auth/sign_up/sign_up_event.dart';
import '/auth/sign_up/sign_up_state.dart';
import '/service/analytics/analytics_service.dart';
import '/service/analytics/analytics_events.dart' as analytics_events;

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  SignUpBloc({required this.authRepo, required this.authCubit}) : super(SignUpState()) {
    // Username updated
    on<SignUpUsernameChanged>((event, emit) => emit(state.copyWith(username: event.username)));
    // Email updated
    on<SignUpEmailChanged>((event, emit) => emit(state.copyWith(email: event.email)));
    // Password updated
    on<SignUpPasswordChanged>((event, emit) => emit(state.copyWith(password: event.password)));
    // Form submitted
    on<SignUpSubmitted>(_signUpSubmitted);
  }

  void _signUpSubmitted(SignUpSubmitted event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try {
      await authRepo.signUp(
        username: state.username,
        email: state.email,
        password: state.password,
      );
      AnalyticsService.log(analytics_events.SignUpEvent(true));
      emit(state.copyWith(formStatus: SubmissionSuccess()));

      authCubit.showConfirmSignUp(
        username: state.username,
        email: state.email,
        password: state.password,
      );
    } on Exception catch (e) {
      AnalyticsService.log(analytics_events.SignUpEvent(false));
      emit(state.copyWith(formStatus: SubmissionFailed(exception: e)));
    }
  }
}

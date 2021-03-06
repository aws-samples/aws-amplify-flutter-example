// SPDX-FileCopyrightText: 2022 Jinsong, Zhu <jasonzjs@amazon.com>
//
// SPDX-License-Identifier: MIT-0

import 'package:flutter_bloc/flutter_bloc.dart';
import '/service/analytics/analytics_service.dart';
import '/service/analytics/analytics_events.dart' as analytics_events;

import '../auth_cubit.dart';
import '../auth_repository.dart';
import '../form_submission_status.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  LoginBloc({required this.authRepo, required this.authCubit}) : super(LoginState()) {
    on<LoginUsernameChanged>((event, emit) => emit(state.copyWith(username: event.username)));
    on<LoginPasswordChanged>((event, emit) => emit(state.copyWith(password: event.password)));
    on<LoginSubmitted>(_loginSubmitted);
  }

  void _loginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try {
      final userId = await authRepo.login(
        username: state.username,
        password: state.password,
      );
      AnalyticsService.log(analytics_events.LoginEvent(true));
      emit(state.copyWith(formStatus: SubmissionSuccess()));

      authCubit.createSessionAfterAuth(userId, state.username);
    } on Exception catch (e) {
      AnalyticsService.log(analytics_events.LoginEvent(false));
      emit(state.copyWith(formStatus: SubmissionFailed(exception: e)));
    }
  }
}

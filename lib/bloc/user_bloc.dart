import 'package:api_test/core/network/api_service.dart';
import 'package:api_test/core/network/model/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class UserEvent {}

class UserLoginEvent extends UserEvent {
  final String username;
  final String password;
  UserLoginEvent({required this.username, required this.password});
}

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoginSuccess extends UserState {
  final User user;
  UserLoginSuccess(this.user);
}

class UserLoginFailure extends UserState {
  final String message;
  UserLoginFailure(this.message);
}

class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiService apiService;
  UserBloc(this.apiService) : super(UserInitial()) {
    on<UserLoginEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await apiService.requestLogin(
          username: event.username,
          password: event.password,
        );
        emit(UserLoginSuccess(user));
      } on DioException catch (error) {
        final message = error.response?.statusCode == 401
            ? 'Invalid username or password.'
            : error.response?.statusCode != null
            ? 'Login failed (HTTP ${error.response!.statusCode}).'
            : 'Could not connect to the login service.';
        emit(UserLoginFailure(message));
      } catch (_) {
        emit(UserLoginFailure('Login failed. Please try again.'));
      }
    });
  }
}

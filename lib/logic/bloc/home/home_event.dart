part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoginEvent extends HomeEvent {
  final String username;
  final int password;

  const LoginEvent(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}

class RegisterServiceEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

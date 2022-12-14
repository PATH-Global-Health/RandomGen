part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();

  @override
  List<Object?> get props => [];
}

class SuccessfulLoginState extends HomeState {
  final String username;

  const SuccessfulLoginState(this.username);

  @override
  List<Object?> get props => [username];
}

class FailedLoginState extends HomeState {
  const FailedLoginState();

  @override
  List<Object?> get props => [];
}

class RegisteringServicesState extends HomeState {
  @override
  List<Object?> get props => [];
}

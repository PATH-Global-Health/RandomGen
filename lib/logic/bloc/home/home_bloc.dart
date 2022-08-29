import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/services/authentication.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthenticationService _auth;

  HomeBloc(this._auth) : super(RegisteringServicesState()) {
    on<LoginEvent>((event, emit) async {
      final user = await _auth.authenticateUser(event.username, event.password);
      if (user != null) {
        emit(SuccessfulLoginState(user));
        // for successive login requests
        emit(const HomeInitial());
      }
    });

    // initialize database to add a default user
    on<RegisterServiceEvent>((event, emit) async {
      await _auth.init();

      emit(const HomeInitial());
    });
  }
}

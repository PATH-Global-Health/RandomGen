import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/services/authentication.dart';
import '../../../data/services/place.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthenticationService _auth;
  final PlaceService _place;

  HomeBloc(this._auth, this._place) : super(RegisteringServicesState()) {
    on<LoginEvent>((event, emit) async {
      final user = await _auth.authenticateUser(event.username, event.password);
      if (user != null) {
        emit(SuccessfulLoginState(user));
        // for successive login requests
        emit(const HomeInitial());
      } else {
        emit(const FailedLoginState());
      }
    });

    // initialize database to add a default user
    on<RegisterServiceEvent>((event, emit) async {
      await _auth.init();
      await _place.init();

      emit(const HomeInitial());
    });
  }
}

part of 'place_bloc.dart';

abstract class PlaceEvent extends Equatable {
  const PlaceEvent();
}

class LoadPlacesEvent extends PlaceEvent {
  final String username;

  const LoadPlacesEvent(this.username);

  @override
  List<Object> get props => [username];
}

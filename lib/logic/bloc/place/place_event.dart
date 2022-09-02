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

class AddPlaceEvent extends PlaceEvent {
  final String name;
  final int maxLimit;
  final int sampleSize;
  final String username;

  const AddPlaceEvent(this.name, this.maxLimit, this.sampleSize, this.username);

  @override
  List<Object?> get props => [name, maxLimit, sampleSize];
}

class TooglePlaceEvent extends PlaceEvent {
  final int key;
  final String username;

  const TooglePlaceEvent(this.key, this.username);

  @override
  List<Object?> get props => [key, username];
}

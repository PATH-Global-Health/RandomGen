part of 'place_bloc.dart';

abstract class PlaceState extends Equatable {
  const PlaceState();
}

class PlaceInitial extends PlaceState {
  @override
  List<Object> get props => [];
}

class PlacesLoadedState extends PlaceState {
  final List<Place> places;

  const PlacesLoadedState(this.places);

  @override
  List<Object> get props => [places];
}

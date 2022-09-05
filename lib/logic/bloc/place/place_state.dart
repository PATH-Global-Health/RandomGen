part of 'place_bloc.dart';

abstract class SampleState extends Equatable {
  const SampleState();
}

class PlaceInitial extends SampleState {
  @override
  List<Object> get props => [];
}

class PlacesLoadedState extends SampleState {
  final List<Place> places;

  const PlacesLoadedState(this.places);

  @override
  List<Object> get props => [places];
}

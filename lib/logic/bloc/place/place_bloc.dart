import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/place.dart';
import '../../../data/services/place.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlaceService _placeService;

  PlaceBloc(this._placeService) : super(PlaceInitial()) {
    on<LoadPlacesEvent>((event, emit) {
      final places = _placeService.getPlaces(event.username);

      emit(PlacesLoadedState(places));
    });

    on<AddPlaceEvent>((event, emit) {
      _placeService.addPlace(
          event.name, event.username, event.maxLimit, event.sampleSize);

      add(LoadPlacesEvent(event.username));
    });
  }
}

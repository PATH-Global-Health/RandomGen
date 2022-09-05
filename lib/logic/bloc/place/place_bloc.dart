import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/place.dart';
import '../../../data/model/sample.dart';
import '../../../data/services/place.dart';
import '../../../data/services/sample.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, SampleState> {
  final PlaceService _placeService;
  final SampleService _sampleService;

  PlaceBloc(this._placeService, this._sampleService) : super(PlaceInitial()) {
    on<LoadPlacesEvent>((event, emit) {
      final places = _placeService.getPlaces(event.username);

      emit(PlacesLoadedState(places));
    });

    on<AddPlaceEvent>((event, emit) async {
      var samples = <Sample>[];
      var sampleValues = <int>[];

      Place place = await _placeService.addPlace(
          event.name, event.username, event.maxLimit, event.sampleSize);

      var rng = Random();
      for (var i = 0; i < place.sampleSize; i++) {
        var value = 0;
        while (true) {
          value = rng.nextInt(place.maxLimit) + 1;
          if (sampleValues.contains(value) == false) {
            sampleValues.add(value);
            Sample s = await _sampleService.addSample(value, "-");
            samples.add(s);
            break;
          }
        }
      }

      _sampleService.relateSamples(place, samples);

      add(LoadPlacesEvent(event.username));
    });

    on<TooglePlaceEvent>((event, emit) async {
      await _placeService.tooglePlace(event.key, event.username);
      add(LoadPlacesEvent(event.username));
    });

    on<RemovePlaceEvent>((event, emit) async {
      _placeService.removePlace(event.key, event.username);
      add(LoadPlacesEvent(event.username));
    });
  }
}

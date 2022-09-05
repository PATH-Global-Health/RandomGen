import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:randomgen/data/model/sample.dart';

import '../../../data/services/place.dart';
import '../../../data/services/sample.dart';

part 'sample_event.dart';
part 'sample_state.dart';

class SampleBloc extends Bloc<SampleEvent, SampleState> {
  final PlaceService _placeService;
  final SampleService _sampleService;

  SampleBloc(this._placeService, this._sampleService) : super(SampleInitial()) {
    on<LoadSamplesEvent>((event, emit) {
      final samples = _placeService.getRelatedSamples(event.sampleId);

      emit(SamplesLoadedState(samples));
    });
  }
}

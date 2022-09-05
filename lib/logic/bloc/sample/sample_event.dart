part of 'sample_bloc.dart';

abstract class SampleEvent extends Equatable {
  const SampleEvent();

  @override
  List<Object> get props => [];
}

class LoadSamplesEvent extends SampleEvent {
  final int placeId;

  const LoadSamplesEvent(this.placeId);

  @override
  List<Object> get props => [placeId];
}

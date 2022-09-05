part of 'sample_bloc.dart';

abstract class SampleEvent extends Equatable {
  const SampleEvent();

  @override
  List<Object> get props => [];
}

class LoadSamplesEvent extends SampleEvent {
  final int sampleId;

  const LoadSamplesEvent(this.sampleId);

  @override
  List<Object> get props => [sampleId];
}

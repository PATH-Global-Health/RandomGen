part of 'sample_bloc.dart';

abstract class SampleState extends Equatable {
  const SampleState();
}

class SampleInitial extends SampleState {
  @override
  List<Object> get props => [];
}

class SamplesLoadedState extends SampleState {
  final List<Sample> samples;

  const SamplesLoadedState(this.samples);

  @override
  List<Object> get props => [samples];
}

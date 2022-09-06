import 'package:hive/hive.dart';

import '../model/place.dart';
import '../model/sample.dart';

class SampleService {
  late Box<Sample> _sample;

  Future<void> init() async {
    Hive.registerAdapter(SampleAdapter());
    _sample = await Hive.openBox<Sample>('samples');
  }

  void relateSamples(Place place, List<Sample> samples) {
    place.samples = HiveList<Sample>(_sample);

    place.samples!.addAll(samples);
    place.save();
  }

  Future<Sample> addSample(int sample, String name) async {
    var s = Sample(sample, name, false);
    await _sample.add(s);
    return s;
  }

  void updateSample(int sampleId, String name) async {
    final sampleToEdit =
        _sample.values.firstWhere((element) => element.key == sampleId);
    sampleToEdit.name = name;
    await _sample.put(sampleId, sampleToEdit);
  }

  Future<void> toogleSample(final int sampleId) async {
    final sampleToEdit =
        _sample.values.firstWhere((element) => element.key == sampleId);
    sampleToEdit.completed = !sampleToEdit.completed;

    await _sample.put(sampleId, sampleToEdit);
  }
}

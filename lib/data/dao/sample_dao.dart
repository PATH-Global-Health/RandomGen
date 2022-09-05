import 'dart:convert';

class SampleDAO {
  final int? sampleId;
  final String? name;
  final int? sample;
  final bool? complete;
  final int? placeId;

  SampleDAO(
      {this.sampleId, this.sample, this.name, this.complete, this.placeId});

  String toJson() {
    return jsonEncode({
      if (sampleId != null) 'sampleId': sampleId,
      if (sample != null) 'sample': sample,
      if (name != null) 'name': name,
      if (complete != null) 'complete': complete,
      if (placeId != null) 'placeId': placeId,
    });
  }

  factory SampleDAO.fromJson(String data) {
    final sample = jsonDecode(data);

    return SampleDAO(
        sampleId: sample['sampleId'] as int?,
        sample: sample['sample'] as int?,
        name: sample['name'] as String?,
        complete: sample['complete'] as bool?,
        placeId: sample['placeId'] as int?);
  }
}

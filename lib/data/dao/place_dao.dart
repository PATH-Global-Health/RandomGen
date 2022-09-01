import 'dart:convert';

class PlaceDAO {
  final String? name;
  final String? username;
  final int? maxLimit;
  final int? sampleSize;

  PlaceDAO({this.username, this.name, this.maxLimit, this.sampleSize});

  String toJson() {
    return jsonEncode({
      if (name != null) 'name': name,
      if (username != null) 'username': username,
      if (maxLimit != null) 'maxLimit': maxLimit,
      if (sampleSize != null) 'sampleSize': sampleSize
    });
  }

  factory PlaceDAO.fromJson(String data) {
    final place = jsonDecode(data);

    return PlaceDAO(
        name: place['name'] as String?,
        username: place['username'] as String?,
        maxLimit: place['maxLimit'] as int?,
        sampleSize: place['sampleSize'] as int?);
  }
}

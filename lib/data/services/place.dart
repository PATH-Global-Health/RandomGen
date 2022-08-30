import 'package:hive/hive.dart';

import '../model/place.dart';

class PlaceService {
  late Box<Place> _places;

  Future<void> init() async {
    Hive.registerAdapter(PlaceAdapter());
    _places = await Hive.openBox<Place>('places');
  }

  List<Place> getPlaces(final String username) {
    final places = _places.values.where((element) => element.user == username);

    return places.toList();
  }

  void addPlace(
      final String name, final String username, int maxLimit, int sampleSize) {
    _places.add(Place(username, name, false, maxLimit, sampleSize));
  }

  void removePlace(final String name, final String username) async {
    final placeToRemove = _places.values.firstWhere(
        (element) => element.name == name && element.user == username);
    await placeToRemove.delete();
  }

  Future<void> updatePlace(
      final String name, final String username, int maxLimit, sampleSize,
      {final bool? completed}) async {
    final placeToEdit = _places.values.firstWhere(
        (element) => element.name == name && element.user == username);
    final index = placeToEdit.key as int;
    await _places.put(
        index,
        Place(username, name, completed ?? placeToEdit.completed, maxLimit,
            sampleSize));
  }
}

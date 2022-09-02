import 'package:hive/hive.dart';

import '../model/place.dart';

class PlaceService {
  late Box<Place> _places;

  Future<void> init() async {
    Hive.registerAdapter(PlaceAdapter());
    _places = await Hive.openBox<Place>('places');
  }

  List<Place> getPlaces(final String username) {
    final places =
        _places.values.where((element) => element.user == username).toList();
    places.sort((a, b) => a.completed == false ? 0 : 1);

    return places;
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

  Future<void> updatePlace(final int key, final String name,
      final String username, final int maxLimit, final int sampleSize,
      {final bool? completed}) async {
    final placeToEdit = _places.values.firstWhere(
        (element) => element.key == key && element.user == username);
    await _places.put(
        key,
        Place(username, name, completed ?? placeToEdit.completed, maxLimit,
            sampleSize));
  }

  Future<void> tooglePlace(final int key, final String username) async {
    final placeToEdit = _places.values.firstWhere(
        (element) => element.key == key && element.user == username);

    await _places.put(
        key,
        Place(placeToEdit.user, placeToEdit.name, !placeToEdit.completed,
            placeToEdit.maxLimit, placeToEdit.sampleSize));
  }
}
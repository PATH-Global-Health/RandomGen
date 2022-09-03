import 'package:hive/hive.dart';

part 'place.g.dart';

@HiveType(typeId: 2)
class Place extends HiveObject {
  @HiveField(0)
  String user;
  @HiveField(1)
  String name;
  @HiveField(2)
  bool completed;
  @HiveField(3)
  int maxLimit;
  @HiveField(4)
  int sampleSize;
  @HiveField(5)
  HiveList? samples;

  Place(this.user, this.name, this.completed, this.maxLimit, this.sampleSize);
}

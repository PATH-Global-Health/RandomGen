import 'package:hive/hive.dart';

part 'place.g.dart';

@HiveType(typeId: 2)
class Place extends HiveObject {
  @HiveField(0)
  final String user;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool completed;
  @HiveField(3)
  final int maxLimit;
  @HiveField(4)
  final int sampleSize;

  Place(this.user, this.name, this.completed, this.maxLimit, this.sampleSize);
}

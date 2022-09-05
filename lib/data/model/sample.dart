import 'package:hive/hive.dart';

part 'sample.g.dart';

@HiveType(typeId: 3)
class Sample extends HiveObject {
  @HiveField(0)
  int sample;
  @HiveField(1)
  String name;
  @HiveField(2)
  bool completed;

  Sample(this.sample, this.name, this.completed);
}

import 'package:hive/hive.dart';

part 'sample.g.dart';

@HiveType(typeId: 3)
class Sample extends HiveObject {
  @HiveField(0)
  final int sample;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool completed;

  Sample(this.sample, this.name, this.completed);
}

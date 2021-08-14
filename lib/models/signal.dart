import 'package:hive/hive.dart';

part 'signal.g.dart';

@HiveType(typeId: 0)
class Signal extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String signalGroup;

  @HiveField(2)
  late String type;

  @HiveField(3)
  late String alias;

  @HiveField(4)
  late String comment;
}

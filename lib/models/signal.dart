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
  late String valueType;

  @HiveField(4)
  late String delayON;

  @HiveField(5)
  late String delayOFF;

  @HiveField(6)
  late String deadBand;

  @HiveField(7)
  late String alias;

  @HiveField(8)
  late String comment;
}

import 'package:hive/hive.dart';

part 'log_check_in.g.dart';

@HiveType(typeId: 1)
class LogCheckIn extends HiveObject{

  @HiveField(0)
  late String position;

  @HiveField(2)
  late double distance;

  @HiveField(3)
  late bool isCheckIn;

  @HiveField(4)
  late String checkInAt;

  static String name = "logCheckIn";
}

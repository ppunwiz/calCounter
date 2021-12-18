import 'package:hive/hive.dart';

import '../food/food.dart';
part 'calories.g.dart';

@HiveType(typeId: 2)
class Calories {
  @HiveField(0)
  String id;
  @HiveField(1)
  String user_id;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  double kCalTaken;

  Calories({this.id, this.user_id, this.date, this.kCalTaken});
}
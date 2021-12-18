import 'package:cal_counter/model/food/food.dart';
import 'package:hive/hive.dart';
part 'record.g.dart';

@HiveType(typeId: 3)
class Record {
  @HiveField(0)
  String id;
  @HiveField(1)
  String userId;
  @HiveField(2)
  List<Food> foods;
  @HiveField(3)
  double kCals;
  @HiveField(4)
  DateTime timestamp;

  Record({this.id, this.userId, this.foods, this.kCals, this.timestamp});
}
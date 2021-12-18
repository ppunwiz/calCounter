import 'package:hive/hive.dart';
part 'food.g.dart';

@HiveType(typeId: 0)
class Food {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  double kCal;

  Food({this.id, this.name, this.kCal});
}
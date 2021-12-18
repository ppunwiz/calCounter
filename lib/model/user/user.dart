import 'package:date_time_picker/date_time_picker.dart';
import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  String id;
  @HiveField(1)
  String email;
  @HiveField(2)
  String password;
  @HiveField(3)
  String name;
  @HiveField(4)
  DateTime birthdate;
  @HiveField(5)
  String gender;
  @HiveField(6)
  double maxKCal;

  User({this.id, this.email, this.name, this.birthdate, this.gender, this.maxKCal,this.password});
}
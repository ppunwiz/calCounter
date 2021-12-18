import 'package:hive/hive.dart';
part 'is_login.g.dart';

@HiveType(typeId: 4)
class isLogin {
  @HiveField(0)
  String userId;
  @HiveField(1)
  bool login;
  @HiveField(2)
  String deviceId;

  isLogin({this.userId, this.login, this.deviceId});
}




import 'package:device_farm_demo/src/models/hive/user.dart';
import 'package:hive/hive.dart';

part 'person.g.dart';

@HiveType(typeId: 0)
class Person extends HiveObject
{
  @HiveField(0)
  String userid;
  @HiveField(1)
  DateTime dateTime;
  @HiveField(2)
  List<UserDetail> userDetail;

 Person({this.userid, this.dateTime,this.userDetail});


 @override
  String toString() {
    // TODO: implement toString
    return '$userid $dateTime $userDetail';
  }

}


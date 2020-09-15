





import 'package:device_farm_demo/src/models/hive/artifects/artifectfile.dart';

class MyFile
{
  String userId;
  List<ArtifectFile> takeFirst;
  List<ArtifectFile> takeSecond;
  List<ArtifectFile> takeThird;
  List<ArtifectFile> takeFour;
  bool isExpanded=false;

  MyFile({this.userId,this.takeFirst,this.takeSecond,this.takeThird,this.takeFour,this.isExpanded});
}
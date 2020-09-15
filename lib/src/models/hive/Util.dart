



import 'package:device_farm_demo/src/models/artifect_capture_detail/MyFile.dart';
import 'package:hive/hive.dart';



import 'artifects/artifectfile.dart';

class Util {
  static const String DATA_BASE_NAME = 'artifect_box';
  static const String ARTIFECT_USER_TABLE = 'Artifects';
  static const String ARTIFECT_FILE_TABLE = 'Artifect_user';

  static Future<bool> loginUserStatus() async {


    return false;
  }

  static Future<void> storeLoginUserDetail(String userId) async {


    Future;
  }

  static Future<List<String>> getStoreUserList() async {

  }

  static Future<void> storeArtifectFileDetails(
      String userId, List<ArtifectFile> file) async {
    Box box = await Hive.openBox(DATA_BASE_NAME);

    //There is any entry for user
    var storeUserList = box.get(ARTIFECT_USER_TABLE);

    List<String> artifectUser;
    if (storeUserList == null) {
      artifectUser = List<String>();
    } else {
      artifectUser = storeUserList.cast<String>();
    }

    if (!artifectUser.contains(userId)) {
      artifectUser.add(userId);

      box.put(ARTIFECT_USER_TABLE, artifectUser);
    }

    //store take files
    var storeArtifectList = box.get(ARTIFECT_FILE_TABLE);

    List<ArtifectFile> list;
    if (storeArtifectList == null) {
      list = List();
    } else {
      list = storeArtifectList.cast<ArtifectFile>();
    }

    file.forEach((element) {
      list.add(element);
    });

    box.put(ARTIFECT_FILE_TABLE, list);
    Future;

    //getArtifectFileDetails();
  }

  static Future< List<MyFile>> getArtifectFileDetails() async {
    Box box = await Hive.openBox(DATA_BASE_NAME);

    var userList = box.get(ARTIFECT_USER_TABLE);
    List<String> storeUser = List();
    if (userList != null) {
      storeUser = userList.cast<String>();
    }

    var storeArtifectList = box.get(ARTIFECT_FILE_TABLE);

    List<ArtifectFile> fileList = List();
    if (storeArtifectList != null) {
      fileList = storeArtifectList.cast<ArtifectFile>();
    }

    List<MyFile> myFiles = List();
    storeUser.forEach((element1)
    {



      List<ArtifectFile> takeFirst=List();
      List<ArtifectFile> takeSecond=List();
      List<ArtifectFile> takeThird=List();
      List<ArtifectFile> takeFour =List();


      fileList.forEach((element)
      {
        if (element1 == element.userId)
        {


          switch (element.artifectNumber) {
            case "1":
              takeFirst.add(element);
              break;
            case "2":
              takeSecond.add(element);
              break;

            case "3":
              takeThird.add(element);
              break;

            case "4":
              takeFour.add(element);
              break;
          }
        }
      });

      var myFile = MyFile(userId: element1,takeFirst: takeFirst,takeSecond: takeSecond,takeThird: takeThird,takeFour: takeFour,isExpanded: false);
      myFiles.add(myFile);

    });
    return myFiles;
  }

  static Future<List<String>> getArtifectUserDetails() async {
    Box box = await Hive.openBox(DATA_BASE_NAME);

    var userList = box.get(ARTIFECT_USER_TABLE);

    List<String> storeUser = List();
    if (userList != null) {
      storeUser = userList.cast<String>();
    }
    return storeUser;
  }
}

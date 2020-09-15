import 'package:device_farm_demo/util/camera_ID/camera_id.dart';
import 'package:device_farm_demo/util/camera_ID/shared/widgets/focus_widget.dart';
import 'package:flutter/material.dart';






class LogRegCamera extends StatefulWidget {

  final String title;
  final String shape;

  const LogRegCamera ({ Key key, this.title , this.shape}): super(key: key);


  @override
  _LogRegCameraState createState() => _LogRegCameraState();



}

class _LogRegCameraState extends State<LogRegCamera> {





  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:  AppBar(
        elevation: 1,
        title:
        Center(child: Text(
          widget.title,
          style: TextStyle(color: Colors.grey),
        ) ,),
      ),

      body:CameraID(
        mode: CameraMode1.normal,
        //initialCamera: CameraSide.front,
        //enableCameraChange: false,
        //  orientationEnablePhoto: CameraOrientation.landscape,
        onChangeCamera: (direction, _) {
          print('--------------');
          print('$direction');
          print('--------------');
        },

        imageMask: Imagemask(),
      ),




    );
  }

  Widget Imagemask(){

    if(widget.shape.compareTo("circle")==0){


      return CameraFocusID.circle(
        color: Colors.black.withOpacity(0.5),
      );
    }
 else{

   return  CameraFocusID.square(
     color: Colors.black.withOpacity(0.5),
   );


    }


  }



}
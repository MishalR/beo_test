import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';





import 'package:device_farm_demo/src/models/hive/Util.dart';
import 'package:device_farm_demo/src/models/hive/artifects/artifectfile.dart';
import 'package:device_farm_demo/src/ui/logreg_camera.dart';
import 'package:device_farm_demo/util/compressor/ImageCompressor.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_image_crop/simple_image_crop.dart';


import '../camera/camera.dart';
import '../camera/shared/widgets/orientation_icon.dart';

import 'bloc/bloc_camera.dart';
import 'shared/widgets/orientation_icon.dart';
import 'shared/widgets/rotate_icon.dart';

enum CameraOrientation { landscape, portrait, all }
enum CameraMode1 { fullscreen, normal }
enum CameraSide1 { front, back }

class CameraID extends StatefulWidget {
  final Widget imageMask;
  final CameraMode1 mode;
  final Widget warning;
  final CameraOrientation orientationEnablePhoto;
  //final Function(File image) onFile;
  final bool enableCameraChange;
  final CameraSide1 initialCamera;


  final Function(CameraLensDirection direction, List<CameraDescription> cameras)
      onChangeCamera;
  const CameraID({
    Key key,
    this.imageMask,
    this.mode = CameraMode1.normal,
    this.orientationEnablePhoto = CameraOrientation.all,
    //this.onFile,
    this.warning,
    this.onChangeCamera,
    this.initialCamera = CameraSide1.back,
    this.enableCameraChange = true,
  }) : super(key: key);
  @override
  _CameraIDState createState() => _CameraIDState();
}

class _CameraIDState extends State<CameraID> {
  var bloc = BlocCameraID();
  var previewH;
  var previewW;
  var screenRatio;
  var previewRatio;
  Size tmp;
  Size sizeImage;

  @override
  void initState() {
    super.initState();
    bloc.getCameras();
    bloc.cameras.listen((data) {
      bloc.controllCamera = CameraController(
        data[0],
        ResolutionPreset.high,
      );
      bloc.cameraOn.sink.add(0);
      bloc.controllCamera.initialize().then((_) {
        bloc.selectCamera.sink.add(true);
        if (widget.initialCamera == CameraSide.front) bloc.changeCamera();
      });
    });
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
    bloc.dispose();
  }

  void _changeCamera() async {
    await bloc.changeCamera();

    if (widget.onChangeCamera != null) {
      widget.onChangeCamera(
        bloc.controllCamera.description.lensDirection,
        bloc.cameras.value,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Size sizeImage = size;
    double width = size.width;
    double height = size.height;

    onfile(file) {
      print("-----------skjhfhjafhjasjfhahjkfahkjhjkasfhjasfjkhakjfhkjh");
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed('crop_page', arguments: {'image': file});
    }

    return NativeDeviceOrientationReader(
      useSensor: true,
      builder: (context) {
        NativeDeviceOrientation orientation =
            NativeDeviceOrientationReader.orientation(context);

        _buttonPhoto() => CircleAvatar(
              child: IconButton(
                icon: OrientationWidgetID(
                  orientation: orientation,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  sizeImage = MediaQuery.of(context).size;
                  bloc.onTakePictureButtonPressed();
                },
              ),
              backgroundColor: Colors.grey,
              radius: 25.0,
            );

        Widget _getButtonPhoto() {
          if (widget.orientationEnablePhoto == CameraOrientation.all) {
            return _buttonPhoto();
          } else if (widget.orientationEnablePhoto ==
              CameraOrientation.landscape) {
            if (orientation == NativeDeviceOrientation.landscapeLeft ||
                orientation == NativeDeviceOrientation.landscapeRight)
              return _buttonPhoto();
            else
              return Container(
                width: 0.0,
                height: 0.0,
              );
          } else {
            if (orientation == NativeDeviceOrientation.portraitDown ||
                orientation == NativeDeviceOrientation.portraitUp)
              return _buttonPhoto();
            else
              return Container(
                width: 0.0,
                height: 0.0,
              );
          }
        }

        if (orientation == NativeDeviceOrientation.portraitDown ||
            orientation == NativeDeviceOrientation.portraitUp) {
          sizeImage = Size(width, height);
        } else {
          sizeImage = Size(height, width);
        }

        return Scaffold(
          backgroundColor: Colors.grey,
          body: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Stack(
              children: <Widget>[
                Center(
                  child: StreamBuilder<File>(
                      stream: bloc.imagePath.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return OrientationWidgetID(
                            orientation: orientation,
                            child: SizedBox(
                              height: sizeImage.height,
                              width: sizeImage.height,
                              child: Image.file(snapshot.data,
                                  fit: BoxFit.contain),
                            ),
                          );
                        } else {
                          return Stack(
                            children: <Widget>[
                              Center(
                                child: StreamBuilder<bool>(
                                    stream: bloc.selectCamera.stream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data) {
                                          previewRatio = bloc
                                              .controllCamera.value.aspectRatio;

                                          return widget.mode ==
                                                  CameraMode1.normal
                                              ? OverflowBox(
                                                  maxHeight: size.height,
                                                  maxWidth: size.height *
                                                      previewRatio,
                                                  child: CameraPreview(
                                                      bloc.controllCamera),
                                                )
                                              : AspectRatio(
                                                  aspectRatio: bloc
                                                      .controllCamera
                                                      .value
                                                      .aspectRatio,
                                                  child: CameraPreview(
                                                      bloc.controllCamera),
                                                );
                                        } else {
                                          return Container();
                                        }
                                      } else {
                                        return Container();
                                      }
                                    }),
                              ),
                              Padding(padding: EdgeInsets.only(top:5.0,right:10.0),
                               child: Align(                               
                                 alignment: Alignment.topRight,
                                 child: CircleAvatar(
                                        child: IconButton(
                                          icon: OrientationWidget(
                                            orientation: orientation,
                                            child: Icon( Icons.flash_on,
                                                color: Colors.white),
                                          ),
                                          onPressed: () {
                                           // controller.toggleFlash();
                                          //  TorchCompat.turnOn();
                                             // _turnFlash();
                                          },
                                        ),
                                        backgroundColor: Colors.grey,
                                        radius: 25.0,
                                      ),
                                ),
                              ),
                              if (widget.imageMask != null)
                                Center(
                                  child: widget.imageMask,
                                ),
                            ],
                          );
                        }
                      }),
                ),
                if (widget.mode == CameraMode1.normal)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: StreamBuilder<Object>(
                          stream: bloc.imagePath.stream,
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? SimpleCropRouteID(
                                    imgfile: bloc.imagePath.value,
                                  )
                               
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      CircleAvatar(
                                        child: IconButton(
                                          icon: OrientationWidgetID(
                                            orientation: orientation,
                                            child: Icon(Icons.arrow_back_ios,
                                                color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        backgroundColor: Colors.grey,
                                        radius: 25.0,
                                      ),
                                      _getButtonPhoto(),
                                      (widget.enableCameraChange)
                                          ? CircleAvatar(
                                              child: RotateIconID(
                                                child: OrientationWidgetID(
                                                  orientation: orientation,
                                                  child: Icon(
                                                    Icons.cached,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                onTap: () => _changeCamera(),
                                              ),
                                              backgroundColor: Colors.grey,
                                              radius: 25.0,
                                            )
                                          : CircleAvatar(
                                              child: Container(),
                                              backgroundColor:
                                                  Colors.transparent,
                                              radius: 25.0,
                                            ),
                                    ],
                                  );
                          }),
                    ),
                  )
              ],
            ),
          ),
           );
      },
    );
  }
}

class SimpleCropRouteID extends StatefulWidget {
  final File imgfile;
  


  const SimpleCropRouteID({Key key, this.imgfile}) : super(key: key);
  @override
  _SimpleCropRouteIDState createState() => _SimpleCropRouteIDState();
}

class _SimpleCropRouteIDState extends State<SimpleCropRouteID> {
 
  SharedPreferences prefs;
  File croppedFileID;
  
  String capturecandidate64='';
  String base64ImageID ;
 
  final cropKey1 = GlobalKey<ImgCropState>();
  BuildContext context;

  static int ccount=0;
  @override
  void initState(){
  }

  Future<Null> showImage( File file) async {
 
    new FileImage(file)
        .resolve(new ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      print('-------------------------------------------$info');
    }));
  //  print(captureCandidate.candidate);

    prefs = await SharedPreferences.getInstance();
    
    capturecandidate64 = prefs.getString('candidateBase64');            //get candidate image
    Uint8List bytescan = base64.decode(capturecandidate64);

     List<int> imageBytes = file.readAsBytesSync();
     base64ImageID = base64Encode(imageBytes);
     Uint8List bytesID = base64.decode(base64ImageID);                  //convert id proof to base64

       prefs = await SharedPreferences.getInstance();
       prefs.setString('IdBase64', base64ImageID);                        // save id proof image

    ArtifectFile artifectFile = ArtifectFile(
        artifectNumber: "1",
        file: base64ImageID,
        filePath: file.path,
        status:'None',
        userId: '1'

    );

    List<ArtifectFile> myList=List();
    myList.add(artifectFile);
    Util.storeArtifectFileDetails('1',myList);


   
          
                   
    
   
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;
    this.context = context;
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text(
            'Confirm',
            style: TextStyle(color: Colors.grey),
          ),
          backgroundColor: Colors.blueGrey,
          leading: new IconButton(
            icon:
                new Icon(Icons.navigate_before, color: Colors.grey, size: 40),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body:
        Stack(
          children: <Widget>[


        Center(
        child: ImgCrop(
          key: cropKey1,
          chipRadius: 130,
          chipShape: 'rect',
          maximumScale: 3,
          image: FileImage(widget.imgfile),
        ),




    ),

        Align(
        alignment: Alignment.bottomCenter,
          child: RaisedButton(
            onPressed: () async {
              final crop = cropKey1.currentState;
              croppedFileID =
              await crop.cropCompleted(widget.imgfile, pictureQuality: 600);

              imageCompressor(croppedFileID, showImage);


              if(ccount==0) {
                ccount++;
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => LogRegCamera(title: "Id Card Photo", shape:"square"),


                  ),
                );

                Navigator.of(context).pop();
              }

              else{
                Navigator.of(context).pop();

              }

            },
            child: const Text('Next', style: TextStyle(fontSize: 20)),
            color: Colors.blue,
            textColor: Colors.white,
            elevation: 5,
          ),
        ),



          ],


        ),









      /*  floatingActionButton: FloatingActionButton(
          backgroundColor: LightColors.kBlue,
          onPressed: () async {
            final crop = cropKey1.currentState;
             croppedFileID =
                await crop.cropCompleted(widget.imgfile, pictureQuality: 600);

            imageCompressor(croppedFileID, showImage);


            if(ccount==0) {
              ccount++;
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => LoginCamera(title: "User Id"),

                ),
              );

              Navigator.of(context).pop();
            }

            else{
              Navigator.of(context).pop();

            }
             
          },
       
          tooltip: 'Done',
          child:  Icon(Icons.crop,size: 25,color: LightColors.white,),
        )*/



    );
  }
}

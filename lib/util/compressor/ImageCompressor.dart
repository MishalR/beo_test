



import 'dart:io';



import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:path/path.dart' as path;

import 'image_extension.dart';


File previousPath;
int minimumSize = 35840; //iN KB
int compressorPercentage = 85;
int compressorQality = 85;


Future<void> imageCompressor(File croppedFile,Function setImage )
async {

  /**
   * Not perform compressor for small size image
   */
  if(croppedFile.lengthSync()<=minimumSize)
    {
      attachImage(croppedFile,setImage);
      return;
    }
  applyCompressor(croppedFile,setImage);

}

void applyCompressor(File croppedFile, Function setImage)async
{
  previousPath = croppedFile;
  await FlutterNativeImage.compressImage(croppedFile.path, percentage:compressorPercentage,quality: compressorQality
  ).then((value)
  async {
    //remove Previous cropp value
    bool isExist = await previousPath.exists();

     if(isExist)
      {
        previousPath.delete();
      }
     if(value.lengthSync()>minimumSize)
      {
        applyCompressor(value,setImage);
      }else
        {
          attachImage(value,setImage);

        }

  });

}


void attachImage(File value,Function setImage) async
{

  //change compress file location
  var localPath = await ImageExtension.instance.createFolder(TargetPlatform.android);
  String fileName =  path.basenameWithoutExtension(value.path);
  List<String>  extension =  path.basename(value.path).split(fileName+'.');

  String name = new DateTime.now().millisecond.toString();
  String newPath =localPath+'Cropper'+name+'.'+ImageExtension.instance.getAppSpecificExtension(extension[1]);

  File renamePath = await value.rename(File(newPath).path);

  //change Extension

  setImage(renamePath);


}
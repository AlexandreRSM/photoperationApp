import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_camera_app/bloc/photo_app_state.dart';
import 'package:camera/camera.dart'; 

class PhotoAppCubit extends Cubit<PhotoAppState> {
  PhotoAppCubit() : super(const StartScreenState()); //initial state
 
  //method to return to menu
  mainMenu() async {
    emit(const StartScreenState());
  }

  //a method to open the camera 
openCamera() async {
    //get available cameras
    final cameras = await availableCameras();

    //get a camera controller
    final cameraController = CameraController(
        cameras.first,
        ResolutionPreset.high,
        imageFormatGroup: ImageFormatGroup.jpeg
    );

    //initialize camera
    await cameraController.initialize();
    emit (CameraState(
        controller: cameraController,
        camera: cameraController.description
    ));
  }      


  //a method to take photo
takePicture() async {
//set the state as CameraState so we can access the controller variable. 
    final currentState = state as CameraState;
    final controller = currentState.controller;

    //take a picture with the given controller
    final rawFile = await controller.takePicture();
    final picture = File(rawFile.path);
    emit (PreviewState(file: picture));
  }      

  //a method to approve the photo
  selectPhoto({
    required File file
  }){
    emit (StartScreenState(file: file));
  }        

  //a method to switch the camera settings
   switchCameraOptions({
    required CameraController cameraController,
    bool? isBackCam,
    ResolutionPreset? resolutionPreset
  }) async {

    final camera = await availableCameras();
    cameraController = CameraController(
        isBackCam == true ? camera.last : camera.first,
        resolutionPreset ?? ResolutionPreset.high
    );

    await cameraController.initialize();
    emit(CameraState(
        controller: cameraController,
        camera: cameraController.description
    ));

  }
       
}      


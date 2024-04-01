import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camera_app/bloc/photo_app_cubit.dart';
import 'package:flutter_camera_app/bloc/photo_app_state.dart';
import 'package:flutter_camera_app/main.dart';

//HomePage
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photoperation',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color.fromRGBO(95, 38, 38, 1),
        ),
      ),
      home: const HomePage(),
    );
  }
}

//InitialScreen
class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoAppCubit, PhotoAppState>(
        builder: (context, state){
          state as StartScreenState;
          return Scaffold(
            appBar: AppBar(
              title: const Text("Photoperation"),
              centerTitle: true,
            ),
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 0,),
                Center(
                  child: Stack(                  
                    children: [
                      getAvatar(state.file),
                      Positioned(
                        bottom: 0,
                        left:  40,
                        height: 130,
                        child: IconButton(
                          onPressed: (){
                            context.read<PhotoAppCubit>().openCamera();
                          },
                          icon: const Icon(Icons.photo_camera_rounded, )
                          ),
                    )
                  ],
              ),
                ),
            ],),
          );
        },
    );
  }
}

CircleAvatar getAvatar(File? displayImage){
  if(displayImage == null){
    return const CircleAvatar(
      radius: 65,
      backgroundImage: AssetImage('assets/avatar.png'),
    );
  } else {
    return CircleAvatar(
      radius: 65,
      backgroundImage: FileImage(displayImage),
    );
  }
}        

//CameraScreen
class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
bool _isBackCamera = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoAppCubit, PhotoAppState>(
        builder: (context, state){
          state as CameraState;
          return CameraPreview(
            state.controller,
            child: Scaffold(
              backgroundColor: Colors.transparent,
                body: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            context.read<PhotoAppCubit>().takePicture();
                          },
                          child: Container(
                            height: 100,
                            width: 70,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        IconButton(
                            color: Colors.white,
                            padding: const EdgeInsets.only(bottom: 25),
                            onPressed: (){
                              setState(() {
                                _isBackCamera = !_isBackCamera;
                              });
                              context.read<PhotoAppCubit>().switchCameraOptions(
                                  isBackCam: _isBackCamera,
                                  cameraController: state.controller,
                               );
                            },
                            icon: const Icon(Icons.cameraswitch)
                        )
                      ],
                    ),
                  ],
                )
            ),
          );
        });
  }
}        

//PreviewScreen
class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoAppCubit, PhotoAppState>(
      builder: (context,state) {
        state as PreviewState;
        return Material(
          child: DecoratedBox(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(state.file!)
                )
              ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    context.read<PhotoAppCubit>().mainMenu();
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    color: Colors.white38,
                    child: const Icon(Icons.cancel_outlined),
                  ),
                ),
                const SizedBox(width: 20,),
                InkWell(
                  onTap: (){
                    context.read<PhotoAppCubit>().openCamera();
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    color: Colors.white38,
                    child: const Icon(Icons.replay),
                  ),
                ),
                const SizedBox(width: 20,),
                InkWell(
                  onTap: (){
                    context.read<PhotoAppCubit>().selectPhoto(file: state.file!);            
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    color: Colors.white38,
                    child: const Icon(Icons.check_outlined),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}   

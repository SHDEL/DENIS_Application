
import 'package:denis/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

class CameraWidget extends StatefulWidget {
  const CameraWidget({super.key});

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: BoxDecoration(
              gradient: AppColors.gradprimary,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.20),
                  blurRadius: 24,
                  spreadRadius: 0,
                  offset: Offset(0, 1),
                )
              ]
            ),
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.videocam,
                    color: Colors.white54,
                    size: 56,
                  ),
                  SizedBox(height: 10),
                  Text('Camera',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

@Preview(name: 'Camera Widget')
Widget cameraWidgetPreview() {
  return const CameraWidget();
}
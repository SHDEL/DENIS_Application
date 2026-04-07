
import 'package:denis/env/env.dart';
import 'package:denis/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
// import 'package:mjpeg_stream/mjpeg_stream.dart';

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
        color: Colors.black,
        borderRadius: BorderRadius.circular(28),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        // ใช้ SizedBox.expand เพื่อบังคับให้ Mjpeg กางเต็มพื้นที่ Container
        child: SizedBox.expand(
          child: Mjpeg(
            stream: "https://denis.zedoexter.xyz/video_feed?token=${Env.jwtToken}",
            // BoxFit.cover จะขยายภาพจนเต็มกรอบ ส่วนที่เกิน (บรรทัดบน/ล่างของ 640x640) จะถูกตัดออก
            fit: BoxFit.contain,
            isLive: true,
            loading: (context) => const Center(
                child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
    
  }
}

@Preview(name: 'Camera Widget')
Widget cameraWidgetPreview() {
  return const CameraWidget();
}
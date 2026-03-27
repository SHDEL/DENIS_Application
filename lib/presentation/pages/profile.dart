import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  double paddingValue = 16.0;
  @override
  Widget build(BuildContext context) {
    if (kIsWeb){
      paddingValue = 48.0;
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(padding: EdgeInsets.all(paddingValue),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 120,
                backgroundImage: AssetImage('assets/image/profile_placeholder.png'),
              ),
              SizedBox(height: 40),
              Text('John Doe', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 40),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04), // เงาบางๆ
                        blurRadius: 16,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildMenuOption('Reserve History'),
                      _buildDivider(),
                      _buildMenuOption('Settings'),
                      _buildDivider(),
                      _buildMenuOption('About'),
                      _buildDivider(),
                      _buildMenuOption('Help  & Supports'),
                    ],
                  ),
                ),
            ]
          )
        ),
      )
    );
  }

   Widget _buildMenuOption(String title) {
    return InkWell(
      onTap: () {
        // TODO: ใส่ Action เมื่อผู้ใช้กดที่นี่
      },
      borderRadius: BorderRadius.circular(24.0), // ให้ effect ตอนกดโค้งตามตัว Card
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4A148C), // สีม่วงเข้มคล้ายในรูป
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }

  // Widget สำหรับสร้างเส้นแบ่ง
  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Divider(
        height: 1,
        thickness: 1,
        color: Colors.grey.shade200, // สีเทาอ่อนๆ สำหรับเส้นคั่น
      ),
    );
  }
}
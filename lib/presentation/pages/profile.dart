import 'package:firebase_auth/firebase_auth.dart';
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
    final User? currentUser = FirebaseAuth.instance.currentUser;
    // อ่านค่า email และนำมาตัด @ ออก เพื่อแสดงเป็นชื่อ
    final String displayName = currentUser?.email?.split('@')[0] ?? 'User';

    if (kIsWeb){
      paddingValue = 48.0;
    }
    
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          // 1. นำ paddingValue มาใช้คลุมเนื้อหาทั้งหมดเพื่อไม่ให้ชิดขอบจอเกินไป
          padding: EdgeInsets.symmetric(horizontal: paddingValue, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.grey[200],
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ), // เหมือนเดิม
                      const SizedBox(height: 16),
                      Text(
                        'Hi, $displayName', // แสดงชื่อตรงนี้
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ), // เหมือนเดิม
                    ],
                  ),
              const SizedBox(height: 32),
              Column(
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
              const SizedBox(height: 32),
              // 2. หุ้มปุ่ม Sign Out ให้อยู่ตรงกลาง และกำหนดความกว้างไม่ให้ยืดเต็มจอ
              Center(
                child: SizedBox(
                  width: 200, // กำหนดความกว้างของปุ่ม
                  child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text('Sign Out', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
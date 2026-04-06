// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denis/main.dart';
import 'package:denis/presentation/widgets/primary_app_button.dart';
void main() {
  testWidgets('PrimaryAppButton displays text and handles tap', (WidgetTester tester) async {
    // 1. ตัวแปรสำหรับจับว่าปุ่มโดนกดไหม
    bool wasPressed = false;

    // 2. สร้าง Widget เสมือนขึ้นมาในกระดานเทส (ต้องมี MaterialApp ครอบเสมอเวลาเทสปุ่ม)
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryAppButton(
            text: 'Click Me',
            onPressed: () {
              wasPressed = true;
            },
          ),
        ),
      ),
    );

    // 3. พิสูจน์ (Expect) ว่าปุ่มมีข้อความ 'Click Me' แสดงอยู่จริงๆ
    expect(find.text('Click Me'), findsOneWidget);

    // 4. สั่งให้บอทเทสเสมือนว่า "เอานิ้วกดลงไปที่เนื้อหา 'Click Me'"
    await tester.tap(find.text('Click Me'));
    
    // สั่งให้จอขยับ/เรนเดอร์เฟรมหลังโดนกด
    await tester.pump();

    // 5. พิสูจน์ว่าฟังก์ชันถูกใช้งาน (wasPressed เปลี่ยนเป็น true)
    expect(wasPressed, true);
  });
}

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:denis/presentation/pages/cart_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/material.dart';
// อย่าลืม import ไฟล์ที่ generate มาจาก data connect ของคุณ
import 'package:denis/dataconnect_generated/generated.dart';
import 'package:http/http.dart' as http;

class SetInstrumentWidget extends StatefulWidget {
  const SetInstrumentWidget({super.key});

  @override
  State<SetInstrumentWidget> createState() => _SetInstrumentWidgetState();
}

class _SetInstrumentWidgetState extends State<SetInstrumentWidget> {
  // สร้าง Future สำหรับดึงข้อมูล
  late Future<QueryResult<GetCategoryCarouselData, void>> _carouselDataFuture;

  @override
  void initState() {
    super.initState();
    // เรียกใช้ Query ที่เราสร้างไว้ในไฟล์ .gql
    _carouselDataFuture = ExampleConnector.instance.getCategoryCarousel().execute();
  }

  Future<void> _addAllToCartAndShowResult(BuildContext context, dynamic category) async {
  // 1. แสดง Loading รอไว้ก่อน
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );

  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      Navigator.pop(context); // ปิด Loading
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please login first')));
      return;
    }

    // 2. เรียก Cloud Functions API
    // เปลี่ยน URL ด้านล่างเป็น URL ของ Cloud Functions จริงๆ ของคุณ
    final String functionUrl = 'https://us-central1-denis-2771b.cloudfunctions.net/addSetToCartApi'; 
    
    final response = await http.post(
      Uri.parse(functionUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': userId,
        'categoryId': category.id,
      }),
    );

    Navigator.pop(context); // ปิด Loading

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      
      if (data['success'] == true) {
        // 3. แสดง Dialog แจ้งเตือนเมื่อกดสำเร็จ ว่าเพิ่มกี่ชิ้น
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Added Set to your cart!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Nunito')),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80, height: 80,
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(16)),
                          child: Center(child: Icon(Icons.category, size: 40, color: Colors.deepPurple.shade300)),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${category.name} Set', style: const TextStyle(color: Colors.deepPurple, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Nunito')),
                              const SizedBox(height: 8),
                              Text('${data['addedCount']} new items added successfully.', style: const TextStyle(fontSize: 14, fontFamily: 'Nunito')),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.deepPurple, width: 2),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            child: const Text('Continue Browse', style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 14)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            child: const Text('View my cart', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed: ${response.body}')));
    }

  } catch (e) {
    Navigator.pop(context); // ปิด Loading เมื่อ Error
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
  }
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QueryResult<GetCategoryCarouselData, void>>(
      future: _carouselDataFuture,
      builder: (context, snapshot) {
        // 1. ระหว่างรอข้อมูล ให้แสดงวงกลมหมุนๆ
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 400.0,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        // 2. ถ้ามี error เกิดขึ้น
        if (snapshot.hasError) {
          return SizedBox(
            height: 400.0,
            child: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        // 3. ดึงข้อมูล Category ออกมาจาก snapshot
        final categories = snapshot.data?.data.instrumentCategories ?? [];

        // ถ้าไม่มีข้อมูลเลย
        if (categories.isEmpty) {
          return const SizedBox(
            height: 400.0,
            child: Center(child: Text('No categories found.')),
          );
        }

        // 4. นำข้อมูลมาวนลูปแสดงใน CarouselSlider
        return CarouselSlider(
          options: CarouselOptions(
            height: 400,
            aspectRatio: 16/9,
            autoPlay: true,
            enlargeCenterPage: true, // ทำให้ภาพตรงกลางใหญ่ขึ้นนิดนึงดูสวยดี
          ),
          items: categories.map((category) {
            // เช็คว่า Category นี้มี Instrument อย่างน้อย 1 อาันไหม จะได้ดึงรูปมาโชว์
            final hasInstruments = category.instruments_on_category.isNotEmpty;
            final imageUrl = hasInstruments ? category.instruments_on_category.first.imageUrl : '';
            print("Category: ${category.name}, ImageUrl: $imageUrl");
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    _addAllToCartAndShowResult(context, category);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    // ป้องกันมุมภาพทะลุขอบมนๆ
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.amber, // สีพื้นหลังเผื่อรูปรอโหลดหรือโหลดไม่ติด
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // เลเยอร์ที่ 1: รูปภาพ
                        if (hasInstruments && imageUrl.isNotEmpty)
                          Container(
                            color: Colors.white, // ให้พื้นหลังหลักเป็นสีขาว (จะได้ไม่เห็นสี amber)
                            child: Center( // จัดตำแหน่งให้อยู่ตรงกลาง
                              child: SizedBox(
                                width: 200,   // <- ปรับขนาดความกว้างของรูปที่นี่
                                height: 200,  // <- ปรับขนาดความสูงของรูปที่นี่
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.contain, // ให้รูปจัดเข้าในกล่อง 200x200 อย่างพอดี
                                  errorBuilder: (context, error, stackTrace) => const Center(
                                    child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        
                        // เลเยอร์ที่ 2: ฟิล์มสีดำและข้อความทับข้างบน
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              category.name,
                              style: const TextStyle(
                                fontSize: 24.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
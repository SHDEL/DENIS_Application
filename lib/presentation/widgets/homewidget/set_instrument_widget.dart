import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/material.dart';
// อย่าลืม import ไฟล์ที่ generate มาจาก data connect ของคุณ
import 'package:denis/dataconnect_generated/generated.dart';

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
                return Container(
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
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
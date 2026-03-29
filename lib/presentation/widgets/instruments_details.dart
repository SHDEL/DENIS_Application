import 'package:denis/presentation/widgets/primary_app_button.dart';
import 'package:flutter/material.dart';

class InstrumentsDetailsWidget extends StatefulWidget {
  const InstrumentsDetailsWidget({super.key});

  @override
  State<InstrumentsDetailsWidget> createState() => _InstrumentsDetailsWidgetState();
}

class _InstrumentsDetailsWidgetState extends State<InstrumentsDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // สีพื้นหลังเทาอ่อนตามในภาพ
      body: SafeArea(
        bottom: false, // ปล่อยให้ Container สีขาวด้านล่างชิดขอบจอ
        child: Column(
          children: [
            // 1. ส่วนหัว (App Bar ด้านบน)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black87),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Text(
                    'Instrument Details',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  const SizedBox(width: 48), // สร้างพื้นที่ว่างเพื่อดันให้ Title อยู่ตรงกลาง
                ],
              ),
            ),
            
            // 2. ส่วนรูปภาพตรงกลาง (จำลองด้วยไอคอนก่อน เนื่องจากไม่มีรูปเครื่องมือจริงๆ)
            Expanded(
              child: Center(
                child: Icon(
                  Icons.content_cut, // จำลองกรรไกร/คีม
                  size: 180,
                  color: Colors.grey.shade400, // สีเทาๆ คล้ายภาพที่มีพื้นหลังโปร่ง
                ),
              ),
            ),

            // 3. ส่วนรายละเอียดด้านล่าง (Bottom Sheet ขาว)
            Container(
              padding: const EdgeInsets.all(32),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // ให้กล่องหดตามเนื้อหาภายใน
                children: [
                  // Title
                  const Text(
                    'Artery Forceps',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Status Row (In Stock, In Use, Sterilize)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatusIndicator(Colors.green, 'In Stock:', '5'),
                      _buildStatusIndicator(Colors.blue, 'In Use:', '5'),
                      _buildStatusIndicator(Colors.red, 'Sterilize:', '5'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Shelf Info
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black87, fontFamily: 'Nunito'),
                      children: [
                        TextSpan(text: 'Shelf: '),
                        TextSpan(
                          text: 'A2',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Category Info
                  Row(
                    children: [
                      const Text(
                        'Category: ',
                        style: TextStyle(fontSize: 16, color: Colors.black87, fontFamily: 'Nunito'),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Surgical',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  
                  // Description Label
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Description Details
                  const Text(
                    'Artery forceps, also known as hemostats or artery clamps, are stainless steel surgical instruments designed to clamp blood vessels and tissues to control bleeding (hemostasis)',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.5,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Button
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryAppButton(
                      onPressed: () {
                        _showAddToCartDialog(context);
                      },
                      text: 'Add to cart',
                    ),
                  ),
                  
                  // เพิ่มระยะห่างสำหรับจอที่มีแถบขีดด้านล่างบน iOS (SafeArea Bottom)
                  SizedBox(height: MediaQuery.of(context).padding.bottom),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // วิดเจ็ตย่อยสำหรับสร้างสถานะ (เช่น In Stock)
  Widget _buildStatusIndicator(Color color, String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontFamily: 'Nunito',
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Nunito',
          ),
        ),
      ],
    );
  }

  // แสดง Modal / Dialog เวลากด Add to cart
  void _showAddToCartDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5), // ทำพื้นหลังสีเทาเบลอแบบในภาพ
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // ให้กล่องพอดีกับเนื้อหา
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Added to your cart!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ส่วนกล่องรูปภาพเครื่องมือ
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.content_cut,
                          size: 60,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // ส่วนข้อมูลเครื่องมือและการปรับจำนวน
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Artery Forceps',
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Shelf A2',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Nunito',
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // ปุ่มปรับจำนวนเพิ่มลด (+ / -)
                          Row(
                            children: [
                              Icon(Icons.remove_circle_outline, color: Colors.red.shade600, size: 28),
                              const SizedBox(width: 16),
                              const Text(
                                '1',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 16),
                              const Icon(Icons.add_circle_outline, color: Colors.deepPurple, size: 28),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // ปุ่ม Action ด้านล่าง 2 ปุ่ม
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context); // ปิด Dialog
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.deepPurple, width: 2),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Continue Browse',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: PrimaryAppButton(
                        onPressed: (){}, 
                        text: "View my cart",
                        padding: const EdgeInsets.symmetric(vertical: 16), // ปรับขนาดความสูงให้พอดีกับปุ่มข้างๆ
                        fontSize: 14, // ลดขนาดตัวหนังสือลงนิดหน่อย
                      )
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
}
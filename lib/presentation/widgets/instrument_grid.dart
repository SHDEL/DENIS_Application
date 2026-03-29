import 'package:flutter/material.dart';

class InstrumentGrid extends StatefulWidget {
  const InstrumentGrid({
    required this.isSelectionMode,
    required this.onSelectionChange,
    required this.selectedList,
    super.key
    });

  final bool isSelectionMode;
  final ValueChanged<bool>? onSelectionChange;
  final List<bool> selectedList;

  @override
  State<InstrumentGrid> createState() => _InstrumentGridState();
}

class _InstrumentGridState extends State<InstrumentGrid> {

  void _toggle(int index) {
    if (widget.isSelectionMode) {
      setState(() {
        widget.selectedList[index] = !widget.selectedList[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6, // เปลี่ยนเป็นแสดงข้อมูลดัมมี่ 6 อันเหมือนใน search_user_widget
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8, // ปรับสัดส่วนให้เหมือน search_user_widget
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (_, int index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                if (widget.isSelectionMode) {
                  _toggle(index);
                } else {
                  print("Item $index Clicked");
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Center(
                        // จำลองรูปภาพดัมมี่ให้เหมือนกัน
                        child: Icon(Icons.cut, size: 50, color: Colors.grey.shade300),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Hemostat',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Shelf A2',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
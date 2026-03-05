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
      itemCount: widget.selectedList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (_, int index) {
        return 
          GridTile(
            child: Container(
              decoration: 
                BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.20),
                      blurRadius: 24,
                      spreadRadius: 0,
                      offset: Offset(0, 1),
                    )
                  ],
                ),
              child:Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                clipBehavior: Clip.hardEdge, // ตัดขอบ Ripple ไม่ให้เกินมุมโค้ง
                child: InkWell(
                  onTap: () {
                    if (widget.isSelectionMode) {
                      _toggle(index);
                    } else {
                      // TODO: ใส่คำสั่งเมื่อกดในโหมดปกติ เช่น เปิดหน้ารายละเอียด
                      print("Item $index Clicked");
                    }
                  },
                  child: Center(
                    child: widget.isSelectionMode
                        ? Checkbox(
                            onChanged: (bool? x) => _toggle(index),
                            value: widget.selectedList[index],
                          )
                        : const Icon(Icons.image),
                  ),
                ),
              ),
            ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:denis/presentation/theme/app_colors.dart';
import 'package:denis/dataconnect_generated/generated.dart';

class InstrumentList extends StatefulWidget {
  const InstrumentList({
    required this.selectedList,
    required this.isSelectionMode,
    required this.onSelectionChange,
    required this.instruments, // เพิ่มพารามิเตอร์นี้
    super.key
  });

  final bool isSelectionMode;
  final List<bool> selectedList;
  final ValueChanged<bool>? onSelectionChange;
  final List<GetAllInstrumentsAndCategoriesInstruments> instruments; // เพิ่มพารามิเตอร์นี้
  @override
  State<InstrumentList> createState() => _InstrumentListState();
}

class _InstrumentListState extends State<InstrumentList> {

  void _toggle(int index) {
    if (widget.isSelectionMode) {
      setState(() {
        widget.selectedList[index] = !widget.selectedList[index];
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.instruments.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          thickness: 1,
          indent: 20,
          endIndent: 20,
          color: Color(0xFFD7D7D7),
        ),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.instruments[index].name, style: TextStyle(fontWeight: FontWeight.bold),),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1), // พื้นหลังสีจาง
                borderRadius: BorderRadius.circular(20), // ขอบมนเป็น Tag
              ),
              child: const Text(
                'Shelf A1',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            // subtitle: Text('Shelf A1', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),),
            
          );
        },
      ),
    );
  }
}

 


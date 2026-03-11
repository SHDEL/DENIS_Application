
import 'package:denis/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

class InstrumentList extends StatefulWidget {
  const InstrumentList({
    required this.selectedList,
    required this.isSelectionMode,
    required this.onSelectionChange,
    super.key
  });

  final bool isSelectionMode;
  final List<bool> selectedList;
  final ValueChanged<bool>? onSelectionChange;

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
  
  final List<String> instruments = [
    "Mouth Mirror",
    "Explorer",
    "Cotton Pliers",
    "Periodontal Probe",
    "Ultrasonic Scaler",
    "Forceps",
    "Syringe",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
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
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: instruments.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          thickness: 1,
          indent: 20,
          endIndent: 20,
          color: Color(0xFFD7D7D7),
        ),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(instruments[index], style: TextStyle(fontWeight: FontWeight.bold),),
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

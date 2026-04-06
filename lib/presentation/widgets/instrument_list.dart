
import 'package:denis/presentation/widgets/instruments_details.dart';
import 'package:flutter/material.dart';
import 'package:denis/presentation/theme/app_colors.dart';
import 'package:denis/dataconnect_generated/generated.dart';

class InstrumentList extends StatefulWidget {
  const InstrumentList({
    required this.selectedList,
    required this.isSelectionMode,
    required this.onSelectionChange,
    required this.instruments, // เพิ่มพารามิเตอร์นี้
    this.detectedCounts,
    required this.userRole,
    super.key
  });

  final bool isSelectionMode;
  final List<bool> selectedList;
  final ValueChanged<bool>? onSelectionChange;
  final List<GetAllInstrumentsAndCategoriesInstruments> instruments;
  final Map<String, int>? detectedCounts;
  final String userRole;
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
          final instrument = widget.instruments[index];
          final shelfText = instrument.stocks_on_instrument.isNotEmpty 
              ? instrument.stocks_on_instrument.first.shelf 
              : 'No Shelf';
          final qty = widget.detectedCounts?[instrument.name] ?? 0; 
          return Material(
            color: Colors.transparent, // ปล่อยให้สีพื้นเป็นใสเพื่อให้เห็นสีขาวของ Container ภายนอก
            child: InkWell(
              onTap: () {
                if (widget.isSelectionMode) {
                  _toggle(index);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InstrumentsDetailsWidget(
                        instrument: instrument,
                        userRole: widget.userRole,
                      ),
                    ),
                  );
                }
              },
              child: ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        instrument.name, 
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1, // บังคับให้มีแค่ 1 บรรทัด
                        overflow: TextOverflow.ellipsis, // ถ้าเกินให้ขึ้น ...
                      ),
                    ),
                    const SizedBox(width: 8),
                    // ถ้าเจอมากกว่า 0 ให้โชว์ป้ายกำกับจำนวน
                    if (qty > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Detected: $qty',
                          style: TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Shelf $shelfText',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

 


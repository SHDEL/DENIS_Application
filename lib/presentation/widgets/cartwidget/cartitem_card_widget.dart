import 'package:flutter/material.dart';

class CartitemCardWidget extends StatefulWidget {
  final int index;
  final String cartItemId;
  final String name;
  final String imageUrl;
  final String shelf;
  final int amount;
  final int inStockQty;
  final Function(int, String) onDelete;
  final Function(int, int, String) onUpdateQuantity;
  
  const CartitemCardWidget({
    super.key,
    required this.index,
    required this.cartItemId,
    required this.name,
    required this.imageUrl,
    required this.shelf,
    required this.amount,
    required this.inStockQty,
    required this.onDelete,
    required this.onUpdateQuantity
  });

  @override
  State<CartitemCardWidget> createState() => _CartitemCardWidgetState();
}

class _CartitemCardWidgetState extends State<CartitemCardWidget> {
  bool _isDeleting = false;

  void _handleDelete() async {
    if (_isDeleting) return;
    setState(() {
      _isDeleting = true;
    });
    try {
      await widget.onDelete(widget.index, widget.cartItemId);
    } catch (_) {
      // Parent handles or logs error
    } finally {
      if (mounted) {
        setState(() {
          _isDeleting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isDeleting ? 0.4 : 1.0,
      duration: const Duration(milliseconds: 200),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // กล่องรูปภาพกรรไกร
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Center(
              child: widget.imageUrl.isNotEmpty
                  ? Image.network(widget.imageUrl, fit: BoxFit.contain)
                  : Icon(Icons.content_cut, size: 45, color: Colors.grey.shade400,),
            ),
          ),
          const SizedBox(width: 20),
          // ข้อมูลของไอเท็ม
          Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.name,
                      style: const TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                  _isDeleting
                      ? const SizedBox(
                          width: 32,
                          height: 32,
                          child: Padding(
                            padding: EdgeInsets.all(6.0),
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.redAccent,
                            ),
                          ),
                        )
                      : IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 24),
                          splashRadius: 20,
                          splashColor: Colors.redAccent.withValues(alpha: 0.3),
                          highlightColor: Colors.redAccent.withValues(alpha: 0.15),
                          hoverColor: Colors.redAccent.withValues(alpha: 0.08),
                          padding: const EdgeInsets.all(4),
                          constraints: const BoxConstraints(),
                          tooltip: 'Delete',
                          onPressed: _handleDelete,
                        ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  widget.shelf,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'In Stock: ${widget.inStockQty}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Nunito',
                ),
              ),
              const SizedBox(height: 12),
              // ปุ่มปรับจำนวนเพิ่มลด (+ / -)
              Row(
                children: [
                   GestureDetector(
                    onTap: () {
                      // ✅ เปลี่ยนมาเรียก _updateItemQuantity 
                      if (widget.amount > 1) {
                         widget.onUpdateQuantity(widget.index, widget.amount - 1, widget.cartItemId);
                      }
                    },
                    child: Icon(Icons.remove_circle_outline, color: Colors.red.shade600, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '${widget.amount}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                       // ✅ เปลี่ยนมาเรียก _updateItemQuantity
                       if (widget.amount >= widget.inStockQty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Cannot add more than available stock.'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 1),
                            ),
                          );
                          return;
                        }
                        widget.onUpdateQuantity(widget.index, widget.amount + 1, widget.cartItemId);
                    },
                    child: const Icon(Icons.add_circle_outline, color: Colors.deepPurple, size: 28),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}
import 'package:denis/dataconnect_generated/generated.dart';
import 'package:denis/presentation/widgets/outline_app_button.dart';
import 'package:denis/presentation/widgets/primary_app_button.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/material.dart';

class RequestDetailsDialog extends StatefulWidget {
  final GetAllOrdersOrders order;
  final String timestamp;
  final Color statusColor;
  final Future<QueryResult<GetOrderDetailsData, void>> orderDetailsFuture;
  final Future<void> Function(BuildContext, String, String) onUpdateStatus;
  const RequestDetailsDialog({
    super.key,
    required this.order,
    required this.timestamp,
    required this.statusColor,
    required this.orderDetailsFuture,
    required this.onUpdateStatus
  });

  @override
  State<RequestDetailsDialog> createState() => _RequestDetailsDialogState();
}

class _RequestDetailsDialogState extends State<RequestDetailsDialog> {
  @override
  Widget build(BuildContext context) {
    final orderId = widget.order.id;

    return Dialog(
      backgroundColor: Colors.transparent, 
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Container(
        width: 600, 
        constraints: const BoxConstraints(maxHeight: 700),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32), 
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, 
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${orderId.length > 4 ? orderId.substring(0, 4).toUpperCase() : orderId.toUpperCase()}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
            const SizedBox(height: 12),
            
            // Date
            Row(
              children: [
                const Text(
                  'Order Date: ',
                  style: TextStyle(fontSize: 18, fontFamily: 'Nunito'),
                ),
                Text(
                  widget.timestamp,
                  style: const TextStyle(fontSize: 18, color: Colors.black87, fontFamily: 'Nunito'),
                ),
              ],
            ),
            
            // Status
            Row(
              children: [
                const Text(
                  'Status: ',
                  style: TextStyle(fontSize: 18, fontFamily: 'Nunito'),
                ),
                Text(
                  widget.order.status,
                  style: TextStyle(
                    fontSize: 18,
                    color: widget.statusColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // List Items
            Expanded(
              child: FutureBuilder<QueryResult<GetOrderDetailsData, void>>(
                future: widget.orderDetailsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final orderResult = snapshot.data?.data.order;
                  if (orderResult == null || orderResult.orderItems_on_order.isEmpty) {
                    return const Center(child: Text('No items found in this order.'));
                  }

                  final items = orderResult.orderItems_on_order;

                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: items.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final instrument = item.instrument;
                      final shelf = instrument.stocks_on_instrument.isNotEmpty 
                          ? instrument.stocks_on_instrument[0].shelf 
                          : 'N/A';

                      return Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(16),
                              image: instrument.imageUrl.isNotEmpty ? DecorationImage(
                                image: NetworkImage(instrument.imageUrl),
                                fit: BoxFit.cover,
                              ) : null,
                            ),
                            child: instrument.imageUrl.isEmpty 
                                ? Icon(Icons.content_cut, color: Colors.grey.shade400) 
                                : null,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  instrument.name, 
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.deepPurple)
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'Shelf $shelf',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text('Qty: ${item.qty}', style: const TextStyle(fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            // Actions
            Row(
              children: [
                if (widget.order.status.toLowerCase() != 'returned') ...[
                  Expanded(
                    child: OutlineAppButton(
                      text: 'Reject this request',
                      onPressed: () {
                        widget.onUpdateStatus(context, widget.order.id, 'Cancelled');
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                  child: PrimaryAppButton(
                    text: widget.order.status.toLowerCase() == 'pending' ? 'Proceed to Ready' 
                          : widget.order.status.toLowerCase() == 'ready' ? 'Proceed to Checkout' 
                          : widget.order.status.toLowerCase() == 'success' ? 'Proceed to Returned'
                          : 'Reject this request',
                    onPressed: () {
                      if (widget.order.status.toLowerCase() == 'pending'){
                        widget.onUpdateStatus(context, widget.order.id, 'Ready');
                      }
                      else if (widget.order.status.toLowerCase() == 'ready'){
                        widget.onUpdateStatus(context, widget.order.id, 'Success');
                      }
                      else if (widget.order.status.toLowerCase() == 'success') {
                        widget.onUpdateStatus(context, widget.order.id, 'Returned');
                      }
                    },
                  ),
                ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
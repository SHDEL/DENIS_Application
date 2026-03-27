import 'package:flutter/material.dart';

class InstrumentTile extends StatefulWidget {
  const InstrumentTile({super.key, required this.name, required this.location});
  final String name;
  final String location;
  @override
  State<InstrumentTile> createState() => _InstrumentTileState();
}

class _InstrumentTileState extends State<InstrumentTile> {
  String get name => widget.name;
  String get location => widget.location;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: const Icon(Icons.medical_services_outlined, size: 20, color: Colors.blueGrey),
      title: Text(
        name,
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          location,
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}
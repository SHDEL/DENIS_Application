import 'package:denis/presentation/widgets/category_section.dart';
import 'package:denis/presentation/widgets/instrumentile.dart';
import 'package:flutter/material.dart';

class SearchUserWidget extends StatefulWidget {
  const SearchUserWidget({super.key});

  @override
  State<SearchUserWidget> createState() => _SearchUserWidgetState();
}

class _SearchUserWidgetState extends State<SearchUserWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Search bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Search instruments...',
              hintStyle: const TextStyle(fontFamily: 'Nunito', fontSize: 14),
              prefixIcon: const Icon(Icons.search, color: Colors.blueGrey),
              filled: true,
              fillColor: Colors.white70,
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Categorised list
          Expanded(
            child: ListView(
              children: const [
                CategorySection(
                  category: 'Examination',
                  icon: Icons.search,
                  color: Colors.teal,
                  items: [
                    InstrumentTile(name: 'Dental Mirror',       location: 'Shelf A1'),
                    InstrumentTile(name: 'Explorer Probe',      location: 'Shelf A2'),
                    InstrumentTile(name: 'Periodontal Probe',   location: 'Shelf A3'),
                  ],
                ),
                SizedBox(height: 12),
                CategorySection(
                  category: 'Surgical',
                  icon: Icons.cut,
                  color: Colors.redAccent,
                  items: [
                    InstrumentTile(name: 'Hemostat',            location: 'Shelf B1'),
                    InstrumentTile(name: 'Tissue Scissors',     location: 'Shelf B2'),
                    InstrumentTile(name: 'Scalpel Handle',      location: 'Shelf B3'),
                    InstrumentTile(name: 'Periosteal Elevator', location: 'Shelf B4'),
                    InstrumentTile(name: 'Dental Forceps',      location: 'Shelf B5'),
                  ],
                ),
                SizedBox(height: 12),
                CategorySection(
                  category: 'Restorative',
                  icon: Icons.build_outlined,
                  color: Colors.indigo,
                  items: [
                    InstrumentTile(name: 'Amalgam Condenser',   location: 'Shelf C1'),
                    InstrumentTile(name: 'Composite Plugger',   location: 'Shelf C2'),
                    InstrumentTile(name: 'Burnisher',           location: 'Shelf C3'),
                  ],
                ),
                SizedBox(height: 12),
                CategorySection(
                  category: 'Airway & Suction',
                  icon: Icons.air,
                  color: Colors.blueGrey,
                  items: [
                    InstrumentTile(name: 'Saliva Ejector',      location: 'Shelf D1'),
                    InstrumentTile(name: 'Cheek Retractor',     location: 'Shelf D2'),
                    InstrumentTile(name: 'Tongue Depressor',    location: 'Shelf D3'),
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
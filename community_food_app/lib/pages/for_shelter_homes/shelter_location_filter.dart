import 'package:flutter/material.dart';

class LocationFilter extends StatelessWidget {
  const LocationFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> locations = [
      'locations',
      'KIMIRONKO',
      'GISOZI',
      'KABEZA',
      'REMERA',
      'KICUKIRO',
      'KANOMBE',
      'NYARUTARAMA',
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Filter',
            style: TextStyle(
              fontSize: 25,
              color: Color.fromARGB(255, 3, 71, 50),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 35,
            horizontal: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: locations.map((location) {
              return Container(
                padding: const EdgeInsets.all(12),
                margin: EdgeInsets.only(
                  bottom: location == locations[0] ? 45 : 25,
                ),
                width: location == locations[0] ? 100 : 250,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 211, 207, 207),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  location,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: location == locations[0] ? 16 : 25,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

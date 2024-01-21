import 'package:ayiolo_safari_advisor/data/flag_urls.dart'; 
import 'package:flutter/material.dart';

class LocationNavItem extends StatelessWidget {
  const LocationNavItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locations'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: flagURLS.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (index == 0) {
                Navigator.pushNamed(context, '/parks');
              }
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.network(
                      flagURLS[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    color:
                        const Color.fromARGB(255, 71, 70, 70).withOpacity(0.4),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      countryNames[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

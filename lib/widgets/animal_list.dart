import 'package:ayiolo_safari_advisor/data/wild_animals.dart';
import 'package:flutter/material.dart';

class AnimalList extends StatefulWidget {
  final Function(String) onAnimalSelected;
  final bool isEnabled;

  const AnimalList({super.key, required this.isEnabled, required this.onAnimalSelected});

  @override
  AnimalListState createState() => AnimalListState();
}

class AnimalListState extends State<AnimalList> {
  List<String> selectedAnimals = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: wildAnimals.length,
      itemBuilder: (context, index) {
        final animal = wildAnimals[index];
        return Column(
          children: [
            Center(
              child: ListTile(
                title: Text(
                  animal,
                  style: TextStyle(
                    color: widget.isEnabled ? Colors.black : Colors.grey,
                  ),
                ),
                onTap: widget.isEnabled
                    ? () {
                        widget.onAnimalSelected(animal);
                      }
                    : null,
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 0.3,
              indent: 6.0,
              endIndent: 6.0,
            ),
          ],
        );
      },
    );
  }
}

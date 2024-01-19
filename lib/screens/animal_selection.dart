import 'package:ayiolo_safari_advisor/widgets/animal_list.dart';
import 'package:flutter/material.dart';

class AnimalSelection extends StatefulWidget {
  const AnimalSelection({super.key});

  @override
  State<AnimalSelection> createState() => _AnimalSelectionState();
}

List<String> selectedAnimals = [];

String getSelectedContentMessage() {
  int numberOfSelectedAnimals = selectedAnimals.length;

  if (numberOfSelectedAnimals == 0) {
    return 'No animals selected';
  } else if (numberOfSelectedAnimals == 1) {
    return '1 animal selected';
  } else if (numberOfSelectedAnimals <= 5) {
    return '$numberOfSelectedAnimals animals selected';
  } else {
    return 'You can only select 5 animals';
  }
}

String animalLimitMessage = '';

class _AnimalSelectionState extends State<AnimalSelection> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, selectedAnimals);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Animal Selection'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      'Choose up to 5 animals you\'d love to see on Safari. There\'s lots more than the Big 5!'),
                ),
              ),
              SizedBox(
                height: 500,
                width: 300,
                child: AnimalList(onAnimalSelected: (String animal) {
                  setState(() {
                    if (selectedAnimals.contains(animal)) {
                      selectedAnimals.remove(animal);
                    } else if (selectedAnimals.length < 5) {
                      selectedAnimals.add(animal);
                      animalLimitMessage = '';
                    } else {
                      animalLimitMessage = 'You can only select 5 animals';
                    }
                  });
                }),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(getSelectedContentMessage()),
              Text(animalLimitMessage,
                  style: const TextStyle(color: Colors.red)),
              SizedBox(
                height: 200,
                width: 400,
                child: Container(
                    // color: Colors.black,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 247, 240, 240),
                    ),
                    child: ListView.builder(
                      itemCount: selectedAnimals.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(selectedAnimals[index]),
                        );
                      },
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

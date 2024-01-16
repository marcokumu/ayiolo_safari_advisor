import 'package:flutter/material.dart';

class Ayiolo extends StatelessWidget {
  const Ayiolo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayiolo'),
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Hero(
                tag: 'ayiolo',
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/ayiolo_image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Center(
            child: Text('Ayiolo!',
                style: Theme.of(context).textTheme.headlineSmall),
          ),
          const SizedBox(height: 50.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '');
              },
              child: Container(
                height: 70,
                width: 300,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 212, 208, 208),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Center(
                  child: Text('FIND ANIMAL - IN PARK',
                      style: Theme.of(context).textTheme.labelLarge),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/save_my_spot');
              },
              child: Hero(
                tag: 'save_my_spot',
                child: Container(
                  height: 70,
                  width: 300,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 212, 208, 208),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Center(
                    child: Text('SAVE MY SPOTS',
                        style: Theme.of(context).textTheme.labelLarge),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '');
              },
              child: Container(
                height: 70,
                width: 300,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 212, 208, 208),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Center(
                  child: Text('ASK/TRANSLATE',
                      style: Theme.of(context).textTheme.labelLarge),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ParkInterests extends StatelessWidget {
  const ParkInterests({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Park Interests')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/find_animals');
                },
                child: Container(
                  height: 70,
                  width: 300,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 212, 208, 208),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Center(
                    child: Text('Find Animals',
                        style: Theme.of(context).textTheme.labelLarge),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/spot_names');
                },
                child: Container(
                  height: 70,
                  width: 300,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 212, 208, 208),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Center(
                    child: Text('Gates, Picnic sites & Viewpoints',
                        style: Theme.of(context).textTheme.labelLarge),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

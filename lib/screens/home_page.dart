import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
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
        const SizedBox(height: 20.0),
        Center(
          child: Text('Data-driven Safaris for conservation!',
              style: Theme.of(context).textTheme.titleSmall),
        ),
        const SizedBox(height: 50.0),
        Text('Want help finding animals in the park?',
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/ayiolo');
            },
            child: Container(
              height: 70,
              width: 300,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 212, 208, 208),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Center(
                child: Text('AYIOLO',
                    style: Theme.of(context).textTheme.labelLarge),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        Text('Want help planning your next safari?',
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/safari_advisor');
            },
            child: Container(
              height: 70,
              width: 300,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 212, 208, 208),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Center(
                child: Text('SAFARI ADVISOR',
                    style: Theme.of(context).textTheme.labelLarge),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

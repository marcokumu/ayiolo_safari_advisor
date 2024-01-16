import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 400,
                  width: 400,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/ayiolo_image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  'Data-driven Safaris!',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 40.0),
                const Text('Enhanced Safari Experience!'),
                const SizedBox(height: 20.0),
                const Text('Protecting Wildlife!'),
                const SizedBox(height: 20.0),
                const Text('Preserving wildlands!'),
                const SizedBox(height: 20.0),
                const Text('Enriching the Community!'),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/bottom_navigation');
                    },
                    child: Container(
                      height: 70,
                      width: 300,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 230, 227, 227),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Center(
                        child: Text('See More! Save More!',
                            style: Theme.of(context).textTheme.labelLarge),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

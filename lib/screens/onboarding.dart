import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
        child: Center(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 300,
                    width: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/ayiolo_image.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 46.0),
                  const Text(
                    'Ayiolo!',
                    style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    '[a-ye-olo] - to know (Maa Language)',
                    style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Did you know?',
                    style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Color.fromARGB(255, 199, 107, 57)),
                  ),
                  const SizedBox(height: 16.0),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'Over 25000 species are currently threatened with extinction due to human activities.',
                        style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey)),
                  ),
                  const SizedBox(height: 16.0),
                  const Text('They only live once. See More! Save More!',
                      style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 13, 13, 13))),
                ],
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/auth_page');
                  },
                  child: const Icon(Icons.arrow_forward),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

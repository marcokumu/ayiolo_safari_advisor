import 'package:flutter/material.dart';

class SafariAdvisor extends StatefulWidget {
  const SafariAdvisor({super.key});

  @override
  State<SafariAdvisor> createState() => _SafariAdvisorState();
}

List<String> selectedAnimals = [];
List<String> selectedCountries = [];
List<String> selectedMonths = [];

class _SafariAdvisorState extends State<SafariAdvisor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Safari Advisor'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            const Text('Click any section to plan/change'),
            const SizedBox(height: 16.0),
            const Text('Click "Tips" when ready'),
            const SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                '5 Animals you\'d love to see:',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Color.fromARGB(255, 5, 140, 75),
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/animal_selection')
                    .then((result) => {
                          if (result != null && result is List<String>)
                            {
                              setState(() {
                                selectedAnimals = result;
                              })
                            }
                        });
              },
              child: SizedBox(
                height: 100,
                width: 400,
                child: Hero(
                  tag: 'safari_advisor',
                  child: Container(
                      // color: Colors.black,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 235, 234, 234),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Text(selectedAnimals.join(", "),
                          style: const TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ))),
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                '4 Countries you\'d love to go to:',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Color.fromARGB(255, 8, 105, 58),
                    color: Color.fromARGB(255, 234, 230, 230)),
              ),
            ),
            const SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/countries_selection')
                    .then((result) => {
                          if (result != null && result is List<String>)
                            {
                              setState(() {
                                selectedCountries = result;
                              })
                            }
                        });
              },
              child: SizedBox(
                height: 100,
                width: 400,
                child: Container(
                    // color: Colors.black,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 228, 225, 225),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Text(selectedCountries.join(", "),
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ))),
              ),
            ),
            const SizedBox(height: 30.0),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                '3 Months you\'d love to travel:',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Color.fromARGB(255, 8, 103, 57),
                    color: Color.fromARGB(255, 239, 237, 237)),
              ),
            ),
            const SizedBox(height: 0.0),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/month_selection')
                    .then((result) => {
                          if (result != null && result is List<String>)
                            {
                              setState(() {
                                selectedMonths = result;
                              })
                            }
                        });
              },
              child: SizedBox(
                  height: 100,
                  width: 400,
                  child: Container(
                    // color: Colors.black,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 240, 238, 238),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Text(selectedMonths.join(", "),
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        )),
                  )),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}

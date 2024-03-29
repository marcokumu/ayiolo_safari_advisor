import 'package:ayiolo_safari_advisor/widgets/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CountriesSelection extends StatefulWidget {
  const CountriesSelection({super.key});

  @override
  State<CountriesSelection> createState() => _CountriesSelectionState();
}

List<String> selectedCountries = [];

String getSelectedContentMessage() {
  int numberOfSelectedCountries = selectedCountries.length;

  if (numberOfSelectedCountries == 0) {
    return 'No countries selected';
  } else if (numberOfSelectedCountries == 1) {
    return '1 country selected';
  } else if (numberOfSelectedCountries <= 4) {
    return '$numberOfSelectedCountries countries selected';
  } else {
    return 'You can only select 4 countries';
  }
}

String countryLimitMessage = '';

class _CountriesSelectionState extends State<CountriesSelection> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, selectedCountries);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Countries Selection'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                  'Choose up to 4 countries you\'d love to go on Safari to. Go "wild"! there\'s lots to see across Africa!'),
              SizedBox(
                width: 300,
                height: 500,
                child: CountriesList(
                  onSelectedCountriesChanged: (String country) {
                    setState(() {
                      if (selectedCountries.contains(country)) {
                        selectedCountries.remove(country);
                      } else if (selectedCountries.length < 4) {
                        selectedCountries.add(country);
                        countryLimitMessage =
                            ''; 
                      } else {
                        countryLimitMessage = 'You can only select 4 countries';
                      }
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(getSelectedContentMessage()),
              Text(
                countryLimitMessage,
                style: const TextStyle(color: Colors.red),
              ),
              SizedBox(
                height: 200,
                width: 400,
                child: Container(
                  // color: Colors.black,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: (ListView.builder(
                    itemCount: selectedCountries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(selectedCountries[index]),
                      );
                    },
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

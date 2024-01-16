import 'package:ayiolo_safari_advisor/data/countries.dart';
import 'package:flutter/material.dart';

class CountriesList extends StatefulWidget {
  final Function(String) onSelectedCountriesChanged;

  const CountriesList({super.key, required this.onSelectedCountriesChanged});

  @override
  CountriesListState createState() => CountriesListState();
}

class CountriesListState extends State<CountriesList> {
  List<String> selectedCountries = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: countries.length,
      itemBuilder: (context, index) {
        final country = countries[index];
        return Column(
          children: [
            ListTile(
              title: Text(country),
              onTap: () {
                widget.onSelectedCountriesChanged(country);
              },
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

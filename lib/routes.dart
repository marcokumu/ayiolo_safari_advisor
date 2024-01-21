import 'package:flutter/material.dart';
import 'package:ayiolo_safari_advisor/navigation/bottom_navigation.dart';
import 'package:ayiolo_safari_advisor/screens/animal_selection.dart';
import 'package:ayiolo_safari_advisor/screens/auth_page.dart';
import 'package:ayiolo_safari_advisor/screens/ayiolo.dart';
import 'package:ayiolo_safari_advisor/screens/countries_selection.dart';
import 'package:ayiolo_safari_advisor/screens/find_animals.dart';
import 'package:ayiolo_safari_advisor/screens/home_page.dart';
import 'package:ayiolo_safari_advisor/screens/spot_names.dart';
import 'package:ayiolo_safari_advisor/screens/month_selection.dart';
import 'package:ayiolo_safari_advisor/screens/onboarding.dart';
import 'package:ayiolo_safari_advisor/screens/park_interests.dart';
import 'package:ayiolo_safari_advisor/screens/parks.dart';
import 'package:ayiolo_safari_advisor/screens/safari_advisor.dart';
import 'package:ayiolo_safari_advisor/screens/save_my_spot.dart';
import 'package:ayiolo_safari_advisor/screens/save_spotted_animal.dart';
import 'package:ayiolo_safari_advisor/screens/welcome_page.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/auth_page': (context) => const AuthPage(),
    '/onboarding': (context) => const OnboardingPage(),
    '/welcome': (context) => const WelcomePage(),
    '/home_page': (context) => const HomePage(),
    '/animal_selection': (context) => const AnimalSelection(),
    '/month_selection': (context) => const MonthSelection(),
    '/countries_selection': (context) => const CountriesSelection(),
    '/safari_advisor': (context) => const SafariAdvisor(),
    '/save_my_spot': (context) => const SaveMySpot(),
    '/parks': (context) => const Parks(),
    '/bottom_navigation': (context) => const BottomNavigation(),
    '/ayiolo': (context) => const Ayiolo(),
    '/spot_names': (context) => const MapsWidget(),
    '/spotted_animal': (context) => const SaveSpottedAnimal(locationData: null),
    '/park_interests': (context) => const ParkInterests(),
    '/find_animals': (context) => const FindAnimals(),
  };
}

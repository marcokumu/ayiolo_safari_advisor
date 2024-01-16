import 'package:flutter/material.dart';
import 'package:ayiolo_safari_advisor/data/months.dart';
import 'package:ayiolo_safari_advisor/widgets/month_list.dart';

class MonthSelection extends StatefulWidget {
  const MonthSelection({super.key});

  @override
  State<MonthSelection> createState() => _MonthSelectionState();
}

List<String> selectedMonths = [];

class _MonthSelectionState extends State<MonthSelection> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, selectedMonths);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Month Selection'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Text('Top 3 dates I\'d love to go on a Safari.'),
              const SizedBox(height: 20.0),
              for (List<String> yearMonths in [year1, year2, year3])
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 5.0),
                    ),
                    height: 150,
                    child: MonthList(
                      monthList: yearMonths,
                      onMonthSelected: (selectedMonth) {
                        setState(() {
                          if (selectedMonths.length < 3) {
                            selectedMonths.add(selectedMonth);
                          }
                        });
                      },
                    ),
                  ),
                ),
              const SizedBox(height: 10.0),
              Text('Selected Months: ${selectedMonths.length}'),
              SizedBox(
                height: 200,
                width: 400,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 233, 220, 220),
                  ),
                  child: ListView.builder(
                    itemCount: selectedMonths.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(selectedMonths[index]),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

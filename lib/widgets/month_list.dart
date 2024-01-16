import 'package:flutter/material.dart';

class MonthList extends StatefulWidget {
  final Function(String) onMonthSelected;
  final List<String> monthList;

  const MonthList(
      {super.key, required this.monthList, required this.onMonthSelected});

  @override
  MonthListState createState() => MonthListState();
}

class MonthListState extends State<MonthList> {
  @override
  Widget build(BuildContext context) {
    return buildMonthList(widget.monthList);
  }

  Widget buildMonthList(List<String> monthList) {
    return ListView.builder(
      itemCount: monthList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              title: Text(monthList[index]),
              onTap: () {
                widget.onMonthSelected(monthList[index]);
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

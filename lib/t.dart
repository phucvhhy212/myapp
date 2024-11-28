import 'package:flutter/material.dart';

class HorizontalCalendar extends StatefulWidget {
  @override
  _HorizontalCalendarState createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  List<String> days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  List<int> dates = [13, 14, 15, 16, 17, 18, 19]; // Example data

  // Default selected date is the first date in the list
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime(DateTime.now().year, DateTime.now().month, dates.first); // Set to first index
  }

  void changeSelectedIndex(bool isNext) {
    setState(() {
      int currentIndex = dates.indexOf(selectedDate.day);
      int newIndex = isNext ? currentIndex + 1 : currentIndex - 1;

      // Ensure the index stays within bounds
      if (newIndex >= 0 && newIndex < dates.length) {
        selectedDate = DateTime(
          selectedDate.year,
          selectedDate.month,
          dates[newIndex],
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // Background color
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "February",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left Button
              IconButton(
                icon: Icon(Icons.arrow_left, color: Colors.white),
                onPressed: () {
                  changeSelectedIndex(false); // Move to the previous date
                },
              ),

              // Calendar Dates
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(dates.length, (index) {
                    bool isSelected = dates[index] == selectedDate.day;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDate = DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            dates[index],
                          );
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            dates[index].toString(),
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey,
                              fontSize: 18,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            days[index],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),

              // Right Button
              IconButton(
                icon: Icon(Icons.arrow_right, color: Colors.white),
                onPressed: () {
                  changeSelectedIndex(true); // Move to the next date
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: HorizontalCalendar(),
      ),
    ),
  ));
}

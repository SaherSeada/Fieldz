import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Coach_Plan extends StatefulWidget {
  const Coach_Plan({super.key});

  @override
  State<Coach_Plan> createState() => _Coach_PlanState();
}

class _Coach_PlanState extends State<Coach_Plan> {
  List<DateTime> selectedDates = [];
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _durationController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  CollectionReference programs =
  FirebaseFirestore.instance.collection('programs');

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _durationController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
    _selectTime(context);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final DateTime currentTime = DateTime.now();
      final DateTime selectedDateTime = DateTime(
        _selectedDay.year,
        _selectedDay.month,
        _selectedDay.day,
        picked.hour,
        picked.minute,
      );

      // Check if selected date is greater than or equal to the current date
      if (selectedDateTime.isAfter(currentTime) || selectedDateTime.isAtSameMomentAs(currentTime)) {
        _addSelectedDate(selectedDateTime);
      } else {
        // Show an error message if the selected date is in the past
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please select a date greater or equal to the current date.'),
        ));
      }
    }
  }


  void _addSelectedDate(DateTime selectedDateTime) {
    if (!selectedDates.contains(selectedDateTime)) {
      setState(() {
        selectedDates.add(selectedDateTime);
      });
    }
  }

  void _removeSelectedDate(int index) {
    setState(() {
      selectedDates.removeAt(index);
    });
  }

  void _saveProgramDetails() {
    List<String> formattedDates = selectedDates
        .map((date) => DateFormat('yyyy-MM-dd').format(date))
        .toList();
    List<String> formattedTimes = selectedDates
        .map((date) => DateFormat('HH:mm').format(date))
        .toList();

    programs.add({
      "Program_name": _nameController.text,
      "Location": _locationController.text,
      "Duration": _durationController.text,
      "Price": _priceController.text,
      "Schedule_dates": formattedDates,
      "Schedule_times": formattedTimes,
    }).then((value) {
      // Clear fields after successful save
      _nameController.clear();
      _locationController.clear();
      _durationController.clear();
      _priceController.clear();
      // Clear schedule table
      setState(() {
        selectedDates.clear();
      });
    }).catchError((error) => print("Failed to add program: $error"));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Make your schedule table",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              TableCalendar(
                firstDay: DateTime(2020),
                lastDay: DateTime(2025),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                calendarFormat: _calendarFormat,
                onDaySelected: _onDaySelected,
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
              SizedBox(height: 20),
              if (selectedDates.isNotEmpty)
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Time')),
                      DataColumn(label: Text('Edit or Delete')),
                    ],
                    rows: List<DataRow>.generate(
                      selectedDates.length,
                          (index) => DataRow(
                        cells: [
                          DataCell(Text(
                              DateFormat('yyyy-MM-dd').format(selectedDates[index]))),
                          DataCell(Text(
                              DateFormat('HH:mm').format(selectedDates[index]))),
                          DataCell(Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  _editSelectedDate(context, index);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _removeSelectedDate(index);
                                },
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              Text(
                "Fill in your Program details here",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueGrey,
                ),
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  prefixText: "Program Name: ",
                  border: UnderlineInputBorder(),
                  labelText: "Program Name",
                  labelStyle: TextStyle(color: Colors.blueGrey),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  prefixText: "Location: ",
                  border: UnderlineInputBorder(),
                  labelText: "Meeting Location",
                  labelStyle: TextStyle(color: Colors.blueGrey),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _durationController,
                decoration: InputDecoration(
                  prefixText: "Session time: ",
                  border: UnderlineInputBorder(),
                  labelText: "Duration",
                  labelStyle: TextStyle(color: Colors.blueGrey),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  prefixText: "Total Price : ",
                  border: UnderlineInputBorder(),
                  labelText: "Price",
                  labelStyle: TextStyle(color: Colors.blueGrey),
                ),
              ),
              SizedBox(height: 15),
              MaterialButton(
                onPressed: _saveProgramDetails,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add Program",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.add),
                  ],
                ),
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddedDates(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selected Dates'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < selectedDates.length; i++)
                  ListTile(
                    title: Text(
                        DateFormat('yyyy-MM-dd HH:mm').format(selectedDates[i])),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _removeSelectedDate(i);
                      },
                    ),
                  ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _editSelectedDate(BuildContext context, int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDates[index]),
    );
    if (picked != null) {
      final DateTime selectedDateTime = DateTime(
        selectedDates[index].year,
        selectedDates[index].month,
        selectedDates[index].day,
        picked.hour,
        picked.minute,
      );
      setState(() {
        selectedDates[index] = selectedDateTime;
      });
    }
  }
}
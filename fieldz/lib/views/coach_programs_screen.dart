import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'coach_subscription_plan_screen.dart';

class Coach_Programs extends StatefulWidget {
  const Coach_Programs({super.key});

  @override
  State<Coach_Programs> createState() => _Coach_ProgramsState();
}

class _Coach_ProgramsState extends State<Coach_Programs> {
  TimeOfDay _timeOfDay = TimeOfDay.now();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _durationController = TextEditingController();
  TextEditingController _PriceController = TextEditingController();

  CollectionReference Sessions =
      FirebaseFirestore.instance.collection('Sessions');

  Future<void> addSession() {
    // Call the user's CollectionReference to add a new user
    return Sessions.add({
      "Program_name": _nameController.text,
      "location": _locationController.text,
      "duration": _durationController.text,
      "Price": _PriceController.text,
      "date": _dateController.text,
      "time": _timeOfDay.format(context),
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void _showTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text("Program Section"),
          centerTitle: true,
          bottom: TabBar(tabs: [
            Tab(
              child: Text("Quick-Session"),
            ),
            Tab(
              child: Text("Subscription-Plan"),
            ),
          ]),
        ),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            child: TabBarView(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Text(
                        "Fill your Session here",
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
                            labelStyle: TextStyle(color: Colors.blueGrey)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: _locationController,
                        decoration: InputDecoration(
                            prefixText: "Location: ",
                            border: UnderlineInputBorder(),
                            labelText: "Meeting Location",
                            labelStyle: TextStyle(color: Colors.blueGrey)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: _durationController,
                        decoration: InputDecoration(
                            prefixText: "Session time: ",
                            border: UnderlineInputBorder(),
                            labelText: "Duration",
                            labelStyle: TextStyle(color: Colors.blueGrey)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: _PriceController,
                        decoration: InputDecoration(
                            prefixText: "Total Price : ",
                            border: UnderlineInputBorder(),
                            labelText: "Price",
                            labelStyle: TextStyle(color: Colors.blueGrey)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Select Date & Time",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _dateController,
                              readOnly: true,
                              decoration: InputDecoration(
                                  labelText: "Date",
                                  labelStyle: TextStyle(color: Colors.black),
                                  filled: true,
                                  fillColor: Colors.grey,
                                  prefixIcon: Icon(Icons.calendar_today),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  )),
                              onTap: _selectDate,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              readOnly: true,
                              decoration: InputDecoration(
                                  labelText: "Time:" +
                                      _timeOfDay.format(context).toString(),
                                  labelStyle: TextStyle(color: Colors.black),
                                  filled: true,
                                  fillColor: Colors.grey,
                                  prefixIcon: Icon(Icons.timer),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  )),
                              onTap: _showTimePicker,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      MaterialButton(
                          onPressed: () {
                            addSession();
                            _nameController.clear();
                            _locationController.clear();
                            _durationController.clear();
                            _PriceController.clear();
                            _dateController.clear();
                            _timeController.clear();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Add Session",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.add),
                            ],
                          )),
                    ],
                  ),
                ),
                Coach_Plan(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2024),
        lastDate: DateTime(2100));
    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}

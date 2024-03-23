import 'package:flutter/material.dart';
import 'Coach_Subscription_Plan.dart';

class Coach_Programs extends StatefulWidget {
  const Coach_Programs({super.key});

  @override
  State<Coach_Programs> createState() => _Coach_ProgramsState();
}

class _Coach_ProgramsState extends State<Coach_Programs> {
  TimeOfDay _timeOfDay = TimeOfDay.now();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();


  void _showTimePicker(){
    showTimePicker(context: context,
        initialTime: TimeOfDay.now()).then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text("Program Section"),
          centerTitle: true,
          bottom: TabBar(tabs: [
            Tab(child: Text("Quick-Session"),),
            Tab(child: Text("Subscription-Plan"),),
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
                      Text("Fill your Session here",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey,
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            prefixText: "Program Name: ",
                            border: UnderlineInputBorder(

                            ),
                            labelText: "Program Name",
                            labelStyle: TextStyle(color: Colors.blueGrey)
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            prefixText: "Location: ",
                            border: UnderlineInputBorder(

                            ),
                            labelText: "Meeting Location",
                            labelStyle: TextStyle(color: Colors.blueGrey)
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            prefixText: "Session time: ",
                            border: UnderlineInputBorder(

                            ),
                            labelText: "Duration",
                            labelStyle: TextStyle(color: Colors.blueGrey)
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            prefixText: "Total Price : ",
                            border: UnderlineInputBorder(

                            ),
                            labelText: "Price",
                            labelStyle: TextStyle(color: Colors.blueGrey)
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text("Select Date & Time",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey
                        ),
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
                                  )
                              ),
                              onTap: _selectDate,

                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child:MaterialButton(
                                color: Colors.grey,
                                onPressed: _showTimePicker,
                                child:Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text("Time:"+ _timeOfDay.format(context).toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),),
                                )


                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                      ElevatedButton(onPressed: (){},
                        child: Text("Add Session",style:TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey
                        ),
                        ),
                      ),

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
  Future<void> _selectDate()async{
    DateTime? _picked = await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2024),
        lastDate: DateTime(2100)
    );
    if (_picked != null){
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}

import 'package:fieldz/models/supplier_court_model.dart';

class AddCourtController {
  void submitForm(Court court) {
    // Perform actions based on the submitted court data
    print('Form submitted');
    print('Court Name: ${court.courtName}');
    print('Sport: ${court.selectedSport}');
    print('Location: ${court.location}');
    print('Google Maps Link: ${court.googleMapsLink}');
    print('Minimum Capacity: ${court.minCapacity}');
    print('Number of Courts: ${court.numCourts}');
    print('Fees per Hour: ${court.feesPerHour}');
    // Add more actions as needed, such as saving data to a database
  }
}

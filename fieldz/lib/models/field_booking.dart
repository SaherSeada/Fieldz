class FieldBooking {
  String id;
  String bookerName;
  String date;
  String phoneNumber;
  int price;
  String details;
  String fieldID;
  String fieldName;
  List hoursBooked;
  String userID;

  FieldBooking(
      this.id,
      this.bookerName,
      this.date,
      this.phoneNumber,
      this.price,
      this.details,
      this.fieldID,
      this.fieldName,
      this.hoursBooked,
      this.userID);
}

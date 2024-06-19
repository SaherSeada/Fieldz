class Session {
  String id;
  String coachID;
  String name;
  String description;
  String location;
  double duration;
  double price;
  int capacity;
  List users;
  String date;
  String time;
  bool available;

  Session(
      this.id,
      this.coachID,
      this.name,
      this.description,
      this.location,
      this.duration,
      this.price,
      this.capacity,
      this.users,
      this.date,
      this.time,
      this.available);
}

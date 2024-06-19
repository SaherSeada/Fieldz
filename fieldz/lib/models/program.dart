class Program {
  String id;
  String coachID;
  String name;
  String description;
  String location;
  double duration;
  double price;
  int capacity;
  List users;
  Map schedule;
  bool available;

  Program(
      this.id,
      this.coachID,
      this.name,
      this.description,
      this.location,
      this.duration,
      this.price,
      this.capacity,
      this.users,
      this.schedule,
      this.available);
}

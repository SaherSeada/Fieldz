class Court {
  String courtName;
  String selectedSport;
  String location;
  String googleMapsLink;
  int minCapacity;
  int numCourts;
  double feesPerHour;

  Court({
    required this.courtName,
    required this.selectedSport,
    required this.location,
    required this.googleMapsLink,
    required this.minCapacity,
    required this.numCourts,
    required this.feesPerHour,
  });
}

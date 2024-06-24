class Coach {
  String id;
  String email;
  String username;
  String phoneNumber;
  int rating;
  String avatarUrl;
  String sport;
  String? status;
  int? availableSessions;
  int? availablePlans;

  Coach(this.id, this.email, this.username, this.phoneNumber,
      this.rating, this.avatarUrl, this.sport);
}

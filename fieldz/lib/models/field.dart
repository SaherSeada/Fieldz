class Field {
  String id;
  String name;
  String location;
  int price;
  int rating;
  String imageUrl;
  Map availability;
  String? status;

  Field(this.id, this.name, this.location, this.price, this.rating,
      this.imageUrl, this.availability);
}

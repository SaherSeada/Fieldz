class Field {
  String id;
  String name;
  String location;
  String phone;
  int price;
  int rating;
  String imageUrl;
  Map availability;
  String sport;
  String? status;
  String? supplierID;

  Field(this.id, this.name, this.location, this.phone, this.price, this.rating,
      this.imageUrl, this.availability, this.sport);
}

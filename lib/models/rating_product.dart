import 'dart:io';

class RatingProductObject {
  String invoiceProductId;
  int star;
  String description;
  int showName;
  List<File> images = [];

  RatingProductObject({this.invoiceProductId, this.star, this.description, this.showName, this.images});
}

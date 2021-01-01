import 'dart:io';

class RatingProduct {
  String invoiceProductId;
  int star;
  String description;
  int showName;
  List<File> images = [];

  RatingProduct({this.invoiceProductId, this.star, this.description, this.showName, this.images});

  // RatingProduct() {
  //   print('init rating product');
  //   images = [];
  // }
}

import 'favorites_model.dart';

class SearchModel {
  late final bool status;
  late final dynamic message;
  late final Data data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  late final int currentPage;
  late final List<Product> data;
  late final String firstPageUrl;
  late final int from;
  late final int lastPage;
  late final String lastPageUrl;
  late final dynamic nextPageUrl;
  late final String path;
  late final int perPage;
  late final dynamic prevPageUrl;
  late final int to;
  late final int total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    data = List.from(json['data']).map((e) => Product.fromJson(e)).toList();
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['nextPageUrl'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prevPageUrl'];
    to = json['to'];
    total = json['total'];
  }
}

// class Product {
//   late final int id;
//   late final int? price;
//   late final String image;
//   late final String name;
//   late final String description;
//   late final List<String> images;
//   late final bool inFavorites;
//   late final bool inCart;
//
//   Product.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     image = json['image'];
//     name = json['name'];
//     description = json['description'];
//     images = List.castFrom<dynamic, String>(json['images']);
//     inFavorites = json['in_favorites'];
//     inCart = json['in_cart'];
//   }
// }

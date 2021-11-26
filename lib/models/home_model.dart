class HomeModel {

  late final bool status;
  late final HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {

  late final List<Banners> banners;
  late final List<Products> products;

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    banners =
        List.from(json['banners']).map((e) => Banners.fromJson(e)).toList();
    products =
        List.from(json['products']).map((e) => Products.fromJson(e)).toList();
  }
}

class Banners {
  late final int id;
  late final String image;

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class Products {
  late final int id;
  late final dynamic price;
  late final dynamic oldPrice;
  late final dynamic discount;
  late final String image;
  late final String name;
  late final String description;
  late final List<String> images;
  late final bool inFavorites;
  late final bool inCart;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = List.castFrom<dynamic, String>(json['images']);
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}

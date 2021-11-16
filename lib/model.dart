import 'dart:convert';
import 'package:http/http.dart' as http;

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromMap(x)));

class Post {
  Post(
      {required this.name,
      required this.fav,
      required this.id,
      required this.brand,
      required this.description,
      required this.price,
      required this.rating,
      required this.thumbImageURL});

  var brand;
  var description;
  var id;
  var name;
  var price;
  var rating;
  var thumbImageURL;
  bool fav;

  factory Post.fromMap(Map<String, dynamic> json) => Post(
        brand: json["brand"],
        description: json["description"],
        id: json["id"],
        name: json["name"],
        price: json["price"],
        rating: json["rating"],
        thumbImageURL: json["thumbImageURL"],
        fav: true,
      );
}

Future<List<Post>> fetchPost() async {
  final response = await http.get(
    Uri.parse('https://scb-test-mobile.herokuapp.com/api/mobiles/'),
  );

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Post>((json) => Post.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

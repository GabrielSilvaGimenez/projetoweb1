import 'dart:convert';
import 'dart:typed_data';

class ItemModel {
  int? id;
  String? name;
  String? dateCad;
  String? description;
  String? image;
  Uint8List? imageView;
  int? userId;

  ItemModel({
    this.id,
    this.name,
    this.dateCad,
    this.description,
    this.image,
    this.imageView,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'dateCad': dateCad,
      'description': description,
      'image': image,
      'userId': userId,
    };
  }

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      name: json['name'],
      dateCad: json['dateCad'],
      description: json['description'],
      image: json['image'],
      userId: json['userId'],
    );
  }
  String toJson() => json.encode(toMap());
}

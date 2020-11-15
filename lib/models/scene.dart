import 'dart:ui';
import 'user.dart';

class Scene {
  int id;
  String sceneName, address1, address2, zip;
  String createdAt, updatedAt, fileId;
  Scene(
      {this.id,
      this.sceneName,
      this.address1,
      this.address2,
      this.zip,
      this.createdAt,
      this.updatedAt,
      this.fileId});
  factory Scene.fromJson(Map<String, dynamic> json) {
    return Scene(
      id: json['id'],
      sceneName: json['sceneName'],
      address1: json['address1'],
      address2: json['address2'],
      zip: json['zip'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      fileId: json['fileId'],
    );
  }
}

import 'dart:ui';
import 'user.dart';

class Scene {
  int sceneId;
  String sceneName, address1, address2, zip;
  String createdAt, fileId;
  Scene(
      {this.sceneId,
      this.sceneName,
      this.address1,
      this.address2,
      this.zip,
      this.createdAt,
      this.fileId});
  factory Scene.fromJson(Map<String, dynamic> json) {
    return Scene(
      sceneId: json['sceneId'],
      sceneName: json['sceneName'],
      address1: json['address1'],
      address2: json['address2'],
      zip: json['zip'],
      createdAt: json['createdAt'],
      fileId: json['fileId'],
    );
  }
}

import 'dart:ui';
import 'user.dart';
import 'scene.dart';

class Event {
  int eventId;
  String eventName, eventStartedAt, eventStatus;
  int teamLeader;
  String createdAt;
  List<Scene> scenes = List();
  List<User> teamMembers = List();
  Event(
      {this.eventId,
      this.eventName,
      this.eventStartedAt,
      this.eventStatus,
      this.createdAt,
      this.teamLeader,
      this.scenes,
      this.teamMembers});
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventId: json['eventId'],
      eventName: json['eventName'],
      eventStartedAt: json['eventStartedAt'],
      eventStatus: json['eventStatus'],
      teamLeader: json['teamLeader'],
      scenes: json['scenes'] == null
          ? List()
          : (json['scenes']['scenes'] as List)
              .map((s) => Scene.fromJson(s))
              .toList(),
      teamMembers: json['teamMembers'] == null
          ? List()
          : (json['teamMembers'] as List).map((m) => User.fromJson(m)).toList(),
    );
  }
  setScenes(List scenes) {
    this.scenes = scenes;
  }

  setTeamMembers(List users) {
    this.teamMembers = users;
  }
  // void updateEvent(String eventName, String happenedAt, address, eventStatus) {
  //   this.eventName = eventName;
  //   this.eventStartedAt = happenedAt;
  //   this.address = address;
  //   this.eventStatus = eventStatus;
  //   this.supervisor = supervisor;
  //   this.participants = participants;
  // }
}

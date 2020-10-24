import 'dart:ui';
import 'user.dart';

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
      eventName: json['eventName'],
      eventStartedAt: json['eventStartedAt'],
      eventStatus: json['eventStatus'],
      teamLeader: json['teamLeader'],
    );
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

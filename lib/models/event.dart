import 'user.dart';

class Event {
  String eventName, happenedAt, address, eventStatus;
  User supervisor;
  List<User> participants = List();
  Event(String eventName, String happenedAt, address, eventStatus,
      User supervisor, List<User> participants) {
    this.eventName = eventName;
    this.happenedAt = happenedAt;
    this.address = address;
    this.eventStatus = eventStatus;
    this.supervisor = supervisor;
    this.participants = participants;
  }
  void updateEvent(String eventName, String happenedAt, address, eventStatus) {
    this.eventName = eventName;
    this.happenedAt = happenedAt;
    this.address = address;
    this.eventStatus = eventStatus;
    this.supervisor = supervisor;
    this.participants = participants;
  }
}

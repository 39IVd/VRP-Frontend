import 'user.dart';

class Event {
  String eventName, happenedAt, eventStartedAt, address1, address2, eventStatus;
  User supervisor;
  List<User> participants = List();
  Event(String eventName, String happenedAt, eventStartedAt, address1, address2,
      eventStatus, User supervisor, List<User> participants) {
    this.eventName = eventName;
    this.happenedAt = happenedAt;
    this.eventStartedAt = eventStartedAt;
    this.address1 = address1;
    this.address2 = address2;
    this.eventStatus = eventStatus;
    this.supervisor = supervisor;
    this.participants = participants;
  }
}

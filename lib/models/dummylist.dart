import 'user.dart';
import 'event.dart';

List<User> dummyUserList = [
  User('aa@gmail.com', 'aa', '이승주', '팀장'),
  User('bb@gmail.com', 'bb', '박종현', '팀원'),
  User('cc@gmail.com', 'cc', '이종완', '팀원'),
  User('dd@gmail.com', 'dd', '임준혁', '팀원'),
];
List<Event> dummyEventList = [
  Event('화양동사건1', '20200202', '서울시 광진구 아차산로 344 111호', '기소완료', dummyUserList[0],
      dummyUserList),
  Event('자양동사건1', '20200503', '서울시 광진구 자양동 222 102호', '재판중', dummyUserList[1],
      dummyUserList),
  Event('구의동사건1', '20200607', '서울시 광진구 구의동 183 404호', '기소 전', dummyUserList[2],
      dummyUserList),
  Event('화양동사건2', '20200202', '서울시 광진구 아차산로 344 111호', '기소완료', dummyUserList[3],
      dummyUserList),
  Event('자양동사건2', '20200503', '서울시 광진구 자양동 222 102호', '재판중', dummyUserList[0],
      dummyUserList),
  Event('구의동사건2', '20200607', '서울시 광진구 구의동 183 404호', '기소 전', dummyUserList[0],
      dummyUserList),
];

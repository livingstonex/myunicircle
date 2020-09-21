import 'package:MyUnicircle/Models/reply_model.dart';
import 'package:MyUnicircle/Models/user_model.dart';

class Comment {
  String id;
  String postId;
  User user;
  String body;
  DateTime time;
  List<Reply> replies;
}

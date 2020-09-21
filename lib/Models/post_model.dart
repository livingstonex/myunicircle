import 'package:MyUnicircle/Models/comment_model.dart';
import 'package:MyUnicircle/Models/like_model.dart';
import 'package:MyUnicircle/Models/user_model.dart';

class Post {
  String id;
  User user;
  String title;
  DateTime dateTime;
  String body;
  List<Comment> comments;
  List<Like> likes;
}

import 'package:flutter/material.dart';

class AllFeeds {
  String feed_id;
  String userid;
  String user_image;
  String user_name;
  String title;
  String media;
  String created_at;
  String status;

  AllFeeds(
      {this.feed_id,
      this.userid,
      this.user_name,
      this.title,
      this.media,
      this.created_at,
      this.status,
      this.user_image});

  factory AllFeeds.fromJson(Map<String, dynamic> json) {
    return AllFeeds(
      feed_id: json['feed_id'] as String,
      userid: json['userid'] as String,
      user_name: json['user_name'] as String,
      title: json['title'] as String,
      media: json['media'] as String,
      status: json['bizRevFunction'] as String,
      created_at: json['created_at'] as String,
      user_image: json['user_image'] as String,
    );
  }
}

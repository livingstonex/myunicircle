import 'package:flutter/material.dart';




class AllProj {
  String id;
  String userId;
  String bizName;
  String bizDesc;
  String bizEcoFriendly;
  String bizRevFunction;
  String bizRevenue;
  String bizTeamProfile;
  String bizStage;
  String bizCategory;
  String pitchTime;
  String pitchCode;
  String Live;


  AllProj({
    this.id,
    this.userId,
    this.bizName,
    this.bizDesc,
    this.bizEcoFriendly,
    this.bizRevFunction,
    this.bizRevenue,
    this.bizTeamProfile,
    this.bizStage,
    this.bizCategory,
    this.pitchTime,
    this.pitchCode,
    this.Live,
  });


  factory AllProj.fromJson(Map<String, dynamic> json){
    return AllProj(
      id: json['id'] as String,
      userId: json['userId'] as String,
      bizName: json['bizName'] as String,
      bizDesc: json['bizDesc'] as String,
      bizEcoFriendly: json['bizEcoFriendly'] as String,
      bizRevFunction: json['bizRevFunction'] as String,
      bizRevenue: json['bizRevenue'] as String,
      bizTeamProfile: json['bizTeamProfile'] as String,
      bizStage: json['bizStage'] as String,
      bizCategory: json['bizCategory'] as String,
      pitchTime: json['pitchTime'] as String,
      pitchCode: json['pitchCode'] as String,
      Live: json['Live'] as String,
    );
  }
}
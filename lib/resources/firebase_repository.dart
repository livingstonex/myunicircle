import 'dart:io';

import 'package:MyUnicircle/Models/message_model.dart';
import 'package:MyUnicircle/Models/user_model.dart';
import 'package:MyUnicircle/provider/image_provider.dart';
import 'package:flutter/material.dart';
import 'firebase_methods.dart' as _firebaseRepo;

Future<void> addMessageToDB(MessageModel message, User sender, User receiver) =>
    _firebaseRepo.addMessageToDb(message, sender, receiver);

void uploadImage(
        {@required File image,
        @required String receiverId,
        @required String senderId,
        @required ImageUploadProvider imageUploadProvider}) =>
    _firebaseRepo.uploadImage(image, receiverId, senderId, imageUploadProvider);

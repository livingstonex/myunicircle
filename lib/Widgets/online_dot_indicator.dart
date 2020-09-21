import 'package:MyUnicircle/Models/user_model.dart';
import 'package:MyUnicircle/enum/user_state.dart';
import 'package:MyUnicircle/utilities/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:MyUnicircle/resources/firebase_methods.dart' as firebaseRepo;

class OnlineDotIndicator extends StatelessWidget {
  final String id;

  const OnlineDotIndicator({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    getColor(int state) {
      switch (Utils.numToState(state)) {
        case UserState.Offline:
          return Colors.red;
        case UserState.Online:
          return Colors.green;
        default:
          return Colors.orange;
      }
    }

    return Align(
        alignment: Alignment.bottomRight,
        child: StreamBuilder<DocumentSnapshot>(
            stream: firebaseRepo.getUserStream(id: id),
            builder: (context, snapshot) {
              User user;
              if (snapshot.hasData && snapshot.data.data != null) {
                user = User.fromJSON(snapshot.data.data());
              }

              return Container(
                  height: 10,
                  width: 10,
                  margin: EdgeInsets.only(right: 8, top: 8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: getColor(user?.state)));
            }));
  }
}

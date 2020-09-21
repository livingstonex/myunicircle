class User {
  String id;
  String username;
  String email;
  String accessToken;
  String phone;
  String image;
  String firstname;
  String lastname;
  int state = 1;

  // used for indicate if client logged in or not
  bool auth;

//  String role;

  User(
      {this.id,
      this.username,
      this.email,
      this.accessToken,
      this.firstname,
      this.lastname,
      this.phone,
      this.image});

  User.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['userid'].toString();
    username = jsonMap['username'];
    email = jsonMap['email'];
    accessToken = jsonMap['access_token'];
    phone = jsonMap['phone'];
    image = jsonMap['profile_picture'];
    firstname = jsonMap['first_name'];
    lastname = jsonMap['last_name'];
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["userid"] = id;
    map["username"] = username;
    map["email"] = email;
    map["access_token"] = accessToken;
    map["phone"] = phone;
    map["profile_picture"] = image;
    map["first_name"] = firstname;
    map["last_name"] = lastname;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}

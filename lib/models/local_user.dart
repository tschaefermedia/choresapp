class LocalUser {
  String uid;
  String name;
  bool emailVerified;
  String username;
  String email;

  LocalUser(
      {required this.uid,
      required this.name,
      required this.emailVerified,
      required this.username,
      required this.email});

  String getUserID() {
    return this.uid;
  }

  String getName() {
    return this.name;
  }

  bool isEmailVerified() {
    return this.emailVerified;
  }

  String getUsername() {
    return this.username;
  }

  String getEmail() {
    return this.email;
  }
}

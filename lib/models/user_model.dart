class User {
  String id;
  final String firstName;
  final String lastName;
  final String username;
  final String phoneNumber;
  final String email;

  User({
    this.id = '',
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.phoneNumber,
    required this.email,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'username': username,
        'phoneNumber': phoneNumber,
        'email': email,
      };
  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        username: json['username'],
        phoneNumber: json['phoneNumber'],
        email: json['email'],
      );
}

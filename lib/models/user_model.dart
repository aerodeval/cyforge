class UserModel {
  String? cehNumber;
  String? email;
  String? firstName;
  String? clink;
  String? password;
  String? organization;
  String? pno;



  UserModel({this.cehNumber, this.email,this.clink, this.firstName,this.password,this.organization,this.pno});


  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      cehNumber: map['CEH'],
      email: map['email'],
      firstName: map['firstName'],
      organization: map['organization'],
      password:map['passwordLogin'],
      clink:map['driveLink'],
      pno: map['phone'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'CEH': cehNumber,
      'email': email,
      'firstName': firstName,
      'organization':organization,
      'passwordLogin':password,
      'driveLink':clink,
      'phone':pno,
    
    };
  }
}
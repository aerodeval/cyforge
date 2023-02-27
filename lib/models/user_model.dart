class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? cname;
  String? password;
  String? utype;
  String? pno;
  String? pdf;
  String? pic;
  DateTime? year;
  UserModel({this.uid,this.year, this.email,this.cname, this.firstName,this.password,this.utype,this.pno,this.pdf,this.pic});


  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      utype: map['userType'],
      password:map['passwordLogin'],
      cname:map['College'],
      pno: map['phone'],
      pdf:map['pdf'],
      pic: map['pic'],
          year: map['year']
      
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'userType':utype,
      'passwordLogin':password,
      'College':cname,
      'phone':pno,
      'pdf':pdf
      ,'pic':pic,
      'year':year
    };
  }
}
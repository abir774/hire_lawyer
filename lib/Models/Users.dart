class Cusers {
  String Name;
  String uid;
  String LastName;
  String Role;
  String Email;
  String Url;
  Cusers({this.uid, this.Name, this.LastName, this.Email, this.Role, this.Url});
  factory Cusers.fromJson(Map<String, dynamic> json) => Cusers(
        uid: json["uid"],
        Name: json["name"],
        LastName: json["lastname"],
        Email: json["email"],
        Role: json["role"],
        Url: json["url"],
      );
  Map<String, dynamic> Tojson() {
    return {
      "uid": uid,
      "name": Name,
      "lastname": LastName,
      "Email": Email,
      "role": Role,
      "url": Url
    };
  }
}

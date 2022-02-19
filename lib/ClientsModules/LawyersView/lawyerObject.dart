class LawyersObject{
  String LawyerName;
  String LastName;
  String LawyerAge;
  LawyersObject.fromJson(String json) {
    LawyerName = json;
    LastName = json;
    LawyerAge = json;

  }

}
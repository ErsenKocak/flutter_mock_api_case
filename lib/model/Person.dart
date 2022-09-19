class Person {
  String? name;
  String? surname;
  String? birthDate;
  double? sallary;
  String? phoneNumber;
  String? identity;
  String? imageUrl;
  String? jobTitle;
  String? companyName;
  String? jobDescription;
  String? id;

  Person(
      {this.name,
      this.surname,
      this.birthDate,
      this.sallary,
      this.phoneNumber,
      this.identity,
      this.imageUrl,
      this.jobTitle,
      this.companyName,
      this.jobDescription,
      this.id});

  Person.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    surname = json['surname'];
    birthDate = json['birthDate'];
    sallary = json['sallary'] is int
        ? (json['sallary'] as int).toDouble()
        : json['sallary'];
    phoneNumber = json['phoneNumber'];
    identity = json['identity'];
    imageUrl = json['imageUrl'];
    jobTitle = json['jobTitle'];
    companyName = json['companyName'];
    jobDescription = json['jobDescription'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    (name != null) ? data['name'] = name : null;
    (surname != null) ? data['surname'] = surname : null;
    (birthDate != null) ? data['birthDate'] = birthDate : null;
    (sallary != null) ? data['sallary'] = sallary : null;
    (phoneNumber != null) ? data['phoneNumber'] = phoneNumber : null;
    (identity != null) ? data['identity'] = identity : null;
    (imageUrl != null) ? data['imageUrl'] = imageUrl : null;
    (jobTitle != null) ? data['jobTitle'] = jobTitle : null;
    (companyName != null) ? data['companyName'] = companyName : null;
    (jobDescription != null) ? data['jobDescription'] = jobDescription : null;
    (id != null) ? data['id'] = id : null;
    return data;
  }
}

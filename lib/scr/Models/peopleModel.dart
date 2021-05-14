class PeopleModel {
  List<PeopleData> peopleList;
  PeopleModel({this.peopleList, });
  PeopleModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      peopleList = new List<PeopleData>();
      json['data'].forEach((v) {
        peopleList.add(new PeopleData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.peopleList != null) {
      data['data'] = this.peopleList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PeopleData {
  int id;
  String firstName;
  String lastName;
  String age;
  String activeDate;
  String createdAt;
  String updatedAt;

  PeopleData(
      {this.id,
        this.firstName,
        this.lastName,
        this.age,
        this.activeDate,
        this.createdAt,
        this.updatedAt});

  PeopleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    age = json['age'];
    activeDate = json['active_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['age'] = this.age;
    data['active_date'] = this.activeDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

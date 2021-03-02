

class ReferencePersonModel {
  String name;
  String contact;
  String email;

  ReferencePersonModel() {
    name = "";
    contact = "";
    email = "";
  }
  ReferencePersonModel.api(Map<String, dynamic> json) {
    this.name = json['name'] ?? '';
    this.email = json['email'] ?? '';
    this.contact = json['contact'] ?? '';
  }
}
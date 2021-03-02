



class SeedValueModel {
  String id;
  String type;
  String value;
  bool isActive;

  SeedValueModel() {
    id = "";
    type = "";
    value = "";
    isActive = false;
  }
  SeedValueModel.api(Map<String, dynamic> json,{bool isPet = false}) {
    this.id = json['id'] ?? '';
    this.type = json['type'] ?? '';
    this.value = json['value'] ?? '';
    this.isActive = json['isActive'] ?? false;
  }
}
  class SeedValueListMode{
var petValues = List<SeedValueModel>();
var genderValues = List<SeedValueModel>();
var SPTypeValues = List<SeedValueModel>();

  SeedValueListMode.api(var json) {
    for(var each in json){
      var model = SeedValueModel.api(each);
      if (model.type.toLowerCase() == 'pets'){
        petValues.add(model);
      }else if (model.type.toLowerCase() == 'gender'){
        genderValues.add(model);
      }else if (model.type.toLowerCase() == 'serviceprovidertypes'){
        SPTypeValues.add(model);
      }
    }

    }


}
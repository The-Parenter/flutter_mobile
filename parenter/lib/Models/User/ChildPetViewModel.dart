



class ChildPetViewModel {
  String name;
  String age;
  String gender;
  String type;
  String allergies;
  String sleepSchedule;
  String food;
  String language;
  String additional;
  bool isSpecial;
  bool isSelected = false;

  ChildPetViewModel() {
   name = "";
   age = "";
   allergies = "";
   sleepSchedule = "";
   food = "";
   language = "";
   additional = "";
   gender = null;
   type = null;
   isSpecial = false;
   isSelected = false;
  }
  ChildPetViewModel.api(Map<String, dynamic> json,{bool isPet = false}) {
    this.name = json['name'] ?? '';
    this.age = json['age'] ?? '';
    this.gender = json['gender'] ?? '';
    if (isPet) {
      this.type = json['type'] ?? '';
      this.additional = json['additionalComments'] ?? '';
    }else{
      type = "";
      this.allergies = json['allergies'] ?? '';
      this.sleepSchedule = json['sleepingScheduled'] ?? '';
      this.food = json['foodLikesAndDislikes'] ?? '';
      this.language = json['languagesSpoken'] ?? '';
      this.additional = json['additionalComments'] ?? '';
      this.isSpecial = json['reqSpecialNeeds'] ?? false;
    }
  }
}

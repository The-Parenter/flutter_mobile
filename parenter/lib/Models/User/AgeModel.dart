
class AgeModel{
  var title = "";
  var isSelected = false;

  AgeModel.init(String title,bool isSelected){
    this.title = title;
    this.isSelected = isSelected;
  }
}


var DAY_CARE_AGE_CONSTANTS = [
  AgeModel.init("0 to 1.5 years",false),
  AgeModel.init("1.5 to 2.5 years",false),
  AgeModel.init("2.5 to 6 years",false),
  AgeModel.init("6 to 13 years    ",false),
  AgeModel.init("9 to 13 years",false),
];
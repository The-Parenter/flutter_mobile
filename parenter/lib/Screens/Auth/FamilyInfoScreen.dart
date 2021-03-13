import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Helper/HelperFunctions.dart';
import 'package:parenter/Helper/SPManager.dart';
import 'package:parenter/Models/User/ChildPetViewModel.dart';
import 'package:parenter/Models/User/UserViewModel.dart';
import 'package:parenter/Screens/Home/BottomTabsScreen.dart';
import 'package:parenter/Widgets/AppButton.dart';
import 'package:parenter/Widgets/textFeild.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';
import 'package:progress_dialog/progress_dialog.dart';

class FamilyInformationScreen extends StatefulWidget {
  static String routeName = '/FamilyInformationScreen';
  final UserViewModel registerUser;

  FamilyInformationScreen(this.registerUser);
  @override
  _FamilyInformationScreenState createState() =>
      _FamilyInformationScreenState();
}

class _FamilyInformationScreenState extends State<FamilyInformationScreen> {
  double totalChildren = 1;
  double totalPets = 1;

  List<ChildPetViewModel> childs = [ChildPetViewModel()];
  List<ChildPetViewModel> pets = [ChildPetViewModel()];
  ProgressDialog progressDialog;

  void _addChildCell() {
    totalChildren += 1;
    childs.add(ChildPetViewModel());
    setState(() {});
  }

  void _addPetCell() {
    totalPets += 1;
    pets.add(ChildPetViewModel());
    setState(() {});
  }

  void _removeChildCell(int index) {
    totalChildren -= 1;
    childs.removeAt(index);
    setState(() {});
  }

  void _removePetCell(int index) {
    totalPets -= 1;
    pets.removeAt(index);
    setState(() {});
  }

  Widget _childCell(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right:16.0),
                child: InkWell(
                    onTap: (){
                      _removeChildCell(index);
                    },
                    child: Icon(Icons.delete_outline,size: 25,color: AppColors.appPinkColor,
                    )),
              ),
            ],
          ),

          Row(
            children: [
              Checkbox(
                  value: childs[index].isSpecial, onChanged: (value){
                setState(() {
                  childs[index].isSpecial = value;
                });
              }),
              Text('Special Needs'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Name of Child *',
              style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
              width:  double.infinity,
              child: TextField(
                onChanged: (value){
                  childs[index].name = value;
                },
                cursorColor: AppColors.appPinkColor,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30))),
              ),
          ),
        ],
      ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Age *',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                      width: (MediaQuery.of(context).size.width / 2 - 32),
                      child: TextField(
                        onChanged: (value){
                          childs[index].age = value;
                        },
                        cursorColor: AppColors.appPinkColor,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20),
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30))),
                      )
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Gender *',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:0.0),
                    child: Container(
                        width:(MediaQuery.of(context).size.width / 2) - 24,
                        child:  Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(25))
                          ),
                          width: MediaQuery.of(context).size.width/2 ,
                          child: Padding(
                            padding: const EdgeInsets.only(left:16.0,right: 8),
                            child: new DropdownButton<String>(
                              isExpanded: true,
                              iconEnabledColor: AppColors.appPinkColor,
                              underline: Container(),
                              items: <String>['Boy', 'Girl', 'Rather Not Say'].map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              value:  childs[index].gender,
                              onChanged: (val) {
                                  setState(() {
                                    childs[index].gender = val;
                                  });
                              },
                            ),
                          ),
                        )
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top:8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Allergies',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  width:  double.infinity,
                  child: TextField(
                    onChanged: (value){
                      childs[index].allergies = value;
                    },
                    cursorColor: AppColors.appPinkColor,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Sleep schedule',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  width:  double.infinity,
                  child: TextField(
                    onChanged: (value){
                      childs[index].sleepSchedule = value;
                    },
                    cursorColor: AppColors.appPinkColor,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Food likes and dislikes',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  width:  double.infinity,
                  child: TextField(
                    onChanged: (value){
                      childs[index].food = value;
                    },
                    cursorColor: AppColors.appPinkColor,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Languages spoken',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  width:  double.infinity,
                  child: TextField(
                    onChanged: (value){
                      childs[index].language = value;
                    },
                    cursorColor: AppColors.appPinkColor,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Additional comments',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  width:  double.infinity,
                  child: TextField(
                    onChanged: (value){
                      childs[index].additional = value;
                    },
                    cursorColor: AppColors.appPinkColor,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget _petCell(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right:16.0),
                child: InkWell(
                    onTap: (){
                      _removePetCell(index);
                    },
                    child: Icon(Icons.delete_outline,size: 25,color: AppColors.appPinkColor,
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Name of Pet *',
              style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            width:  double.infinity,
            child: TextField(
              onChanged: (value){
                pets[index].name = value;
              },
              cursorColor: AppColors.appPinkColor,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20),
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),


      SizedBox(
        height: 8,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Age *',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                  width: (MediaQuery.of(context).size.width / 2 - 32),
                  child: TextField(
                    onChanged: (value){
                      pets[index].age = value;
                    },
                    cursorColor: AppColors.appPinkColor,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30))),
                  )
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Type *',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:0.0),
                child: Container(
                    width:(MediaQuery.of(context).size.width / 2) - 24,
                    child:  Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(25))
                      ),
                      width: MediaQuery.of(context).size.width/2 ,
                      child: Padding(
                        padding: const EdgeInsets.only(left:16.0,right: 8),
                        child: new DropdownButton<String>(
                          isExpanded: true,
                          iconEnabledColor: AppColors.appPinkColor,
                          underline: Container(),
                          items: <String>['Cat', 'Dog', 'Bird','Other'].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          value:  pets[index].type,
                          onChanged: (val) {
                            setState(() {
                              pets[index].type = val;
                            });
                          },
                        ),
                      ),
                    )
                ),
              ),
            ],
          ),
        ],
      ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0,top: 8),
                child: Text(
                  'Gender *',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:0.0),
                child: Container(
                    width:(MediaQuery.of(context).size.width / 2) - 24,
                    child:  Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(25))
                      ),
                      width: MediaQuery.of(context).size.width/2 ,
                      child: Padding(
                        padding: const EdgeInsets.only(left:16.0,right: 8),
                        child: new DropdownButton<String>(
                          isExpanded: true,
                          iconEnabledColor: AppColors.appPinkColor,
                          underline: Container(),
                          items: <String>['Male', 'Female'].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          value:  pets[index].gender,
                          onChanged: (val) {
                            setState(() {
                              pets[index].gender = val;
                            });
                          },
                        ),
                      ),
                    )
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16.0,top: 8),
            child: Text(
              'Additional information',
              style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            width:  double.infinity,
            child: TextField(
              onChanged: (value){
                childs[index].additional = value;
              },
              cursorColor: AppColors.appPinkColor,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20),
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
      ]
    )
    );
  }

  Widget _dropDownWithTextField(String label,
      {TextEditingController controller = null, bool isFullWidth = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:16.0),
          child: Container(
              width: isFullWidth
                  ? double.infinity
                  : (MediaQuery.of(context).size.width / 2) - 32,
              child:  Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                width: MediaQuery.of(context).size.width/2 ,
                child: new DropdownButton<String>(
                  iconEnabledColor: AppColors.appPinkColor,
                    underline: Container(),
                  items: <String>['A', 'B', 'C', 'D'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {

                  },
                ),
              )
          ),
        ),
      ],
    );
  }

  Widget _labelWithTextField(String label, TextInputType keyboardType,
      {TextEditingController controller = null, bool isFullWidth = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
            width: isFullWidth
                ? double.infinity
                : (MediaQuery.of(context).size.width / 2),
            child: appTextField(
              '',
              Icon(
                Icons.email,
                size: 0,
                color: AppColors.appPinkColor,
              ),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    progressDialog.style(
      message: 'Please wait...',
      progressWidget: CircularProgressIndicator(
        backgroundColor: AppColors.appPinkColor,
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.appBGColor,
      appBar: AppBar(
        title: Text(
          AppStrings.CREATE_PROFILE,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
//              SizedBox(
//                height: 24,
//              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: [
//                  _labelWithTextField(
//                      AppStrings.NO_OF_KIDS, TextInputType.number),
//                  _labelWithTextField(
//                      AppStrings.NO_OF_PETS, TextInputType.number),
//                ],
//              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  AppStrings.ADD_CHILD,
                  style: Theme.of(context).textTheme.headline2.copyWith(
                      color: AppColors.appPinkColor,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                height: totalChildren * 620,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: totalChildren.round(),
                  itemBuilder: (BuildContext context, int index) {
                    return _childCell(index);
                  },
                ),
              ),
              InkWell(
                  onTap: () {
                    _addChildCell();
                  },
                  child: Center(
                    child: Container(
                      height: 56,
                      width: MediaQuery.of(context).size.width - 48,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.appPinkColor, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(28))),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              color: AppColors.appPinkColor,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              AppStrings.ADD_CHILD,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: AppColors.appPinkColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  AppStrings.ADD_PET,
                  style: Theme.of(context).textTheme.headline2.copyWith(
                      color: AppColors.appPinkColor,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                height: totalPets * 360,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: totalPets.round(),
                  itemBuilder: (BuildContext context, int index) {
                    return _petCell(index);
                  },
                ),
              ),
              InkWell(
                  onTap: () {
                    _addPetCell();
                  },
                  child: Center(
                    child: Container(
                      height: 56,
                      width: MediaQuery.of(context).size.width - 48,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.appPinkColor, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(28))),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              color: AppColors.appPinkColor,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              AppStrings.ADD_PET,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: AppColors.appPinkColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
              ),
              SizedBox(
                height: 48,
              ),
              InkWell(
                onTap: (){
                  _validateAndSendRequest(context);
                },
                child: AppButton(
                  btnTitle: AppStrings.SAVE,
                ),
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _validateAndSendRequest(BuildContext context){
    for (var each in this.childs){
      if (each.name.isEmpty || each.age.isEmpty ||
          each.gender.isEmpty ) {
        showAlertDialog(context, AppStrings.VALIDATION_FAILED, AppStrings.FORM_FILL_MESSAGE, false, (){});
        return;
      }
    }

    for (var each in this.pets){
      if (each.name.isEmpty || each.age.isEmpty ||
          each.type.isEmpty ) {
        showAlertDialog(context, AppStrings.VALIDATION_FAILED, AppStrings.FORM_FILL_MESSAGE, false, (){});
        return;
      }
    }

    _sendSignUpRequest(context);

  }

  List<Map<String, dynamic>> getParamDict(List<ChildPetViewModel> list,bool isPet){
    var result =  List<Map<String, dynamic>>();
    if (isPet){
      for (var each in list){
        var dict = Map<String, dynamic>();
        dict['Name'] = each.name;
        dict['Type'] = each.type;
        dict['Age'] = each.age;
        dict['Gender'] = each.gender;
        dict['AdditionalInformation'] = each.additional;
        result.add(dict);
      }
      return result;
      }
    else{
         for (var each in list){
         var dict = Map<String, dynamic>();
          dict['Name'] = each.name;
          dict['Age'] = each.age;
          dict['Gender'] = each.gender; //each.name;
          dict['Allergies'] = each.allergies;
          dict['SleepingScheduled'] = each.sleepSchedule;
          dict['FoodLikesAndDislikes'] = each.food;
          dict['LanguagesSpoken'] = each.language;
          dict['AdditionalComments'] = each.additional;
          dict['ReqSpecialNeeds'] = each.isSpecial;
         result.add(dict);
         }
         return result;
    }
  }

  void _sendSignUpRequest(BuildContext context) {
    check().then((internet) {
      if (internet != null && internet) {
        progressDialog.show();
        Map<String, dynamic> parameters = Map();
        parameters['FirstName'] = this.widget.registerUser.firstName;
        parameters['LastName'] = this.widget.registerUser.lastName;
        parameters['Email'] = this.widget.registerUser.email;
        parameters['Password'] = this.widget.registerUser.password;
        parameters['Phone'] = this.widget.registerUser.phoneNumber;
        parameters['PostalAddress'] = this.widget.registerUser.address;
        parameters['ChildCount'] = this.childs.length.toString();
        parameters['PetsCount'] = this.pets.length.toString();
        parameters['Longitude'] = this.widget.registerUser.longitude;
        parameters['Latitude'] = this.widget.registerUser.latitude;
        parameters['UnitNo'] = this.widget.registerUser.unitNo;
        parameters['ListChildren'] = getParamDict(this.childs,false);
        parameters['ListPets'] = getParamDict(this.pets,true);
        HTTPManager().registerParentUser(parameters).then((onValue) {
          progressDialog.hide();
          final response = onValue;
          if (response['responseCode'] == "01") {
            var user = UserViewModel.api(response['data']);
            Global.currentUser = user;
            Global.token = user.token;
            Global.userId = user.id;
            var manager = SharedPreferenceManager();
            manager.saveUserToken();
            manager.setUserId(Global.userId);
            manager.saveUserType(Global.userType == UserType.Parent);
            Navigator.of(context).pushNamedAndRemoveUntil(
                BottomTabsScreen.routeName, (route) => false);
          } else {
            showAlertDialog(context, 'Error', response['responseMessage'], false, null);
          }
        });
      }else {
        showAlertDialog(context, 'No Internet',
            'Make sure you are connected to internet.', true, () {
              Navigator.of(context).pop();
              _sendSignUpRequest(context);
            });
      }
    });
  }
}

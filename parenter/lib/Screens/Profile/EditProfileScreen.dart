import 'package:flutter/material.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Helper/HelperFunctions.dart';
import 'package:parenter/Models/User/ChildPetViewModel.dart';
import 'package:parenter/Models/User/ServiceProviderRigester.dart';
import 'package:parenter/Models/User/UserViewModel.dart';
import 'package:parenter/Screens/Auth/ParentSignup.dart';
import 'package:parenter/Widgets/AppButton.dart';
import 'package:parenter/Widgets/AvailabilityWIdget.dart';
import 'package:parenter/Widgets/textFeild.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
class EditProfileScreen extends StatefulWidget {
  static String routeName = '/EditProfileScreen';


  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CalendarController _controller;
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  Mode _mode = Mode.overlay;
  double totalChildren = 1;
  double totalPets = 1;
  List<ChildPetViewModel> childs = [ChildPetViewModel()];
  List<ChildPetViewModel> pets = [ChildPetViewModel()];
  ProgressDialog progressDialog;

  UserViewModel data = UserViewModel();
  ServiceProviderRegisterModel spData = ServiceProviderRegisterModel();
  bool isParentUser = false;

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();



//  void getUserDetails() {
//    HTTPManager()
//        .getUser()
//        .then((val) {
//      this.data = val;
//      print(val);
//      setState(() {
//        //this.isLoading = false;
//        name.text = data.firstName + ' ' + data.lastName;
//        email.text = data.email;
//        number.text = data.phoneNumber;
//        address.text = data.address;
//        childs = data.childs;
//        totalChildren = data.childs.length.roundToDouble();
//        pets = data.pets;
//        totalPets = data.pets.length.roundToDouble();
//      });
//
//    });
//  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();
    this.data = Global.currentUser;
    this.spData = Global.currentServiceProvider;
    this.isParentUser = Global.userType == UserType.Parent;
    if (isParentUser){
      setUserData();
    }else{
      setSPData();
    }
    childs = data.childs;
    pets = data.pets;
    totalChildren = childs.length.roundToDouble();
    totalPets = pets.length.roundToDouble();
    setState(() {

    });
   // getUserDetails();
  }


  void setUserData(){
    fnameController.text = data.firstName;
    lnameController.text = data.lastName;
    emailController.text = data.email;
    numberController.text = data.phoneNumber;
    addressController.text = data.address;

  }

  void setSPData(){
    fnameController.text = spData.firstName;
    lnameController.text = spData.lastName;
    emailController.text = spData.emailAddress;
    numberController.text = spData.phone;
    addressController.text = spData.postalAddress;
  }

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
    TextEditingController childName = TextEditingController(text: childs[index].name);
    TextEditingController childAge = TextEditingController(text: childs[index].age);
    TextEditingController childAllergies = TextEditingController(text: childs[index].allergies);
    TextEditingController childSleep = TextEditingController(text: childs[index].sleepSchedule);
    TextEditingController childFood = TextEditingController(text: childs[index].food);
    TextEditingController childLanguage = TextEditingController(text: childs[index].language);
    TextEditingController childComments = TextEditingController(text: childs[index].additional);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 16),
      child: Column(
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
          SizedBox(
            height: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Text(
                  'Name of Child',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width:  double.infinity,
                child: TextField(
                  style:TextStyle(fontSize: 12) ,
                  controller: childName,
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
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: Text(
                      'Age',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                      width: (MediaQuery.of(context).size.width / 2 - 32),
                      child: TextField(
                        controller: childAge,
                        style:TextStyle(fontSize: 12) ,
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
                      )
                  ),
                ],
              ),
//              Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: [
//                  Padding(
//                    padding: const EdgeInsets.only(left: 6.0),
//                    child: Text(
//                      'Gender',
//                      style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
//                    ),
//                  ),
//                  SizedBox(
//                    height: 8,
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.symmetric(horizontal:0.0),
//                    child: Container(
//                        width:(MediaQuery.of(context).size.width / 2) - 24,
//                        child:  Container(
//                          height: 50,
//                          decoration: BoxDecoration(
//                              color: Colors.white,
//                              borderRadius: BorderRadius.all(Radius.circular(25))
//                          ),
//                          width: MediaQuery.of(context).size.width/2 ,
//                          child: Padding(
//                            padding: const EdgeInsets.only(left:16.0,right: 8),
//                            child: new DropdownButton<String>(
//                              isExpanded: true,
//                              iconEnabledColor: AppColors.appPinkColor,
//                              underline: Container(),
//                              items: <String>['Male', 'Female', 'Rather Not Say'].map((String value) {
//                                return new DropdownMenuItem<String>(
//                                  value: value,
//                                  child: new Text(value,style:TextStyle(fontSize: 12),),
//                                );
//                              }).toList(),
//                              value:  childs[index].gender,
//                              onChanged: (val) {
//                                setState(() {
//                                  childs[index].gender = val;
//                                });
//                              },
//                            ),
//                          ),
//                        )
//                    ),
//                  ),
//                ],
//              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top:16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                    'Allergies',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width:  double.infinity,
                  child: TextField(
                    style:TextStyle(fontSize: 12) ,
                    controller: childAllergies,
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
            padding: const EdgeInsets.only(top:16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                    'Sleep schedule',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width:  double.infinity,
                  child: TextField(
                    style:TextStyle(fontSize: 12) ,
                    controller: childSleep,
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
            padding: const EdgeInsets.only(top:16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                    'Food likes and dislikes',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width:  double.infinity,
                  child: TextField(
                    style:TextStyle(fontSize: 12) ,
                    controller: childFood,
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
            padding: const EdgeInsets.only(top:16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                    'Languages spoken',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width:  double.infinity,
                  child: TextField(
                    style:TextStyle(fontSize: 12) ,
                    controller: childLanguage,
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
            padding: const EdgeInsets.only(top:16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                    'Additional comments',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width:  double.infinity,
                  child: TextField(
                    style:TextStyle(fontSize: 12) ,
                    controller: childComments,
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
    TextEditingController petName = TextEditingController(text: pets[index].name);
    TextEditingController petAge = TextEditingController(text: pets[index].age);
    TextEditingController petAdditional = TextEditingController(text: pets[index].additional);

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
                  controller: petName,
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
                            controller: petAge,
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
                  controller: petAdditional,
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
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Edit Profile',style: Theme.of(context)
            .textTheme
            .headline2
            .copyWith(color: Colors.black,fontSize: 20),),
        centerTitle: true,
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
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(
                height: 24,
              ),
              appTextField(
                  'First Name',
                  Icon(
                    Icons.person_outline,
                    size: 25,
                    color: AppColors.appPinkColor,
                  ),
                  controller: fnameController
              ),
              SizedBox(
                height: 16,
              ),
              appTextField(
                'Last Name',
                Icon(
                  Icons.person_outline,
                  size: 25,
                  color: AppColors.appPinkColor,
                ),
                controller: this.lnameController,
              ),
              SizedBox(
                height: 16,
              ),
              appTextField(
                  'Phone Number',
                  Icon(
                    Icons.phone,
                    size: 25,
                    color: AppColors.appPinkColor,
                  ),
                  controller: this.numberController,
                  keyBoardType: TextInputType.number
              ),
              SizedBox(
                height: 16,
              ),
              appTextField(
                  'Email Address',
                  Icon(
                    Icons.email,
                    size: 25,
                    color: AppColors.appPinkColor,
                  ),
                  controller: this.emailController,
                  keyBoardType: TextInputType.emailAddress

              ),
              SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () async{

                  _handlePressButton();
                },
                child: appTextField(
                    'Address',
                    Icon(
                      Icons.pin_drop,
                      size: 25,
                      color: AppColors.appPinkColor,
                    ),
                    isEnable: false,
                    controller: this.addressController,
                    keyBoardType: TextInputType.streetAddress
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Column(
                children: Global.userType == UserType.Parent
                    ?[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      AppStrings.CHILD_INFO,
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
                    height: totalChildren * 720,
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
                      )
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      AppStrings.PET_INFO,
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
                ]:[
                  Padding(
                    padding: const EdgeInsets.only(left:0.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                          SizedBox(
                            height: 16,
                          ),

                          appTextField(
                            'Languages Spoken',
                            Icon(
                              Icons.map,
                              size: 25,
                              color: AppColors.appPinkColor,
                            ),
                          ),

                          Global.spType == ServiceProviderType.CareGiver
                              ?
                          Text(
                            'Select Extra Services',
                            style: TextStyle(
                                color: AppColors.textColor, fontSize: 17),
                          ):Container(height: 1,width:1),
                          Container(
                            height: 12,
                          ),
                          Global.spType == ServiceProviderType.CareGiver
                              ?
                          Padding(
                            padding: const EdgeInsets.only(right:8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        value: false, onChanged: (value){

                                    }),
                                    Text('Special Needs'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        value: false, onChanged: (value){
                                    }),
                                    Text('Cleaning'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        value: false, onChanged: (value){
                                    }),
                                    Text('Cooking'),
                                  ],
                                ),
                              ],
                            ),
                          ):Container(height: 1,width:1),
                        ]
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  new Text(
                    'Change Your Availability',
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                  _timeSetWidget(context)
                ],
              ),

              SizedBox(
                height: 40,
              ),
              InkWell(
                  onTap: () {
                    if(this.isParentUser){
                      _parentValidateAndSendRequest(context);
                    }
                  },
                  child: AppButton(
                    btnTitle: AppStrings.UPDATE,
                  )),
              SizedBox(
                height: 48,
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _timeSetWidget(BuildContext context){

    return (Global.spType == ServiceProviderType.Kennel || Global.spType == ServiceProviderType.DayCare)
        ? TableCalendar(
      startDay: DateTime.now(),
      // endDay: DateTime.now().add(Duration(days: 30)),
      initialCalendarFormat: CalendarFormat.month,
      calendarStyle: CalendarStyle(
          todayColor: AppColors.appBottomNabColor,
          selectedColor: AppColors.textColor,
          todayStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
              color: Colors.white)),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonDecoration: BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.circular(22.0),
        ),
        formatButtonTextStyle: TextStyle(color: Colors.white),
        formatButtonShowsNext: false,
      ),
      startingDayOfWeek: StartingDayOfWeek.monday,
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, events) =>
            Container(
                margin: const EdgeInsets.all(5.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(8.0)),
                child: Text(
                  date.day.toString(),
                  style: TextStyle(color: Colors.white),
                )),
        todayDayBuilder: (context, date, events) => Container(
            margin: const EdgeInsets.all(5.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8.0)),
            child: Text(
              date.day.toString(),
              style: TextStyle(color: Colors.white),
            )),
      ),
      calendarController: _controller,
    ): AvailabilityWidget((workingDays){

    });

  }

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: _mode,
      language: "en",
      components: [Component(Component.country, "ca")],
    );

    displayPrediction(p);
  }
  void onError(PlacesAutocompleteResponse response) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      var lat = detail.result.geometry.location.lat;
      var long = detail.result.geometry.location.lng;

      var address  =detail.result.formattedAddress;
      data.address = address;
      data.latitude = '$lat';
      data.longitude = '$long';


      spData.postalAddress = address;
      spData.latitude = '$lat';
      spData.longitude = '$long';


      print(lat);
      print(long);
      print(address);

      setState(() {
        addressController.text = address;
      });
    }
  }



  void _parentValidateAndSendRequest(BuildContext context){

    if (fnameController.text.isEmpty || lnameController.text.isEmpty ||
        numberController.text.isEmpty || emailController.text.isEmpty ||
        addressController.text.isEmpty) {
      showAlertDialog(context,  AppStrings.VALIDATION_FAILED, AppStrings.FORM_FILL_MESSAGE, false, (){});
      return;
    }
    if (!isValidEmail(emailController.text)){
      showAlertDialog(context,  AppStrings.VALIDATION_FAILED, AppStrings.VALID_EMAIL_MESSAGE, false, (){});
      return;
    }

    data.firstName = fnameController.text;
    data.lastName = lnameController.text;
    data.phoneNumber = numberController.text;
    data.email = emailController.text;
    data.address = addressController.text;


    for (var each in this.childs){
      if (each.name.isEmpty || each.age.isEmpty ||
          each.gender.isEmpty ) {
        showAlertDialog(context,  AppStrings.VALIDATION_FAILED, AppStrings.FORM_FILL_MESSAGE, false, (){});
        return;
      }
    }

    for (var each in this.pets){
      if (each.name.isEmpty || each.age.isEmpty ||
          each.type.isEmpty ) {
        showAlertDialog(context,  AppStrings.VALIDATION_FAILED, AppStrings.FORM_FILL_MESSAGE, false, (){});
        return;
      }
    }

    _sendParentRequest(context);

  }

  List<Map<String, dynamic>> getChildParamDict(List<ChildPetViewModel> list,bool isPet){
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
        dict['SleepStartTime'] = each.sleepSchedule;
        dict['FoodLikesAndDislikes'] = each.food;
        dict['LanguagesSpoken'] = each.language;
        dict['AdditionalComments'] = each.additional;
        dict['ReqSpecialNeeds'] = each.isSpecial;
        result.add(dict);
      }
      return result;
    }
  }

  void _sendParentRequest(BuildContext context) {
    check().then((internet) {
      if (internet != null && internet) {
        progressDialog.show();
        Map<String, dynamic> parameters = Map();
        parameters['id'] = data.id ;
        parameters['FirstName'] = data.firstName;
        parameters['LastName'] = data.lastName;
        parameters['Email'] = data.email;
        parameters['Password'] = "123456";
        parameters['Phone'] = data.phoneNumber;
        parameters['ChildCount'] = this.childs.length.toString();
        parameters['PostalAddress'] = data.address;
        parameters['PetsCount'] = this.pets.length.toString();
        parameters['Longitude'] = data.longitude;
        parameters['Latitude'] = data.latitude;
        parameters['ListChildren'] = getChildParamDict(this.childs,false);
        parameters['ListPets'] = getChildParamDict(this.pets,true);
        parameters['Status'] = "Active";
        parameters['isActive'] = true;
        HTTPManager().updateParentUser(parameters).then((onValue) {
          progressDialog.hide();
          final response = onValue;
          if (response['responseCode'] == "01") {
            var user = UserViewModel.api(response['data']);
            showAlertDialog(context, 'Success', response['responseMessage'], false, null);

            Global.currentUser = user;
//            Navigator.of(context).pushNamedAndRemoveUntil(
//                BottomTabsScreen.routeName, (route) => false);
          } else {
            showAlertDialog(context, 'Error', response['responseMessage'], false, null);
          }
        });
      }else {
        showAlertDialog(context, 'No Internet',
            'Make sure you are connected to internet.', true, () {
              Navigator.of(context).pop();
              _sendParentRequest(context);
            });
      }
    });
  }
}

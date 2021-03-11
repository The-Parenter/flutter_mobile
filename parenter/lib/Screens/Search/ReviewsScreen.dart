import 'package:flutter/material.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Models/User/RatingModel.dart';
import 'package:parenter/Widgets/ActivityIndicator.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';

class ReviewScreen extends StatefulWidget {
  static final String routeName = '/ReviewScreen';
  final String rateduserId;
  ReviewScreen(this.rateduserId);
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  RatingListModel ratingList = RatingListModel();
  bool isLoading = false;
  void getConversations() {
    HTTPManager()
        .getAllRatings(this.widget.rateduserId)
        .then((val) {
      this.ratingList = val;
      setState(() {
        this.isLoading = false;
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    this.isLoading = true;
    this.getConversations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.appBGColor,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child:  Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.keyboard_backspace,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            this.isLoading
                ?  ActivityIndicator()
                : Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children:
                        [
                          Text(
                          '${Global.bookingSP.getFullName()} - ${this.ratingList.avgRating}',
                          style:
                          TextStyle(fontSize: 20, color: AppColors.textColor),
                        ),
                          Icon(Icons.star,color: AppColors.appPinkColor,size: 30,)
                      ]
                      ),
//                      Row(
//                        children: [
//                          InkWell(
//                            child: Icon(
//                              Icons.search,
//                              size: 30,
//                            ),
//                            onTap: () {
//                              Navigator.of(context)
//                                  .pushNamed(SearchScreen.routeName);
//                            },
//                          ),
//                          SizedBox(
//                            width: 16,
//                          ),
//                          InkWell(
//                            child: Icon(
//                              Icons.open_in_new,
//                              size: 30,
//                            ),
//                            onTap: () {
//                              Navigator.of(context)
//                                  .pushNamed(NotificationScreen.routeName);
//                            },
//                          ),
//                        ],
//                        mainAxisAlignment: MainAxisAlignment.end,
//                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 0, right: 0),
                    child: ListView.builder(
                      itemCount: this.ratingList.ratings.length,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 2.0),
                          child: Container(
                            decoration: BoxDecoration(
                            ),
//                            elevation: 0.0,
//                            shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(5.0),
//                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:0.0,vertical: 8),
                              child: Row(
                                children: [
//                                  Image(
//                                    width: 70,
//                                    height: 70,
//                                    image: AssetImage(
//                                      'resources/images/avatar_placeholder.png',
//                                    ),
//                                  ),
                                  SizedBox(
                                    width: 12.0,
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(horizontal: 8),
                                          width:double.infinity,
                                          child: Text(
                                           "${this.ratingList.ratings[index].review}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppColors.textColor),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        SizedBox(
                                          height: 16.0,
                                        ),
                                        Divider(height: 1,color: Colors.grey,)
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                      Icon(Icons.star,size: 20,color: AppColors.appPinkColor,),
                                        Text('${this.ratingList.ratings[index].rating}')
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

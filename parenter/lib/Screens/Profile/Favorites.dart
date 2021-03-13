import 'package:flutter/material.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Models/Favourties/FavouriteModel.dart';
import 'package:parenter/Screens/Search/SearchDetail.dart';
import 'package:parenter/Widgets/ActivityIndicator.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';
class FavouritesScreen extends StatefulWidget {
  static String routeName = '/FavouritesScreen';

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}
class _FavouritesScreenState extends State<FavouritesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FavouritesListModel favouritesList = FavouritesListModel();
  bool isLoading = false;
  void getFavorites() {
    HTTPManager()
        .getAllFavourites(Global.userId)
        .then((val) {
      this.favouritesList = val;
      setState(() {
        this.isLoading = false;
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    this.isLoading = true;
    this.getFavorites();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.appBGColor,
      body: SafeArea(
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                      Icons.keyboard_backspace
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0, left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Favorites',
                    style:
                    TextStyle(fontSize: 24, color: AppColors.textColor),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),

            SingleChildScrollView(
              child: Container(
                height: (45.0 + (100 * 2)) + (45.0 + (100 * 2)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    this.isLoading
                        ? Expanded(child: ActivityIndicator())
                        :
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.0, right: 16.0),
                        child: ListView.builder(
                          itemCount: this.favouritesList.favourites.length,
                          itemBuilder: (BuildContext context, index) {
                            return InkWell(
                              onTap: (){
                                Navigator.of(context).pushNamed(SearchDetail.routeName);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                                child: Card(
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
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
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children:[
                                                  Text(
                                                  '${this.favouritesList.favourites[index].getName()}',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: AppColors.textColor),
                                                ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Icon(Icons.star,size: 20,color: AppColors.appPinkColor,),
                                                      Text(
                                                        '${this.favouritesList.favourites[index].avgRating}',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: AppColors.textColor),
                                                      ),

                                                    ],
                                                  )
                                          ]
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${this.favouritesList.favourites[index].petCareServiceType}',
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .colorSecondaryText,
                                                      fontSize: 12.0,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

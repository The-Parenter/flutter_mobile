import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:parenter/API/ResponseHandler.dart';
import 'package:parenter/Models/Booking/BookingModel.dart';
import 'package:parenter/Models/Chat/ConversationViewModel.dart';
import 'package:parenter/Models/Common/SeedDataModel.dart';
import 'package:parenter/Models/Favourties/FavouriteModel.dart';
import 'package:parenter/Models/Notifications/NotificationModel.dart';
import 'package:parenter/Models/Payment/BankInfoModel.dart';
import 'package:parenter/Models/Payment/CreditCardModel.dart';
import 'package:parenter/Models/Payment/PaymentModel.dart';
import 'package:parenter/Models/User/RatingModel.dart';
import 'package:parenter/Models/User/ServiceProviderRigester.dart';
import 'package:parenter/Models/User/UserViewModel.dart';
import 'package:parenter/common/Singelton.dart';

import '../API/Urls.dart';


class HTTPManager {
  /// CONTACTS CALLS

  ResponseHandler _handler = ResponseHandler();
  Map<String, String> setTokenHeader() {
    return {'Authorization': '${Global.token}'};

  }

  Future<SeedValueListMode> getSeedData() async {
    final url = ApplicationURLs.SEED_DATA_URL;
    final Response response = await _handler.get(url, true);
    SeedValueListMode list = SeedValueListMode.api(response.data['listSeedData']);
    return list;
  }

  Future getUserById(String id) async {
    final url = ApplicationURLs.GET_USER_BY_ID + id;
    final Response response = await _handler.get(url, true);
    return response.data;
  }

  Future<ServiceProviderRegisterListMode> getServiceProviderByType(String type) async {
    final url = ApplicationURLs.GET_SERVICE_PROVIDER_TYPE + type;
    final Response response = await _handler.get(url, true);
    ServiceProviderRegisterListMode list = ServiceProviderRegisterListMode.api(response.data['data']);
    return list;
  }

  Future<ServiceProviderRegisterListMode> getServiceProviderByFilter(Map<String, dynamic> parameters) async {
    var url = ApplicationURLs.GET_SERVICE_PROVIDER_FILTER;
    var head = Map<String, String>();
    head['content-type'] = 'application/json';
    head['Authorization'] = '${Global.token}';
    this.setTokenHeader();
    final response = await http.post(url,body: utf8.encode(json.encode(parameters)), headers: head);
    var responseJson = json.decode( utf8.decode(response.bodyBytes));
    var data = responseJson['data'];
    if (data != null) {
      ServiceProviderRegisterListMode list = ServiceProviderRegisterListMode
          .api(responseJson['data']);
      return list;
    }else{
      ServiceProviderRegisterListMode();
    }
    //return json.decode(response.body);
  }
  Future<ConversationListViewModel> getConversations(String userId) async {
    final url = ApplicationURLs.GET_CONVERSATIONS_URL + Global.userId;
    final Response response = await _handler.get(url, true);
    ConversationListViewModel list = ConversationListViewModel.api(response.data['data']);
    return list;
  }
  Future<FavouritesListModel> getAllFavourites(String userId) async {
    final url = ApplicationURLs.GET_FAVOURITE_URL + Global.userId;
    final Response response = await _handler.get(url, true);
    FavouritesListModel list = FavouritesListModel.api(response.data['data']);
    return list;
  }

  Future<BookingListModel> getBookings(String userId) async {
    final url = ApplicationURLs.GET_USER_BOOKINGS + Global.userId;
    final Response response = await _handler.get(url, true);
    BookingListModel list = BookingListModel.api(response.data['data']);
    return list;
  }

  Future<ConversationListViewModel> getAllMessages(String userId) async {
    final url = ApplicationURLs.GET_MESSAGES_URL + Global.userId + "&receiverId=" + userId;
    final Response response = await _handler.get(url, true);
    ConversationListViewModel list = ConversationListViewModel.api(response.data['data']);
    return list;
  }
  Future<CreditCardListModel> getAllCards() async {
    final url = ApplicationURLs.GET_CARD_INFO_URL + Global.userId;
    final Response response = await _handler.get(url, true);
    CreditCardListModel list = CreditCardListModel.api(response.data['data']);
    return list;
  }

  Future<BankInfoListModel> getAllBanks() async {
    final url = ApplicationURLs.GET_BANK_INFO_URL + Global.userId;
    final Response response = await _handler.get(url, true);
    BankInfoListModel list = BankInfoListModel.api(response.data['data']);
    return list;
  }

  Future setNotificationsSettings(String uri) async {
    final url =  uri ;
    final Response response = await _handler.get(url, true);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return false;
    }
  }

  Future removeCardInfo(String digits) async {
    final url = ApplicationURLs.REMOVE_CARD_INFO_URL + digits;
    var head = Map<String, String>();
    head['content-type'] = 'application/json';
    head['Authorization'] = '${Global.token}';
    this.setTokenHeader();
    final response = await http.post(url, headers: head);
    return json.decode(response.body);
  }

  Future addReview(Map<String, dynamic> parameters) async {
    final url = ApplicationURLs.ADD_RATING_URL;
    var head = Map<String, String>();
    head['content-type'] = 'application/json';
    head['Authorization'] = '${Global.token}';
    final response = await http.post(url,
        body: utf8.encode(json.encode(parameters)), headers: head);
    return json.decode(response.body);
  }

  Future<RatingListModel> getAllRatings(String userId) async {
    final url = ApplicationURLs.GET_ALL_RATINGS_URL + userId;
    final Response response = await _handler.get(url, true);
    RatingListModel list = RatingListModel.api(response.data['data']);
    return list;
  }
  Future<NotificationListModel> getAllNotifications(String userId) async {
    final url = ApplicationURLs.GET_USER_NOTIFICATION + userId;
    final Response response = await _handler.get(url, true);
    NotificationListModel list = NotificationListModel.api(response.data['data']);
    return list;
  }
  Future<PaymentListModel> getAllPayments(String userId) async {
    final url = ApplicationURLs.GET_PAYMENTS_URL + userId;
    final Response response = await _handler.get(url, true);
    PaymentListModel list = PaymentListModel.api(response.data['data']);
    return list;
  }
  Future forgotPassword(String email) async {
    final url = ApplicationURLs.FORGOT_PASSWORD_URL +
        '?emailAddress=' +
       email;
    final Response response = await _handler.get(url, true);

    if (response.statusCode == 200) {
     return response.data;
    } else {
      return false;
    }
  }
//
//  /// AUTHENTICATION CALLS
//
  Future authenticateUser(Map<String, String> parameters) async {
    final url = ApplicationURLs.LOGIN_URL;
    var head = Map<String, String>();
    head['content-type'] = 'application/json';
    final response = await http.post(url,
        body: utf8.encode(json.encode(parameters)), headers: head);
    return json.decode(response.body);
  }
  Future socialAuthenticateUser(String email) async {
    final url = ApplicationURLs.SOCIAL_LOGIN_URL + email;
    final Response response = await _handler.get(url, true);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return false;
    }
  }
  Future addPaymentInfo(Map<String, dynamic> parameters,String url) async {
    var head = Map<String, String>();
    head['content-type'] = 'application/json';
    head['Authorization'] = '${Global.token}';
    this.setTokenHeader();
    final response = await http.post(url,
        body: utf8.encode(json.encode(parameters)), headers: head);
    return json.decode(response.body);
  }

  Future addMessage(Map<String, dynamic> parameters,) async {
    final url = ApplicationURLs.SAVE_MESSAGES_URL;

    var head = Map<String, String>();
    head['content-type'] = 'application/json';
    head['Authorization'] = '${Global.token}';
    this.setTokenHeader();
    final response = await http.post(url,
        body: utf8.encode(json.encode(parameters)), headers: head);
    return json.decode(response.body);
  }


  Future changeBookingStatus(String bID,String status,String userId) async {
    final url = ApplicationURLs.CHANGE_BOOKING_STATUS + bID + '&status=' + status + '&statusUpdatedBy=' + userId;
    var head = Map<String, String>();
    head['content-type'] = 'application/json';
    head['Authorization'] = '${Global.token}';
    this.setTokenHeader();
    final response = await http.post(url, headers: head);
    return json.decode(response.body);
  }

  Future changeUSerPassword(Map<String, dynamic> parameters) async {
    final url = ApplicationURLs.CHANGE_PASSWORD_URL;
    var head = Map<String, String>();
    head['content-type'] = 'application/json';
    head['Authorization'] = '${Global.token}';
    this.setTokenHeader();
    final response = await http.post(url,
        body: utf8.encode(json.encode(parameters)), headers: head);
    return json.decode(response.body);
  }

  Future registerParentUser(Map<String, dynamic> parameters) async {
    final url = ApplicationURLs.CREATE_PARENT_URL;
    var head = Map<String, String>();
    head['content-type'] = 'application/json';
    final response = await http.post(url,
        body: utf8.encode(json.encode(parameters)), headers: head);
    return json.decode(response.body);
  }

  Future updateParentUser(Map<String, dynamic> parameters) async {
    final url = ApplicationURLs.UPDATE_PARENT_URL;
    var head = Map<String, String>();
    head['content-type'] = 'application/json';
    head['Authorization'] = '${Global.token}';
    final response = await http.post(url,
        body: utf8.encode(json.encode(parameters)), headers: head);
    return json.decode(response.body);
  }


  Future registerServiceProvider(Map<String, dynamic> parameters) async {
    final url = ApplicationURLs.CREATE_SP_URL;
    var head = Map<String, String>();
    head['content-type'] = 'application/json';
    final response = await http.post(url,
        body: utf8.encode(json.encode(parameters)), headers: head);
    return json.decode(response.body);
  }

  Future updateSPUser(Map<String, dynamic> parameters) async {
    final url = ApplicationURLs.UPDATE_SP_URL;
    var head = Map<String, String>();
    head['content-type'] = 'application/json';
    head['Authorization'] = '${Global.token}';
    final response = await http.post(url,
        body: utf8.encode(json.encode(parameters)), headers: head);
    return json.decode(response.body);
  }

  Future addBooking(Map<String, dynamic> parameters) async {
    final url = ApplicationURLs.ADD_BOOKING_URL;
    var head = Map<String, String>();
    head['content-type'] = 'application/json';
    head['Authorization'] = '${Global.token}';
    final response = await http.post(url,
        body: utf8.encode(json.encode(parameters)), headers: head);
    return json.decode(response.body);
  }

  Future addFavourite(Map<String, dynamic> parameters,bool isRemove) async {
    final url = isRemove ? ApplicationURLs.REMOVE_FAVOURITE_URL: ApplicationURLs.ADD_FAVOURITE_URL;
    var head = Map<String, String>();
    head['content-type'] = 'application/json';
    head['Authorization'] = '${Global.token}';
    final response = await http.post(url,
        body: utf8.encode(json.encode(parameters)), headers: head);
    return json.decode(response.body);
  }

  Future<UserViewModel> getUser() async {
    final url = ApplicationURLs.GET_USER_URL + Global.userId;
    Response response = await _handler.get(url, true);
    print(response.data);
    UserViewModel userViewModel = UserViewModel.api(response.data['data']);
    return userViewModel;
  }




}

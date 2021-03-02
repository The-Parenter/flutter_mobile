import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:parenter/common/Singelton.dart';

import 'AppExceptions.dart';

String MESSAGE_KEY = 'message';

class ResponseHandler {
  Map<String, String> setTokenHeader() {
   // headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},

    return {'Authorization': '${Global.token}'};

  }

  Future<dynamic> get(String url, bool isHeaderRequired) async {
    var header = isHeaderRequired ? this.setTokenHeader() : '';
//    dio.options.headers = header;

    var responseJson;
    try {
      //final response = await dio.get(url);
      final response = await http.get(url, headers: header);
      var res = Response();
      switch (response.statusCode) {
        case 200:
          var responseJson = json.decode( utf8.decode(response.bodyBytes));
          res.data = responseJson;
          res.status = ResponseStatus.Success;
          res.statusCode = 200;
          //   res.message = responseJson[MESSAGE_KEY] ?? 'Success';
          print(responseJson);
          return res;
        case 400:
          // throw BadRequestException(response.body.toString());
          res.status = ResponseStatus.Failure;
          res.statusCode = 400;
          res.data = json.decode(response.body.toString());
          return res;
        case 401:
//          DartNotificationCenter.post(
//            channel: Constants.kTokenExpireNotification,
//          );
          res.status = ResponseStatus.Failure;
          res.statusCode = 401;
          res.data = res.data = json.decode(response.body.toString());
          return res;
        // throw TokenExpireException(Constants.kBearerTokenExpires);
        case 403:
          res.status = ResponseStatus.Failure;
          res.statusCode = 403;
          res.data = res.data = json.decode(response.body.toString());
          return res;
          // throw UnauthorisedException(response.body.toString());
          break;
        case 406:
//          DartNotificationCenter.post(
//            channel: Constants.kSubscriptionExpireNotification,
//          );
          res.status = ResponseStatus.Failure;
          res.statusCode = 406;
          return res;
          // throw UnauthorisedException(response.body.toString());
          break;
        case 500:
        default:
          res.status = ResponseStatus.timeout;
          res.statusCode = 500;
          res.data = res.data = json.decode(response.body.toString());
          return res;
        //  throw FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
      }

//      if (url.contains(Constants.lookupUtilitiesKey)) {
//        print(response.body);
//      }

    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e){

    }
    return responseJson;
  }

  dynamic _returnResponse(Response response) {}
}

class Response {
  var data = Map<String, dynamic>();
  var message = Map<String, String>();
  var status = ResponseStatus.Failure;
  var statusCode = 0;
}

enum ResponseStatus { Success, Failure, timeout }

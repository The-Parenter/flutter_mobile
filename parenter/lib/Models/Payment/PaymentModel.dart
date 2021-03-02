
import 'package:parenter/Helper/HelperFunctions.dart';

class PaymentModel{

  var id = "";
  var parentName = "";
  var serviceProviderName = "";
  var businessName = "";
  var bookingDate = "";
  var serviceType = "";
  var paymentDate = "";
  var hours = 0;
  var commission = "";
  var amount = "";
  var timingsFrom = "";
  var timingsTo = "";
  var extraServices = "";
  DateTime date = DateTime.now() ;

  PaymentModel(){
      id = "";
      parentName = "";
      serviceProviderName = "";
      businessName = "";
      bookingDate = "";
      serviceType = "";
      paymentDate = "";
      hours = 0;
      commission = "";
      amount = "";
      timingsFrom = "";
      timingsTo = "";
      extraServices = "";
      date = DateTime.now();
  }


  PaymentModel.api(Map<String, dynamic> json) {
       this.parentName = json['parent'] ?? '';
       this.serviceProviderName = json['serviceProvider'] ?? '';
       this.id = json['id'] ?? '';
       this.businessName = json['businessName'] ?? '';
       this.bookingDate = json['bookingDate'] ?? '';
       this.serviceType = json['serviceType'] ?? '';
       this.paymentDate = json['paymentDate'] ?? '';
       this.hours = json['hour'] ?? 0;
       this.commission = json['commission'] ?? '';
       this.amount = json['amount'] ?? '';
       this.timingsFrom = json['timingsFrom'] ?? '';
       this.timingsTo = json['timingsTo'] ?? '';
       this.extraServices = json['extraServices'] ?? '';

       date = DateTime.tryParse(this.bookingDate);
      this.bookingDate = formatDateForDateRangePicker(date);

}

String getExtraText(){
    var result = "";

    if (serviceType != null && serviceType != ""){
      result = serviceType;
    }else{
      if (extraServices != null){

      }else{
        result = "All Mentioned Services";
      }
    }
return result;


}

}

class PaymentListModel{
  List<PaymentModel> payments = [];
  PaymentListModel(){
    payments = [];
  }
  PaymentListModel.api(var json){
    for (var each in json){
      this.payments.add(PaymentModel.api(each));
    }
  }
}
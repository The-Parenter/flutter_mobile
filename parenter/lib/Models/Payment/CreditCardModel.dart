

class CreditCardModel{

  var id = "";
  var parentId = "";
  var customerToken = "";
  var customerEmail = "";
  var brand = "";
  var last4Digits = "";
  var isActive = false;
  var createdDate = "";

CreditCardModel(){
  this.id = "";
  this.parentId = "";
  this.customerToken = "";
  this.customerEmail = "";
  this.brand = "";
  this.last4Digits = "";
  this.createdDate = "";
  this.isActive = false;
}


CreditCardModel.api(Map<String, dynamic> json) {
this.id = json['id'] ?? '';
this.parentId = json['parentId'] ?? '';
this.customerToken = json['customerToken'] ?? '';
this.customerEmail = json['customerEmail'] ?? '';
this.brand = json['brand'] ?? '';
this.last4Digits = json['last4Digits'] ?? '';
this.createdDate = json['createdDate'] ?? '';
this.isActive = json['isActive'] ?? false;
}
}

class CreditCardListModel{
  List<CreditCardModel> cards = [];
  CreditCardListModel(){
    cards = [];
  }
  CreditCardListModel.api(var json){
    for (var each in json){
      this.cards.add(CreditCardModel.api(each));
    }
  }
}
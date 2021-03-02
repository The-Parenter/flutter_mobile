

class BankInfoModel{

  var id = "";
  var bankAccountId = "";
  var serviceProviderId = "";
  var accountHolderName = "";
  var accountNumber = "";
  var branchNumber = "";
  var institutionNumber = "";
  var isActive = false;
  var createdDate = "";

  BankInfoModel(){
    this.id = "";
    this.bankAccountId = "";
    this.serviceProviderId = "";
    this.accountHolderName = "";
    this.accountNumber = "";
    this.branchNumber = "";
    this.institutionNumber = "";
    this.createdDate = "";
    this.isActive = false;
  }


  BankInfoModel.api(Map<String, dynamic> json) {
    this.id = json['id'] ?? '';
    this.bankAccountId = json['bankAccountId'] ?? '';
    this.serviceProviderId = json['serviceProviderId'] ?? '';
    this.accountHolderName = json['accountHolderName'] ?? '';
    this.accountNumber = json['accountNumber'] ?? '';
    this.branchNumber = json['branchNumber'] ?? '';
    this.institutionNumber = json['institutionNumber'] ?? '';
    this.createdDate = json['createdDate'] ?? '';
    this.isActive = json['isActive'] ?? false;
  }
}

class BankInfoListModel{
  List<BankInfoModel> banks = [];
  BankInfoListModel(){
    banks = [];
  }
  BankInfoListModel.api(var json){
    for (var each in json){
      this.banks.add(BankInfoModel.api(each));
    }
  }
}
class ExpenseRequestMessage {
  String amount;
  String incurredDate;
  String paidOn;
  String description;
  String status;
  String isRecurringExpense;
  Map<String, String> currency;
  Map<String, String> category;
  Map<String, String> contact;
  List<Map<String, String>> attachments;
}

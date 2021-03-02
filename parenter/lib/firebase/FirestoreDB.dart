import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parenter/firebase/TrackRouteModel.dart';


class FirestoreDB {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

//  static final customerCollection = 'Customers';
  static final routesCollection = 'Routes';
//
////  // Customer Functions
//  static Future<int> getAllCustomers() async {
//    try {
//      var customers = await _db
//          .collection(customerCollection)
//          .get();
//      if (customers != null) {
//        Global.customers.customers = [];
//        for (var qSnap in customers.docs) {
//       //   print(qSnap.data());
//        var cus = CustomerModel.fromJson(qSnap.data());
//        Global.customers.customers.add(cus);
//        }
//        return 1;
//      }
//    } catch (e) {
//  return -1;
//  }
//    return -1;
//  }
//

  static Future<int> addRoute(TrackRouteModel route) async{
    try {
       await _db
          .collection(routesCollection).doc(route.serviceProviderId).set(route.toJson());
        return 1;
    } catch (e) {
      return -1;
    }
  }


  static Future<TrackRouteModel> getRoute(String SPId) async{
    try {
      var r = await _db
          .collection(routesCollection).doc(SPId).get();
      if (r != null) {
          var tik = TrackRouteModel.fromJson(r.data());
        return tik;
      }
      } catch (e) {
      return TrackRouteModel();
    }
  }

//
//  static Future<int> getAllTickets() async {
//    try {
//      var tickets = await _db
//          .collection(ticketCollection)
//          .get();
//      if (tickets != null) {
//        Global.tickets.tickets = [];
//        for (var qSnap in tickets.docs) {
//          var tik = TicketModel.fromJson(qSnap.data());
//          Global.tickets.tickets.add(tik);
//        }
//        return 1;
//      }
//    } catch (e) {
//      return -1;
//    }
//    return -1;
//  }
//
//  static Future<int> getAllTicketsWithFilter(String status,String customerId) async {
//    try {
//      dynamic tickets;
//      if (customerId.isEmpty){
//        tickets = await _db
//            .collection(ticketCollection).where("status", isEqualTo: status)
//            .get();
//      }else if (status.isEmpty){
//        tickets = await _db
//            .collection(ticketCollection).where("customerId", isEqualTo: customerId)
//            .get();
//      }else {
//        tickets = await _db
//            .collection(ticketCollection).where("status", isEqualTo: status)
//            .where("customerId", isEqualTo: customerId)
//            .get();
//      }
//      if (tickets != null) {
//        Global.tickets.tickets = [];
//        for (var qSnap in tickets.docs) {
//          var tik = TicketModel.fromJson(qSnap.data());
//          Global.tickets.tickets.add(tik);
//        }
//        return 1;
//      }
//    } catch (e) {
//      return -1;
//    }
//    return -1;
//  }

//  static Future<CustomerModel> getCustomerWithId(String id) async {
//    try {
//        var cust = await _db
//            .collection(customerCollection).doc(id).get();
//      if (cust != null) {
//        var customer = CustomerModel.fromJson(cust.data());
//        return customer;
//      }
//    } catch (e) {
//      return CustomerModel();
//    }
//    return CustomerModel();
//  }
//
//  static Future<int> updateTicketStatus(TicketModel ticket) async {
//    try {
//   await _db
//          .collection(ticketCollection).doc(ticket.id).update(ticket.toJson());
//      return 1;
//    } catch (e) {
//      return -1;
//    }
//  }
//  static Future<int> addNewTicket(TicketModel ticket) async{
//    try {
//      final tID = _db
//          .collection(ticketCollection)
//          .doc()
//          .id;
//      var currentTicket = ticket;
//      currentTicket.id = tID;
//      await _db
//          .collection(ticketCollection)
//          .doc(tID)
//          .set(currentTicket.toJson());
//      return 1;
//    } catch (e) {
//      return -1;
//    }
//  }

}

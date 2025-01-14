import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Read {
  Future<List<Map<String, dynamic>>> getLicense() async {
    Completer<List<Map<String, dynamic>>> completer = Completer();
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref('users');
    try {
      DatabaseEvent dataSnapshot = await databaseReference.once();
      Map<dynamic, dynamic>? userData =
          dataSnapshot.snapshot.value as Map<dynamic, dynamic>?;
      List<Map<String, dynamic>> licenseList = userData!.entries.map((e) {
        return {
          'userDataKey': e.key as String,
          'studentId': e.value['student_id'] as int,
          'password': e.value['password'] as String,
          'name': e.value['name'] as String,
          'dept': e.value['department'] as String,
        };
      }).toList();
      completer.complete(licenseList);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  Future<List<Map<String, dynamic>>> fetchBusReserve(
      {required String busCode}) async {
    Completer<List<Map<String, dynamic>>> completer = Completer();

    DatabaseReference ref =
        FirebaseDatabase.instance.ref('busReservation/$busCode');
    try {
      DatabaseEvent dataSnapshot = await ref.once();
      Map<dynamic, dynamic>? busSheetData =
          dataSnapshot.snapshot.value as Map<dynamic, dynamic>?;
      if (busSheetData != null) {
        List<Map<String, dynamic>> busSheetDatas =
            busSheetData.entries.map((e) {
          return {
            'reservatKey': e.key,
            'date': e.value['date'] as String,
            'sheetCode': e.value['sheetCode'] as String,
            'studentId': e.value['student_id'] as String,
          };
        }).toList();
        debugPrint('$busSheetDatas');
        completer.complete(busSheetDatas);
      } else {
        completer.complete([]);
      }
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  Future<List<Map<String, dynamic>>> fetchBusReserveAll(
      {required String student_id}) async {
    Completer<List<Map<String, dynamic>>> completer = Completer();

    DatabaseReference ref = FirebaseDatabase.instance.ref('busReservation');
    try {
      DatabaseEvent dataSnapshot = await ref.once();
      print(dataSnapshot.snapshot.value);
      Map<dynamic, dynamic>? busSheetData =
          dataSnapshot.snapshot.value as Map<dynamic, dynamic>?;
      if (busSheetData != null) {
        List<Map<String, dynamic>> busSheetDatas =
            busSheetData.entries.map((e) {
          return {
            'reservatKey': e.key,
            'date': e.value['date'] as String,
            'sheetCode': e.value['sheetCode'] as String,
          };
        }).toList();
        debugPrint('$busSheetDatas');
      } else {
        completer.complete([]);
      }
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  Future<List<Map<String, dynamic>>> fetchFirstSectionData(
      String currentBusKey) async {
    Completer<List<Map<String, dynamic>>> completer = Completer();
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref('shuttle_core/$currentBusKey');

    try {
      DatabaseEvent dataSnapshot = await databaseReference.once();
      Map<dynamic, dynamic>? userData =
          dataSnapshot.snapshot.value as Map<dynamic, dynamic>?;

      if (userData != null) {
        List<Map<String, dynamic>> data = [
          {
            'sheet_count': userData['bus_sheet']['sheet_count'],
            'laststop_point': userData['laststop_point'],
          }
        ];
        completer.complete(data);
      } else {
        completer.complete([
          {'userData': 'null'}
        ]);
      }
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  Future<List<Map<String, dynamic>>> fetchBusDataKey() async {
    Completer<List<Map<String, dynamic>>> completer = Completer();
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref('shuttle_core');
    try {
      DatabaseEvent dataSnapshot = await databaseReference.once();
      Map<dynamic, dynamic>? userData =
          dataSnapshot.snapshot.value as Map<dynamic, dynamic>?;
      debugPrint(userData.toString());
      if (userData != null) {
        List<Map<String, dynamic>> licenseList = userData.entries.map((e) {
          return {
            'busDataKey': e.key as String,
            'busCode': e.value['bus_license'] as String,
            'depart_time': e.value['depart_time'] as String,
            'lastStopPoint': e.value['laststop_point'] as String,
          };
        }).toList();
        completer.complete(licenseList);
      } else {
        completer.complete([]);
      }
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  Future<Map<dynamic, dynamic>> fetchData(String studentId) async {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref('busReservation');
    DatabaseEvent event = await databaseReference.once();
    Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
    // 특정 키로 데이터를 필터링합니다 (예: key1, key2만 가져오기)
    Map<dynamic, dynamic> filteredData = {};
    data.forEach((outerKey, innerValue) {
      debugPrint(outerKey);
      innerValue.forEach((innerKey, value) {
        if (value['student_id'] == studentId) {
          debugPrint('$outerKey,$innerKey');
          value['outerKey'] = outerKey;
          filteredData[innerKey] = value;
          debugPrint(filteredData.toString());
        }
      });
    });
    return filteredData;
  }

  Future<List<Map<String, dynamic>>> fetchBusData() async {
    Completer<List<Map<String, dynamic>>> completer = Completer();
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref('shuttle_core');
    try {
      DatabaseEvent dataSnapshot = await databaseReference.once();
      Map<dynamic, dynamic>? userData =
          dataSnapshot.snapshot.value as Map<dynamic, dynamic>?;

      if (userData != null) {
        debugPrint('checked');
        List<Map<String, dynamic>> licenseList = userData.entries.map((e) {
          return {
            'busDataKey': e.key as String,
            'busCode': e.value['bus_license'] as String,
            'bus_lat': e.value['bus_location']['bus_lat'].toString(),
            'bus_long': e.value['bus_location']['bus_long'].toString(),
            'lastStopPoint': e.value['laststop_point'] as String,
          };
        }).toList();
        completer.complete(licenseList);
      } else {
        completer.complete([]);
      }
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }
}

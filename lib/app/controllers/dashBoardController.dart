import 'dart:ui';

import 'package:d_chart/commons/data_model.dart';
import 'package:d_chart/d_chart.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sqflite/sqflite.dart';


class DashboardController extends GetxController {
  Map<String, double> dataMap = {
    "Total Sales = 5": 5,
    "Total Tax = 1.2": 1.2,
  };
  RxString dropDownValue = RxString('April 2024');
  RxDouble incomeSales = RxDouble(3300);
  RxDouble expense = RxDouble(330);
  final colorList = <Color>[
    const Color(0xfffdcb6e),
    const Color(0xff6c5ce7),
  ];
  List<OrdinalData> ordinalList = [];
  

  setDisplayingState(double measureVal) {
    ordinalList.clear();
  ordinalList = [
      OrdinalData(domain: 'Mon', measure: 3),
      OrdinalData(domain: 'Tue', measure: 5),
      OrdinalData(domain: 'Wed', measure: 9),
      OrdinalData(domain: 'Thu', measure: 6.5),
    ];
      groupList: [
            OrdinalGroup(
              id: '1',
              data: ordinalList,
            ),
           
          ];

    incomeSales.value = measureVal;
    expense.value = measureVal / 2;
  }

}

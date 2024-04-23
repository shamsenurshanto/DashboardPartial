import 'package:d_chart/commons/axis.dart';
import 'package:d_chart/commons/config_render.dart';
import 'package:d_chart/commons/data_model.dart';
import 'package:d_chart/commons/decorator.dart';
import 'package:d_chart/commons/enums.dart';
import 'package:d_chart/commons/layout_margin.dart';
import 'package:d_chart/commons/style.dart';
import 'package:d_chart/commons/viewport.dart';
import 'package:d_chart/ordinal/bar.dart';
import 'package:d_chart/time/bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nirupon_pos/app/controllers/dashBoardController.dart';
import 'package:nirupon_pos/app/shared/widgets/appbar.dart';

class DashboardView extends GetView<DrawerController> {

  DashboardView({super.key});

  final DashboardController dashboardController = new DashboardController();

  @override
  Widget build(BuildContext context) {
     List<OrdinalData> ordinalList = [
      OrdinalData(domain: 'Mon', measure: 3),
      OrdinalData(domain: 'Tue', measure: 3.5),
      OrdinalData(domain: 'Wed', measure: 9),
      OrdinalData(domain: 'Thu', measure: 6.5),
       OrdinalData(domain: 'Sat', measure: 3.5),
       OrdinalData(domain: 'Sun', measure: 9),
       OrdinalData(domain: 'Fri', measure: 6.5),
    ];
    return Scaffold(
      appBar: CustomAppbar(label: "Dashboard"),
      body: SingleChildScrollView(
        child:Obx(() => Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(left: 10,top: 20,bottom: 5),
                          child:  Container(
                            height: 40,
                            // width: 80,
                            child: DropdownButton<String>(
                                hint: Text(
                                  dashboardController.dropDownValue.value,
                                  style: GoogleFonts.ubuntu(
                                      fontSize: 25, fontWeight: FontWeight.w800, color: Colors.black.withOpacity(0.743)),
                                ),
                                isExpanded: false,
                                items: <String>['Last Month', 'Yesterday', 'Today', 'Last Year', 'Last Week'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: GoogleFonts.roboto(
                                          fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black.withOpacity(0.743)),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val) async {
                                  dashboardController.dropDownValue.value = val!;
                                }),
                          ),

                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      Padding(
                          padding: EdgeInsets.only(left: 20,top: 0,bottom: 80),
                        child:   Text("৳54330",  style: GoogleFonts.laila(
                            fontSize: 35, fontWeight: FontWeight.w800, color: Colors.black.withOpacity(0.743)),),

                      )
                      ],
                    )
                  ],
                ),
                Container(
                  width: 320,
                  color: Colors.white.withOpacity(0.6345),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: DChartBarO(
                      allowSliding: true,
                      animate: true,
                      animationDuration: const Duration(milliseconds: 500),
                      barLabelValue: (group, ordinalData, index) {
                        String domain = ordinalData.domain;
                        String measure = ordinalData.measure.round().toString();
                        return measure;
                      },
                      configRenderBar: ConfigRenderBar(
                        barGroupInnerPaddingPx: 1,
                        barGroupingType: BarGroupingType.groupedStacked,
                        fillPattern: FillPattern.solid,
                        maxBarWidthPx: 13,
                        radius: 10,
                        stackedBarPaddingPx: 1,
                        strokeWidthPx: 0,

                      ),
                      fillColor: (group, ordinalData, index) {
                        return  Colors.black.withOpacity(0.73);
                      },
                      flipVertical: false,
                      insideBarLabelStyle: (group, ordinalData, index) {
                        return const LabelStyle(
                          color: Colors.black,
                          fontSize: 16,
                        );
                      },
                      layoutMargin: LayoutMargin(30, 20, 20, 20),
                      outsideBarLabelStyle: (group, ordinalData, index) {
                        return const LabelStyle(
                          color: Colors.black,
                          fontSize: 16,
                        );
                      },
                      vertical: true,
                      fillPattern: (group, ordinalData, index) {
                        return FillPattern.solid;
                        // if (ordinalData.domain == 'Tue' && group.id == '1') {
                        //
                        // }

                      },
                      domainAxis: const DomainAxis(
                        // ordinalViewport: OrdinalViewport('Tue', 2),
                        gapAxisToLabel: 1,
                        labelAnchor: LabelAnchor.centered,
                        thickLength: 2,
                        labelRotation: 0,
                        labelStyle: LabelStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        lineStyle: LineStyle(
                          color: Colors.black,
                          thickness: 2,
                          dashPattern: [],
                        ),
                        minimumPaddingBetweenLabels: 0,
                        showLine: true,
                      ),
                      measureAxis: MeasureAxis(
                        numericViewport: const NumericViewport(0, 12),
                        desiredTickCount: 5,
                        showLine: true,
                        gapAxisToLabel: 2,
                        thickLength: 2,
                        labelAnchor: LabelAnchor.centered,
                        labelFormat: (measure) {
                          return '${measure?.toStringAsFixed(0)} K';
                        },
                        labelStyle: const LabelStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        lineStyle: const LineStyle(
                          color: Colors.black,
                          thickness: 1,
                          dashPattern: [],
                        ),
                      ),
                      groupList: [
                        OrdinalGroup(
                          id: '1',
                          data: ordinalList,
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            )
        ))
      )
  
       );
  }
}
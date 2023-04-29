// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class Inference extends StatefulWidget {
//   final String deviceId;

//   const Inference({
//     super.key,
//     required this.deviceId,
//   });

//   @override
//   State<Inference> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<Inference> {
//   late TooltipBehavior _tooltipBehavior;
//   late String _startDate;
//   late String _endDate;
//   @override
//   void initState() {
//     _tooltipBehavior = TooltipBehavior(
//       enable: true,
//       color: Colors.white,
//       // textStyle: TextStyle(color: Colors.white),
//       builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
//           int seriesIndex) {
//         final apiData item = chartData[pointIndex];
//         return Container(
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: Color.fromARGB(255, 245, 214, 250),
//             borderRadius: BorderRadius.circular(5),
//             boxShadow: [BoxShadow(color: Colors.purple, blurRadius: 3)],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text("TimeStamp: ${item.TimeStamp}"),
//               Text("Mean: ${item.Mean}"),
//               Text("Class: ${item.Class}"),
//             ],
//           ),
//         );
//       },
//     );

//     super.initState();
//   }

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   // _tooltip = TooltipBehavior(enable: true);
//   //   // _startDate = "2022-02-14";
//   //   // // _endDate = "2023-03-28";
//   //   // getapiData(widget.deviceId, _startDate, _endDate);
//   // }

//   void updateData() async {
//     final List<dynamic> jsonString =
//         await getAPIData(widget.deviceId, _startDate, _endDate);

//     chartData.clear();
//     for (dynamic i in jsonString) {
//       chartData.add(apiData.fromJson(i));
//     }

//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'TimeSeries Graph For Inferenced Data',
//           style: TextStyle(
//             fontSize: 20.0,
//             letterSpacing: 1.0,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.green,
//         elevation: 0.0,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Container(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         onChanged: (value) {
//                           _startDate = value;
//                         },
//                         decoration: InputDecoration(
//                           labelText: 'Start Date (YYYY-MM-DD)',
//                           border: OutlineInputBorder(),
//                           contentPadding: EdgeInsets.symmetric(
//                               vertical: 12, horizontal: 16),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 16.0),
//                     Expanded(
//                       child: TextField(
//                         onChanged: (value) {
//                           _endDate = value;
//                         },
//                         decoration: InputDecoration(
//                           labelText: 'End Date (YYYY-MM-DD)',
//                           border: OutlineInputBorder(),
//                           contentPadding: EdgeInsets.symmetric(
//                               vertical: 12, horizontal: 16),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 16.0),
//                     ElevatedButton(
//                       onPressed: () {
//                         // fetch new data
//                         updateData();
//                       },
//                       child: Text(
//                         'Get Data',
//                         style: TextStyle(
//                           fontSize: 20,
//                         ),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         primary: Colors.green, // Set the button color to green
//                         minimumSize:
//                             Size(80, 0), // Set a minimum width for the button
//                         padding:
//                             EdgeInsets.symmetric(vertical: 20, horizontal: 24),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 32.0),
//                 Container(
//                   height: 400,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16.0),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.shade300,
//                         blurRadius: 5.0,
//                         spreadRadius: 1.0,
//                         offset: Offset(0.0, 0.0),
//                       ),
//                     ],
//                   ),
//                   child: SfCartesianChart(
//                     legend: Legend(
//                       isVisible: true,
//                       // name:legend,
//                       position: LegendPosition.top,
//                       offset: const Offset(550, -150),
//                       // title: LegendTitle(
//                       //     text: 'Insect',
//                       //     textStyle: TextStyle(
//                       //         color: Colors.black,
//                       //         fontSize: 15,
//                       //         fontStyle: FontStyle.italic,
//                       //         fontWeight: FontWeight.w900)),
//                       // toggleSeriesVisibility: true,
//                       // Border color and border width of legend
//                       overflowMode: LegendItemOverflowMode.wrap,
//                       // borderColor: Colors.black,
//                       // borderWidth: 2
//                     ),
//                     plotAreaBackgroundColor: Colors.white,
//                     primaryXAxis: CategoryAxis(
//                       title: AxisTitle(
//                         text: 'Time',
//                         textStyle: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       labelRotation: 45,
//                     ),
//                     primaryYAxis: NumericAxis(
//                       title: AxisTitle(
//                         text: 'Mean',
//                         textStyle: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       axisLine: AxisLine(width: 0),
//                       majorGridLines: MajorGridLines(width: 0.5),
//                     ),
//                     tooltipBehavior: _tooltipBehavior,
//                     title: ChartTitle(
//                       text: 'Graph Of Mean',
//                       textStyle: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     series: <ChartSeries<apiData, String>>[
//                       LineSeries<apiData, String>(
//                         name: 'Apis Mellifera',
//                         markerSettings: const MarkerSettings(
//                           height: 3.0,
//                           width: 3.0,
//                           borderColor: Colors.green,
//                           isVisible: true,
//                         ),
//                         dataSource: chartData,
//                         xValueMapper: (apiData sales, _) => sales.TimeStamp,
//                         yValueMapper: (apiData sales, _) =>
//                             double.parse(sales.Mean),
//                         dataLabelSettings: DataLabelSettings(isVisible: false),
//                         enableTooltip: true,
//                         animationDuration: 0,
//                         color: Colors.blue,
//                       )
//                     ],
//                     zoomPanBehavior: ZoomPanBehavior(
//                       enablePinching: true,
//                       enablePanning: true,
//                       enableDoubleTapZooming: true,
//                       enableMouseWheelZooming: true,
//                       enableSelectionZooming: true,
//                       selectionRectBorderWidth: 1.0,
//                       selectionRectBorderColor: Colors.blue,
//                       selectionRectColor: Colors.transparent.withOpacity(0.3),
//                       zoomMode: ZoomMode.x,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Future<List<dynamic>> getAPIData(
//     String deviceId, String _startDate, String _endDate) async {
//   final response = await http.get(Uri.https(
//     'd2wa2msynb.execute-api.us-east-1.amazonaws.com',
//     '/inference/inferenced_data',
//     {
//       'startdate': _startDate,
//       'enddate': _endDate,
//       'deviceid': deviceId,
//     },
//   ));
//   var parsed = jsonDecode(response.body); //.cast<Map<String, dynamic>>();
//   if (response.statusCode == 200) {
//     List<dynamic> data = parsed['body'];
//     return data;
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load api');
//   }
// }

// class apiData {
//   apiData(this.TimeStamp, this.Mean, this.Class);

//   final String TimeStamp;
//   final String Mean;
//   final String Class;

//   factory apiData.fromJson(dynamic parsedJson) {
//     return apiData(
//       parsedJson['TimeStamp'].toString(),
//       parsedJson['Mean'].toString(),
//       parsedJson['Class'].toString(),
//     );
//   }
// }

// List<apiData> chartData = [];

// // Future getapiData(String deviceId, _startDate, _endDate) async {
// //   final List<dynamic> jsonString =
// //       await getAPIData(deviceId, _startDate, _endDate);

// //   for (dynamic i in jsonString) {
// //     chartData.add(apiData.fromJson(i));
// //   }

// //   // print(chartData);
// // }

// // // for single and automatically fetching Legend name from dynamoDB

// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class Inference extends StatefulWidget {
//   final String deviceId;

//   const Inference({
//     super.key,
//     required this.deviceId,
//   });

//   @override
//   State<Inference> createState() => _MyHomePageState();
// }

// List<apiData> chartData = [];

// class _MyHomePageState extends State<Inference> {
//   late TooltipBehavior _tooltipBehavior;
//   late String _startDate;
//   late String _endDate;
//   late String Class = " ";

//   List<dynamic> data = [];
//   String errorMessage = '';

//   @override
//   void initState() {
//     _tooltipBehavior = TooltipBehavior(
//       enable: true,
//       color: Colors.white,

//       // textStyle: TextStyle(color: Colors.white),
//       builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
//           int seriesIndex) {
//         final apiData item = chartData[pointIndex];
//         // Class = item.Class;
//         return Container(
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: Color.fromARGB(255, 245, 214, 250),
//             borderRadius: BorderRadius.circular(5),
//             boxShadow: [BoxShadow(color: Colors.purple, blurRadius: 3)],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text("TimeStamp: ${item.TimeStamp}"),
//               Text("Mean: ${item.Mean}"),
//               Text("Class: ${item.Class}"),
//             ],
//           ),
//         );
//       },
//     );

//     super.initState();
//   }

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   // _tooltip = TooltipBehavior(enable: true);
//   //   // _startDate = "2022-02-14";
//   //   // // _endDate = "2023-03-28";
//   //   // getapiData(widget.deviceId, _startDate, _endDate);
//   // }

//   Future<void> getAPIData(
//       String deviceId, String _startDate, String _endDate) async {
//     final response = await http.get(Uri.https(
//       'd2wa2msynb.execute-api.us-east-1.amazonaws.com',
//       '/inference/inferenced_data',
//       {
//         'startdate': _startDate,
//         'enddate': _endDate,
//         'deviceid': deviceId,
//       },
//     ));
//     var parsed = jsonDecode(response.body); //.cast<Map<String, dynamic>>();
//     if (parsed['statusCode'] == 200) {
//       data = parsed['body'];
//       chartData.clear();
//       for (dynamic i in data) {
//         chartData.add(apiData.fromJson(i));
//       }
//       setState(() {});
//     } else if (parsed['statusCode'] == 400 ||
//         parsed['statusCode'] == 404 ||
//         parsed['statusCode'] == 500) {
//       setState(() {
//         errorMessage = parsed['body'][0]['message'];
//       });
//     } else {
//       throw Exception('Failed to load api');
//     }
//   }

//   void updateData() async {
//     await getAPIData(widget.deviceId, _startDate, _endDate);
//     if (chartData.isEmpty) {
//       Class = ' ';
//     } else {
//       Class = chartData[0].Class;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'TimeSeries Graph For Insect Count',
//           style: TextStyle(
//             fontSize: 20.0,
//             letterSpacing: 1.0,
//             color: Colors.white,
//           ),
//         ),
//         // Text(widget.deviceId),
//         backgroundColor: Colors.green,
//         elevation: 0.0,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Container(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         onChanged: (value) {
//                           _startDate = value;
//                         },
//                         decoration: InputDecoration(
//                           labelText: 'Start Date (YYYY-MM-DD)',
//                           border: OutlineInputBorder(),
//                           contentPadding: EdgeInsets.symmetric(
//                               vertical: 12, horizontal: 16),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 16.0),
//                     Expanded(
//                       child: TextField(
//                         onChanged: (value) {
//                           _endDate = value;
//                         },
//                         decoration: InputDecoration(
//                           labelText: 'End Date (YYYY-MM-DD)',
//                           border: OutlineInputBorder(),
//                           contentPadding: EdgeInsets.symmetric(
//                               vertical: 12, horizontal: 16),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 16.0),
//                     ElevatedButton(
//                       onPressed: () {
//                         // fetch new data
//                         updateData();
//                       },
//                       child: Text(
//                         'Get Data',
//                         style: TextStyle(
//                           fontSize: 20,
//                         ),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         primary: Colors.green, // Set the button color to green
//                         minimumSize:
//                             Size(80, 0), // Set a minimum width for the button
//                         padding:
//                             EdgeInsets.symmetric(vertical: 20, horizontal: 24),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 32.0),
//                 if (errorMessage.isNotEmpty)
//                   Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Container(
//                         height: 400,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.5),
//                               spreadRadius: 2,
//                               blurRadius: 5,
//                               offset: Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             errorMessage,
//                             style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15,
//                             ),
//                             semanticsLabel: errorMessage = "",
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 else
//                   Container(
//                     height: 400,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16.0),
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.shade300,
//                           blurRadius: 5.0,
//                           spreadRadius: 1.0,
//                           offset: Offset(0.0, 0.0),
//                         ),
//                       ],
//                     ),
//                     child: SfCartesianChart(
//                       legend: Legend(
//                         isVisible: true,
//                         // name:legend,
//                         position: LegendPosition.top,
//                         offset: const Offset(550, -150),
//                         // title: LegendTitle(
//                         //     text: 'Insect',
//                         //     textStyle: TextStyle(
//                         //         color: Colors.black,
//                         //         fontSize: 15,
//                         //         fontStyle: FontStyle.italic,
//                         //         fontWeight: FontWeight.w900)),
//                         // toggleSeriesVisibility: true,
//                         // Border color and border width of legend
//                         overflowMode: LegendItemOverflowMode.wrap,
//                         // borderColor: Colors.black,
//                         // borderWidth: 2
//                       ),
//                       plotAreaBackgroundColor: Colors.white,
//                       primaryXAxis: CategoryAxis(
//                         title: AxisTitle(
//                           text: 'Time',
//                           textStyle: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         labelRotation: 45,
//                       ),
//                       primaryYAxis: NumericAxis(
//                         title: AxisTitle(
//                           text: 'Insect Count',
//                           textStyle: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         axisLine: AxisLine(width: 0),
//                         majorGridLines: MajorGridLines(width: 0.5),
//                       ),
//                       tooltipBehavior: _tooltipBehavior,
//                       title: ChartTitle(
//                         text: 'Graph of Insect Count',
//                         textStyle: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       // title: ChartTitle(
//                       //   text: widget.deviceId,
//                       //   textStyle: TextStyle(fontWeight: FontWeight.bold),
//                       // ),
//                       series: <ChartSeries<apiData, String>>[
//                         LineSeries<apiData, String>(
//                           // Text("Class: ${item.Class}"),
//                           // name: apiData.Class as dynamic,
//                           // name: 'Apis Mellifera',
//                           name: Class,
//                           markerSettings: const MarkerSettings(
//                             height: 3.0,
//                             width: 3.0,
//                             borderColor: Colors.green,
//                             isVisible: true,
//                           ),
//                           dataSource: chartData,
//                           xValueMapper: (apiData sales, _) => sales.TimeStamp,
//                           yValueMapper: (apiData sales, _) =>
//                               double.parse(sales.Mean),
//                           // name: ((apiData sales, _) => sales.TimeStamp) [0],
//                           // name: apiData.Class,
//                           // legendItemText: (apiData sales, _) => sales.Class,
//                           dataLabelSettings: DataLabelSettings(isVisible: true),
//                           enableTooltip: true,
//                           animationDuration: 0,
//                           color: Colors.blue,
//                         )
//                       ],
//                       zoomPanBehavior: ZoomPanBehavior(
//                         enablePinching: true,
//                         enablePanning: true,
//                         enableDoubleTapZooming: true,
//                         enableMouseWheelZooming: true,
//                         enableSelectionZooming: true,
//                         selectionRectBorderWidth: 1.0,
//                         selectionRectBorderColor: Colors.blue,
//                         selectionRectColor: Colors.transparent.withOpacity(0.3),
//                         zoomMode: ZoomMode.x,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Future<List<dynamic>> getAPIData(
//     String deviceId, String _startDate, String _endDate) async {
//   final response = await http.get(Uri.https(
//     'd2wa2msynb.execute-api.us-east-1.amazonaws.com',
//     '/inference/inferenced_data',
//     {
//       'startdate': _startDate,
//       'enddate': _endDate,
//       'deviceid': deviceId,
//     },
//   ));
//   var parsed = jsonDecode(response.body); //.cast<Map<String, dynamic>>();
//   if (response.statusCode == 200) {
//     List<dynamic> data = parsed['body'];
//     return data;
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load api');
//   }
// }

// class apiData {
//   apiData(this.TimeStamp, this.Mean, this.Class);

//   final String TimeStamp;
//   final String Mean;
//   final String Class;

//   factory apiData.fromJson(dynamic parsedJson) {
//     return apiData(
//       parsedJson['TimeStamp'].toString(),
//       parsedJson['Mean'].toString(),
//       parsedJson['Class'].toString(),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Inference extends StatefulWidget {
  final String deviceId;

  const Inference({
    super.key,
    required this.deviceId,
  });

  @override
  State<Inference> createState() => _MyHomePageState();
}

List<apiData> chartData = [];

class _MyHomePageState extends State<Inference> {
  late TooltipBehavior _tooltipBehavior;
  late DateTime _startDate;
  late DateTime _endDate;
  late String Class = " ";

  List<dynamic> data = [];
  String errorMessage = '';

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      color: Colors.white,

      // textStyle: TextStyle(color: Colors.white),
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        final apiData item = chartData[pointIndex];
        // Class = item.Class;
        return Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 245, 214, 250),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [BoxShadow(color: Colors.purple, blurRadius: 3)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("TimeStamp: ${item.TimeStamp}"),
              Text("Count: ${item.Mean}"),
              Text("Class: ${item.Class}"),
            ],
          ),
        );
      },
    );

    super.initState();
    _startDate = DateTime.parse('2023-04-27 00:00:00Z');
    _endDate = DateTime.parse('2023-04-27 23:59:59Z');
  }

  // @override
  // void initState() {
  //   super.initState();
  //   // _tooltip = TooltipBehavior(enable: true);
  //   // _startDate = "2022-02-14";
  //   // // _endDate = "2023-03-28";
  //   // getapiData(widget.deviceId, _startDate, _endDate);
  // }

  Future<void> getAPIData(
      String deviceId, DateTime _startDate, DateTime _endDate) async {
    final response = await http.get(Uri.https(
      'd2wa2msynb.execute-api.us-east-1.amazonaws.com',
      '/inference/inferenced_data',
      {
        'startdate': _startDate.year.toString() +
            "-" +
            _startDate.month.toString() +
            "-" +
            _startDate.day.toString(),
        'enddate': _endDate.year.toString() +
            "-" +
            _endDate.month.toString() +
            "-" +
            _endDate.day.toString(),
        'deviceid': deviceId,
      },
    ));
    var parsed = jsonDecode(response.body); //.cast<Map<String, dynamic>>();
    if (parsed['statusCode'] == 200) {
      data = parsed['body'];
      chartData.clear();
      for (dynamic i in data) {
        chartData.add(apiData.fromJson(i));
      }
      setState(() {});
    } else if (parsed['statusCode'] == 400 ||
        parsed['statusCode'] == 404 ||
        parsed['statusCode'] == 500) {
      setState(() {
        errorMessage = parsed['body'][0]['message'];
      });
    } else {
      throw Exception('Failed to load api');
    }
  }

  void updateData() async {
    await getAPIData(widget.deviceId, _startDate, _endDate);
    if (chartData.isEmpty) {
      Class = ' ';
    } else {
      Class = chartData[0].Class;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TimeSeries Graph For Insect Count for ' + widget.deviceId,
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 1.0,
            color: Colors.white,
          ),
        ),
        // Text(widget.deviceId),
        backgroundColor: Colors.green,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onTap: () async {
                          final DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: _startDate ?? DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: Colors.green,
                                    onPrimary: Colors.white,
                                    onSurface: Colors.purple,
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      elevation: 10,
                                      backgroundColor:
                                          Colors.black, // button text color
                                    ),
                                  ),
                                ),
                                // child: child!,
                                child: MediaQuery(
                                  data: MediaQuery.of(context)
                                      .copyWith(alwaysUse24HourFormat: true),
                                  child: child ?? Container(),
                                ),
                              );
                            },
                          );
                          if (selectedDate != null) {
                            setState(() {
                              _startDate = selectedDate;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Start Date',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                        ),
                        controller: TextEditingController(
                            text: _startDate != null
                                ? DateFormat('yyyy-MM-dd').format(_startDate)
                                : ''),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(
                        onTap: () async {
                          final DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: _endDate ?? DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: Colors.green,
                                    onPrimary: Colors.white,
                                    onSurface: Colors.purple,
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      elevation: 10,
                                      backgroundColor:
                                          Colors.black, // button text color
                                    ),
                                  ),
                                ),
                                // child: child!,
                                child: MediaQuery(
                                  data: MediaQuery.of(context)
                                      .copyWith(alwaysUse24HourFormat: true),
                                  child: child ?? Container(),
                                ),
                              );
                            },
                          );
                          if (selectedDate != null) {
                            setState(() {
                              _endDate = selectedDate;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'End Date',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                        ),
                        controller: TextEditingController(
                            text: _endDate != null
                                ? DateFormat('yyyy-MM-dd').format(_endDate)
                                : ''),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        // fetch new data
                        updateData();
                      },
                      child: Text(
                        'Get Data',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green, // Set the button color to green
                        minimumSize:
                            Size(80, 0), // Set a minimum width for the button
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.0),
                if (errorMessage.isNotEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: 400,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            errorMessage,
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            semanticsLabel: errorMessage = "",
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                          offset: Offset(0.0, 0.0),
                        ),
                      ],
                    ),
                    child: SfCartesianChart(
                      legend: Legend(
                        isVisible: true,
                        // name:legend,
                        position: LegendPosition.top,
                        offset: const Offset(550, -150),
                        // title: LegendTitle(
                        //     text: 'Insect',
                        //     textStyle: TextStyle(
                        //         color: Colors.black,
                        //         fontSize: 15,
                        //         fontStyle: FontStyle.italic,
                        //         fontWeight: FontWeight.w900)),
                        // toggleSeriesVisibility: true,
                        // Border color and border width of legend
                        overflowMode: LegendItemOverflowMode.wrap,
                        // borderColor: Colors.black,
                        // borderWidth: 2
                      ),
                      plotAreaBackgroundColor: Colors.white,
                      primaryXAxis: CategoryAxis(
                        title: AxisTitle(
                          text: 'Time',
                          textStyle: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        labelRotation: 45,
                      ),
                      primaryYAxis: NumericAxis(
                        title: AxisTitle(
                          text: 'Insect Count',
                          textStyle: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        axisLine: AxisLine(width: 0),
                        majorGridLines: MajorGridLines(width: 0.5),
                      ),
                      tooltipBehavior: _tooltipBehavior,
                      title: ChartTitle(
                        text: 'Graph of Insect Count',
                        textStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // title: ChartTitle(
                      //   text: widget.deviceId,
                      //   textStyle: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                      series: <ChartSeries<apiData, String>>[
                        LineSeries<apiData, String>(
                          // Text("Class: ${item.Class}"),
                          // name: apiData.Class as dynamic,
                          // name: 'Apis Mellifera',
                          name: Class,
                          markerSettings: const MarkerSettings(
                            height: 3.0,
                            width: 3.0,
                            borderColor: Colors.green,
                            isVisible: true,
                          ),
                          dataSource: chartData,
                          xValueMapper: (apiData sales, _) => sales.TimeStamp,
                          yValueMapper: (apiData sales, _) =>
                              double.parse(sales.Mean),
                          // name: ((apiData sales, _) => sales.TimeStamp) [0],
                          // name: apiData.Class,
                          // legendItemText: (apiData sales, _) => sales.Class,
                          dataLabelSettings:
                              DataLabelSettings(isVisible: false),
                          enableTooltip: true,
                          animationDuration: 0,
                          color: Colors.blue,
                        )
                      ],
                      zoomPanBehavior: ZoomPanBehavior(
                        enablePinching: true,
                        enablePanning: true,
                        enableDoubleTapZooming: true,
                        enableMouseWheelZooming: true,
                        enableSelectionZooming: true,
                        selectionRectBorderWidth: 1.0,
                        selectionRectBorderColor: Colors.blue,
                        selectionRectColor: Colors.transparent.withOpacity(0.3),
                        zoomMode: ZoomMode.x,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<List<dynamic>> getAPIData(
    String deviceId, DateTime _startDate, DateTime _endDate) async {
  final response = await http.get(Uri.https(
    'd2wa2msynb.execute-api.us-east-1.amazonaws.com',
    '/inference/inferenced_data',
    {
      'startdate': _startDate.year.toString() +
          "-" +
          _startDate.month.toString() +
          "-" +
          _startDate.day.toString(),
      'enddate': _endDate.year.toString() +
          "-" +
          _endDate.month.toString() +
          "-" +
          _endDate.day.toString(),
      'deviceid': deviceId,
    },
  ));
  var parsed = jsonDecode(response.body); //.cast<Map<String, dynamic>>();
  if (response.statusCode == 200) {
    List<dynamic> data = parsed['body'];
    return data;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load api');
  }
}

class apiData {
  apiData(this.TimeStamp, this.Mean, this.Class);

  final String TimeStamp;
  final String Mean;
  final String Class;

  factory apiData.fromJson(dynamic parsedJson) {
    return apiData(
      parsedJson['TimeStamp'].toString(),
      parsedJson['Mean'].toString(),
      parsedJson['Class'].toString(),
    );
  }
}

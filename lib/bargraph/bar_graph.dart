import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bargraph/bar_data.dart';


// MyBarGraph widget that represents a bar graph based on the provided data
class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  const MyBarGraph({
    super.key,
    required this.maxY,
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount});

  @override
  Widget build(BuildContext context) {
    //initialize the bar data
    BarData myBarData = BarData(sunAmount, monAmount, tueAmount, wedAmount, thurAmount, friAmount, satAmount);
    myBarData.initializeBarData();


    return BarChart(
      BarChartData(
        maxY: maxY,
        minY: 0,
        titlesData: const FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTitles,
            )
          )

        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),

        barGroups: myBarData.barData
            .map((data) => BarChartGroupData(x: data.x, barRods: [
              BarChartRodData(toY: data.y,
              color: Colors.grey[800],
                width: 25,
                borderRadius: BorderRadius.circular(4),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: maxY,
                  color: Colors.grey[200]
                )
              )
        ],))
            .toList(),
      )
    );
  }
}

// Function to get bottom titles for the x-axis based on the day of the week

Widget getBottomTitles(double value,TitleMeta meta){
  const style = TextStyle(
    color: Colors.grey,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  Widget text;
  // Switch statement to determine the day abbreviation for each x-axis value
  switch(value.toInt()){
    case 0:
      text = const Text('S',style: style,);
      break;
    case 1:
      text = const Text('M',style: style,);
      break;
    case 2:
      text = const Text('T',style: style,);
    break;
    case 3:
      text = const Text('W',style: style,);
      break;
    case 4:
      text = const Text('T',style: style,);
      break;
    case 5:
      text = const Text('F',style: style,);
      break;
    case 6:
      text = const Text('S',style: style,);
      break;
    default:
      text = const Text('',style: style,);
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
  
}

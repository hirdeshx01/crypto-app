import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PriceChangeDistributionChart extends StatelessWidget {
  const PriceChangeDistributionChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: AspectRatio(
            aspectRatio: 2.5,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 450,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        const style = TextStyle(
                          fontSize: 10,
                        );
                        Widget text;
                        switch (value.toInt()) {
                          case 0:
                            text = const Text('>10%', style: style);
                            break;
                          case 1:
                            text = const Text('7-10%', style: style);
                            break;
                          case 2:
                            text = const Text('5-7%', style: style);
                            break;
                          case 3:
                            text = const Text('3-5%', style: style);
                            break;
                          case 4:
                            text = const Text('0-3%', style: style);
                            break;
                          case 5:
                            text = const Text('0%', style: style);
                            break;
                          case 6:
                            text = const Text('0-3%', style: style);
                            break;
                          case 7:
                            text = const Text('3-5%', style: style);
                            break;
                          case 8:
                            text = const Text('5-7%', style: style);
                            break;
                          case 9:
                            text = const Text('7-10%', style: style);
                            break;
                          case 10:
                            text = const Text('>10%', style: style);
                            break;
                          default:
                            text = const Text('', style: style);
                            break;
                        }
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: text,
                        );
                      },
                      reservedSize: 30,
                    ),
                  ),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: _getBarGroups(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> _getBarGroups() {
    return [
      _makeGroupData(0, 15, const Color(0xFF32de84)),
      _makeGroupData(1, 36, const Color(0xFF32de84)),
      _makeGroupData(2, 55, const Color(0xFF32de84)),
      _makeGroupData(3, 78, const Color(0xFF32de84)),
      _makeGroupData(4, 400, const Color(0xFF32de84)),
      _makeGroupData(5, 26, Colors.grey),
      _makeGroupData(6, 448, const Color(0xFFfd5c63)),
      _makeGroupData(7, 123, const Color(0xFFfd5c63)),
      _makeGroupData(8, 45, const Color(0xFFfd5c63)),
      _makeGroupData(9, 16, const Color(0xFFfd5c63)),
      _makeGroupData(10, 11, const Color(0xFFfd5c63)),
    ];
  }

  BarChartGroupData _makeGroupData(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 16,
          borderRadius: BorderRadius.circular(8),
          rodStackItems: [
            BarChartRodStackItem(
              0,
              y,
              color,
            ),
          ],
        ),
      ],
    );
  }
}

class StackItemText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  const StackItemText({
    super.key,
    required this.text,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}

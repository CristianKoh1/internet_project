import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPaiChart extends StatelessWidget {
  final double consumed;
  final double total;

  const CustomPaiChart({
    super.key,
    required this.consumed,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1, // Mantiene un círculo
      child: PieChart(
        PieChartData(
          sectionsSpace: 0, // Sin separación entre secciones
          centerSpaceRadius: 90, // Radio del espacio central (para texto)
          startDegreeOffset: 0, // Inicia desde arriba :contentReference[oaicite:1]{index=1}
          sections: _createSections(),
          borderData: FlBorderData(show: false),
          pieTouchData: PieTouchData(enabled: false),
        ),
        swapAnimationDuration: const Duration(milliseconds: 300),
        swapAnimationCurve: Curves.easeInOut,
      ),
    );
  }

 List<PieChartSectionData> _createSections() {
  return [
    PieChartSectionData(
      value: (total - consumed).toDouble(),
      color: Colors.white.withOpacity(0.1), // Para que parezca fondo tenue
      radius: 40,
      showTitle: false,
    ),
    PieChartSectionData(
      value: consumed.toDouble(),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF0078FF), // Azul fuerte
          Color(0xFF00F0FF), // Cian brillante
        ],
      ),
      radius: 40,
      showTitle: false,
    ),
  ];
}

}

import 'package:flutter/material.dart';
import 'package:girix_code_gauge/girix_code_gauge.dart';

class AnimatedInternetSpeedGauge extends StatelessWidget {
  final double porcentaje;

  const AnimatedInternetSpeedGauge({
    Key? key,
    required this.porcentaje,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pct = porcentaje.clamp(0.0, 1.0);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: pct),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      builder: (context, animatedPct, child) {
        return SizedBox(
          child: Stack(
            alignment: Alignment.center,
            children: [
              GxRadialGauge(
                size: Size(260,260),
                showValueAtCenter: false,
                startAngleInDegree: 160,
                sweepAngleInDegree: 220,
                value: GaugeValue(value: animatedPct * 100), // Usar el valor animado
                style: const RadialGaugeStyle(
                  color: Colors.blue,
                  backgroundColor: Colors.white,
                  strokeCap: StrokeCap.square,
                  thickness: 32,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

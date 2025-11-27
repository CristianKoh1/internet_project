import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moloch_app/application/home/home_bloc.dart';
import 'package:moloch_app/domain/core/extension/option_extension.dart';
import 'package:moloch_app/l10n/app_localizations.dart';
import 'package:badges/badges.dart' as badges;
import 'package:moloch_app/theme/app_colors.dart';
import 'package:moloch_app/theme/extension.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 36),
          children: [
            // Preguntas frecuentes
            Text(
              'Preguntas frecuentes',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Pregunta 1
            const _FAQTile(
              question: '¿Cómo puedo pagar mi factura?',
              answer:
                  'Puedes pagar tu factura desde la app, en la sección de Pagos, o directamente en nuestro sitio web.',
            ),

            // Pregunta 2
            const _FAQTile(
              question: '¿Qué hago si mi internet no funciona?',
              answer:
                  'Verifica que tu módem esté encendido. Si el problema continúa, contacta con soporte técnico.',
            ),

            // Pregunta 3
            const _FAQTile(
              question: '¿Cómo puedo cambiar mi plan?',
              answer:
                  'Puedes cambiar tu plan desde la app, en la sección de Configuración > Plan.',
            ),

            const SizedBox(height: 30),

            // Sección de contacto
            Text(
              'Contáctanos',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Chat en vivo
            ListTile(
              leading: const Icon(Icons.chat_bubble_outline),
              title: const Text('Whatsapp'),
              subtitle: const Text('Lunes a Viernes, 9am - 6pm'),
              onTap: () {
                // Acción para abrir chat
              },
            ),

            // Correo electrónico
            ListTile(
              leading: const Icon(Icons.email_outlined),
              title: const Text('Correo electrónico'),
              subtitle: const Text('Respuesta en 24 horas'),
              onTap: () {
                // Acción para abrir email
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FAQTile extends StatelessWidget {
  final String question;
  final String answer;

  const _FAQTile({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.focusAndPessedPrimary12.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child:  Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Text(
            question,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          children: [
            Text(answer),
          ],
        ),
      )
    );
  }
}

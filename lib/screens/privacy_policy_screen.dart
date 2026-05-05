import 'package:flutter/material.dart';
import '../constants.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.navBackground,
        foregroundColor: Colors.white,
        title: const Text(
          'Datenschutzerklärung',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _heading('Datenschutzerklärung'),
            _body(
              'Diese App ist die offizielle mobile Anwendung der '
              'Evangelisch-Christlichen Baptistengemeinde Leipzig (EChB Leipzig). '
              'Wir nehmen den Schutz Ihrer persönlichen Daten sehr ernst.',
            ),
            const SizedBox(height: 20),

            _heading('1. Datenerhebung'),
            _body(
              'Diese App erhebt selbst keine persönlichen Daten. '
              'Die App lädt Inhalte der Webseite echb-leipzig.de über eine '
              'WebView-Komponente. Für die Datenschutzbestimmungen der Webseite '
              'verweisen wir auf die Datenschutzerklärung unter: '
              'https://echb-leipzig.de/datenschutz/',
            ),
            const SizedBox(height: 20),

            _heading('2. Internetverbindung'),
            _body(
              'Die App benötigt eine aktive Internetverbindung, um Inhalte '
              'der Webseite echb-leipzig.de anzuzeigen. Es werden dabei keine '
              'zusätzlichen Daten durch die App selbst übertragen.',
            ),
            const SizedBox(height: 20),

            _heading('3. Teilen-Funktion'),
            _body(
              'Über die Teilen-Funktion können Sie Links zu Inhalten der '
              'Webseite über externe Apps teilen. Dabei gelten die '
              'Datenschutzbestimmungen der jeweiligen geteilten Plattform.',
            ),
            const SizedBox(height: 20),

            _heading('4. Kontakt'),
            _body(
              'Bei Fragen zum Datenschutz wenden Sie sich bitte an:\n\n'
              'EChB Gemeinde Leipzig\nWebseite: https://echb-leipzig.de/kontakt/',
            ),
            const SizedBox(height: 20),

            _heading('5. Änderungen'),
            _body(
              'Wir behalten uns vor, diese Datenschutzerklärung bei Bedarf '
              'anzupassen. Die jeweils aktuelle Version ist in der App abrufbar.',
            ),
            const SizedBox(height: 40),

            Text(
              'Stand: ${DateTime.now().year}',
              style: const TextStyle(
                fontSize: 12, color: AppColors.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _heading(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      );

  Widget _body(String text) => Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.textDark,
          height: 1.6,
        ),
      );
}

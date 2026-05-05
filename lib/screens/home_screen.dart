import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../constants.dart';
import '../providers/webview_provider.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Wait until WebViewWidget is part of the layout before the
    // controller starts loading — prevents crash on startup
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(webViewProvider.notifier).init();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final webViewState = ref.watch(webViewProvider);
    final notifier = ref.read(webViewProvider.notifier);
    final controller = notifier.controller;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (await controller.canGoBack()) {
          controller.goBack();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const AppTopBar(),
        body: Stack(
          children: [
            // ── WebView ───────────────────────────────────────────────
            Positioned.fill(
              child: AnimatedOpacity(
                opacity: webViewState.hasError ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: WebViewWidget(controller: controller),
              ),
            ),

            // ── Progress bar ──────────────────────────────────────────
            if (webViewState.isLoading)
              Positioned(
                top: 0, left: 0, right: 0,
                child: LinearProgressIndicator(
                  value: webViewState.progress > 0
                      ? webViewState.progress
                      : null,
                  minHeight: 3,
                  backgroundColor: Colors.transparent,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.accent,
                  ),
                ),
              ),

            // ── Error / Offline screen ────────────────────────────────
            if (webViewState.hasError)
              _ErrorScreen(onRetry: notifier.reload),
          ],
        ),
        bottomNavigationBar: const AppBottomNavBar(),
      ),
    );
  }
}

// ─── Offline Error Screen ─────────────────────────────────────────────────────
class _ErrorScreen extends StatelessWidget {
  final VoidCallback onRetry;
  const _ErrorScreen({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80, height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.wifi_off_rounded, size: 36, color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Keine Verbindung',
                style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Bitte überprüfen Sie Ihre Internetverbindung '
                    'und versuchen Sie es erneut.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14, color: AppColors.textLight, height: 1.6,
                ),
              ),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: onRetry,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28, vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.navBackground],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.35),
                        blurRadius: 14, offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.refresh_rounded,
                          color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Erneut versuchen',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../constants.dart';
import '../providers/webview_provider.dart';

class AppTopBar extends ConsumerWidget implements PreferredSizeWidget {
  const AppTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab    = ref.watch(activeTabProvider);
    final webViewState = ref.watch(webViewProvider);
    final notifier     = ref.read(webViewProvider.notifier);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.navBackground, AppColors.primary],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x44000000), blurRadius: 8, offset: Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Row(
            children: [
              // // Back button
              // AnimatedOpacity(
              //   opacity: webViewState.canGoBack ? 1.0 : 0.3,
              //   duration: const Duration(milliseconds: 200),
              //   child: _BarButton(
              //     icon: Icons.arrow_back_ios_new_rounded,
              //     onTap: webViewState.canGoBack
              //         ? () => notifier.goBack()
              //         : null,
              //   ),
              // ),
              // const SizedBox(width: 10),

              // Title
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.accent.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(
                          color: AppColors.accent.withOpacity(0.35),
                        ),
                      ),
                      child: const Icon(
                        Icons.church_rounded,
                        color: AppColors.accent, size: 17,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'EChB Leipzig',
                          style: TextStyle(
                            color: Colors.white, fontSize: 15,
                            fontWeight: FontWeight.w700, letterSpacing: 0.2,
                          ),
                        ),
                        Text(
                          kNavItems[activeTab].label,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Share button
              _BarButton(
                icon: Icons.share_rounded,
                onTap: () {
                  final url = webViewState.currentUrl.isNotEmpty
                      ? webViewState.currentUrl
                      : kNavItems[activeTab].url;
                  Share.share(
                    'EChB Gemeinde Leipzig\n$url',
                    subject: 'EChB Leipzig – ${kNavItems[activeTab].label}',
                  );
                },
              ),
              const SizedBox(width: 6),

              // Reload button
              _BarButton(
                icon: Icons.refresh_rounded,
                onTap: () => notifier.reload(),
                spinning: webViewState.isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BarButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool spinning;

  const _BarButton({required this.icon, this.onTap, this.spinning = false});

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = Icon(icon, color: Colors.white, size: 17);

    if (spinning) {
      iconWidget = TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 900),
        builder: (_, value, child) => Transform.rotate(
          angle: value * 2 * 3.14159,
          child: child,
        ),
        child: iconWidget,
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34, height: 34,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: iconWidget,
      ),
    );
  }
}

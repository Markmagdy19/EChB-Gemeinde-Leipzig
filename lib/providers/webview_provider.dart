import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../constants.dart';

class ActiveTabNotifier extends StateNotifier<int> {
  ActiveTabNotifier() : super(0);
  void setTab(int index) => state = index;
}

final activeTabProvider = StateNotifierProvider<ActiveTabNotifier, int>(
      (ref) => ActiveTabNotifier(),
);

class WebViewState {
  final bool isLoading;
  final double progress;
  final bool hasError;
  final bool canGoBack;
  final String currentUrl;

  const WebViewState({
    this.isLoading = true,
    this.progress = 0.0,
    this.hasError = false,
    this.canGoBack = false,
    this.currentUrl = 'https://echb-leipzig.de/',
  });

  WebViewState copyWith({
    bool? isLoading,
    double? progress,
    bool? hasError,
    bool? canGoBack,
    String? currentUrl,
  }) =>
      WebViewState(
        isLoading: isLoading ?? this.isLoading,
        progress: progress ?? this.progress,
        hasError: hasError ?? this.hasError,
        canGoBack: canGoBack ?? this.canGoBack,
        currentUrl: currentUrl ?? this.currentUrl,
      );
}

class WebViewNotifier extends StateNotifier<WebViewState> {


  WebViewNotifier() : super(const WebViewState());

  WebViewController? _controller;
  bool _initialized = false;

  WebViewController get controller {
    if (_controller == null) {
      throw Exception('WebViewController not initialized. Call init() after widget is attached.');
    }
    return _controller!;
  }

  void init() {
    if (_initialized) return;
    _initialized = true;
    _controller = _buildController();
    // Only safe to load here, after widget attached.
    _controller!.loadRequest(Uri.parse(kNavItems[0].url));
  }

  WebViewController _buildController() {
    final ctrl = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFF5F2EE))
      ..setUserAgent(
        'Mozilla/5.0 (Linux; Android 13) AppleWebKit/537.36 '
            '(KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36',
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) => _safeUpdate(
            state.copyWith(isLoading: true, progress: 0.0,
                hasError: false, currentUrl: url),
          ),
          onProgress: (progress) => _safeUpdate(
            state.copyWith(progress: progress / 100.0),
          ),
          onPageFinished: (url) async {
            final canGoBack = await _controller?.canGoBack() ?? false;
            _safeUpdate(state.copyWith(
                isLoading: false, currentUrl: url, canGoBack: canGoBack));
          },
          onWebResourceError: (error) {
            if (error.isForMainFrame ?? true) {
              _safeUpdate(state.copyWith(hasError: true, isLoading: false));
            }
          },
          onNavigationRequest: (_) => NavigationDecision.navigate,
        ),
      );
    return ctrl;
  }



  void _safeUpdate(WebViewState newState) {
    if (mounted) state = newState;
  }

  void navigateTo(String url) {
    _safeUpdate(state.copyWith(isLoading: true, progress: 0.0,
        hasError: false, canGoBack: false));
    controller.loadRequest(Uri.parse(url));
  }

  void reload() => controller.reload();
  void goBack() => controller.goBack();
}

final webViewProvider =
StateNotifierProvider<WebViewNotifier, WebViewState>(
      (ref) => WebViewNotifier(),
);

final webViewStateProvider = webViewProvider;

final webViewControllerProvider = Provider<WebViewController>(
      (ref) => ref.read(webViewProvider.notifier).controller,
);
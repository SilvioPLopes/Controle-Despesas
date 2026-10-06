import 'package:controle_ds/core/session/session_events.dart';
import 'package:controle_ds/core/storage/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refreshListenable = _RouterRefreshListenable();
  ref.listen<bool>(sessionExpiredProvider, (previous, next) {
    if (previous != next) {
      refreshListenable.refresh();
    }
  });

  final router = GoRouter(
    initialLocation: '/splash',
    refreshListenable: refreshListenable,
    redirect: (context, state) async {
      if (state.matchedLocation != '/home') {
        return null;
      }
      if (ref.read(sessionExpiredProvider)) {
        return '/login';
      }
      final tokens = await ref.read(tokenStorageProvider).read();
      return tokens == null ? '/login' : null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const _PlaceholderPage(label: 'Splash'),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const _PlaceholderPage(label: 'Login'),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const _PlaceholderPage(label: 'Cadastro'),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) =>
            const _PlaceholderPage(label: 'Recuperar senha'),
      ),
      GoRoute(
        path: '/reset-password',
        builder: (context, state) =>
            const _PlaceholderPage(label: 'Redefinir senha'),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const _PlaceholderPage(label: 'Início'),
      ),
    ],
  );
  ref.onDispose(() {
    router.dispose();
    refreshListenable.dispose();
  });
  return router;
});

class _RouterRefreshListenable extends ChangeNotifier {
  void refresh() => notifyListeners();
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text(label)));
}

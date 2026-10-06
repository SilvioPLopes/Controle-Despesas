import 'package:controle_ds/features/finance/presentation/categories_page.dart';
import 'package:controle_ds/features/finance/presentation/dashboard_page.dart';
import 'package:controle_ds/features/finance/presentation/transactions_page.dart';
import 'package:controle_ds/features/portfolio/presentation/portfolio_page.dart';
import 'package:controle_ds/features/more/presentation/more_page.dart';
import 'package:controle_ds/features/auth/presentation/auth_error_message.dart';
import 'package:controle_ds/features/auth/presentation/session_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({super.key});

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  int _selectedIndex = 0;

  static const _pages = [
    DashboardPage(),
    TransactionsPage(),
    CategoriesPage(),
    PortfolioPage(),
    MorePage(),
  ];

  Future<void> _logout() async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(sessionNotifierProvider.notifier).logout();
    } on Object catch (error) {
      messenger.showSnackBar(SnackBar(content: Text(authErrorMessage(error))));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: SafeArea(
            bottom: false,
            child: TextButton.icon(
              key: const Key('logout-button'),
              onPressed: ref.watch(sessionNotifierProvider).isLoading
                  ? null
                  : _logout,
              icon: const Icon(Icons.logout),
              label: const Text('Sair'),
            ),
          ),
        ),
        Expanded(
          child: IndexedStack(index: _selectedIndex, children: _pages),
        ),
      ],
    ),
    bottomNavigationBar: NavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) => setState(() => _selectedIndex = index),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.dashboard_outlined),
          selectedIcon: Icon(Icons.dashboard),
          label: 'Resumo',
        ),
        NavigationDestination(
          icon: Icon(Icons.receipt_long_outlined),
          selectedIcon: Icon(Icons.receipt_long),
          label: 'Transações',
        ),
        NavigationDestination(
          icon: Icon(Icons.category_outlined),
          selectedIcon: Icon(Icons.category),
          label: 'Categorias',
        ),
        NavigationDestination(
          icon: Icon(Icons.account_balance_wallet_outlined),
          selectedIcon: Icon(Icons.account_balance_wallet),
          label: 'Carteira',
        ),
        NavigationDestination(
          icon: Icon(Icons.more_horiz),
          selectedIcon: Icon(Icons.more),
          label: 'Mais',
        ),
      ],
    ),
  );
}

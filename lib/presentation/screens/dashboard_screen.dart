import 'package:flutter/material.dart';
import 'package:papeltaksi/core/constants/app_colors.dart';
import 'package:papeltaksi/presentation/screens/payment_screen.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    _HomeTab(),
    _TransactionsTab(),
    _WalletTab(),
    _ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'İşlemler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            activeIcon: Icon(Icons.account_balance_wallet),
            label: 'Cüzdan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

// Home Tab
class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Papel Taksi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Balance Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Toplam Bakiye',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '₺12,450.00',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _BalanceInfo(
                        label: 'Bu Ay',
                        value: '₺8,320.00',
                        icon: Icons.trending_up,
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.white24,
                      ),
                      _BalanceInfo(
                        label: 'İşlem Sayısı',
                        value: '142',
                        icon: Icons.receipt_long,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Payment Button
            SizedBox(
              height: 64,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const PaymentScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.payment, size: 28),
                    SizedBox(width: 12),
                    Text(
                      'Ödeme Al',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Quick Stats
            Text(
              'Hızlı İstatistikler',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Bugün',
                    value: '₺1,250',
                    icon: Icons.today,
                    color: AppColors.success,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    title: 'Bu Hafta',
                    value: '₺5,680',
                    icon: Icons.calendar_today,
                    color: AppColors.info,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Recent Transactions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Son İşlemler',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Tümünü Gör'),
                ),
              ],
            ),

            const SizedBox(height: 8),

            ..._buildRecentTransactions(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildRecentTransactions() {
    return List.generate(
      5,
      (index) => _TransactionItem(
        amount: (50 + (index * 15)).toDouble(),
        date: DateTime.now().subtract(Duration(hours: index * 2)),
        status: index % 3 == 0 ? 'Tamamlandı' : 'Onaylandı',
      ),
    );
  }
}

class _BalanceInfo extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _BalanceInfo({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white70, size: 16),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final double amount;
  final DateTime date;
  final String status;

  const _TransactionItem({
    required this.amount,
    required this.date,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(locale: 'tr_TR', symbol: '₺');
    final dateFormatter = DateFormat('dd.MM.yyyy HH:mm');

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.check_circle,
            color: AppColors.accent,
          ),
        ),
        title: Text(formatter.format(amount)),
        subtitle: Text(dateFormatter.format(date)),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            status,
            style: const TextStyle(
              color: AppColors.success,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// Transactions Tab
class _TransactionsTab extends StatelessWidget {
  const _TransactionsTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İşlemler'),
      ),
      body: const Center(
        child: Text('İşlemler ekranı yakında eklenecek'),
      ),
    );
  }
}

// Wallet Tab
class _WalletTab extends StatelessWidget {
  const _WalletTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cüzdan'),
      ),
      body: const Center(
        child: Text('Cüzdan ekranı yakında eklenecek'),
      ),
    );
  }
}

// Profile Tab
class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: const Center(
        child: Text('Profil ekranı yakında eklenecek'),
      ),
    );
  }
}

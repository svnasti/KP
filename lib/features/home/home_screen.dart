import 'package:flutter/material.dart';
import 'package:shared_expenses_manager/core/data/mock_data.dart';
import 'package:shared_expenses_manager/core/models/group.dart';
import 'package:shared_expenses_manager/core/theme/app_colors.dart';
import 'package:shared_expenses_manager/core/utils/snackbars.dart';
import 'package:shared_expenses_manager/core/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const double _wideBreakpoint = 700;
  static const List<String> _sortOptions = [
    'За замовчуванням',
    'За назвою',
    'За сумою балансу',
  ];

  String _query = '';
  int _sortIndex = 0;

  List<Group> get _visibleGroups {
    final query = _query.toLowerCase();
    final groups = MockData.groups
        .where((group) => group.name.toLowerCase().contains(query))
        .toList();
    if (_sortIndex == 1) {
      groups.sort((a, b) => a.name.compareTo(b.name));
    } else if (_sortIndex == 2) {
      groups.sort((a, b) => b.balance.compareTo(a.balance));
    }
    return groups;
  }

  void _showNotifications() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Сповіщення', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              const ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.receipt_long_outlined),
                title: Text('Олена додала витрату «Вечеря у кафе»'),
                subtitle: Text('Сьогодні'),
              ),
              const ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.account_balance_wallet_outlined),
                title: Text(
                  'Баланс у групі «Квартира на Личаківській» змінився',
                ),
                subtitle: Text('Вчора'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationsButton() {
    return IconButton(
      tooltip: 'Сповіщення',
      onPressed: _showNotifications,
      icon: const Badge(
        label: Text('2'),
        child: Icon(Icons.notifications_none),
      ),
    );
  }

  Widget _buildGroupsSection() {
    final groups = _visibleGroups;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ваші групи',
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => showComingSoon(context),
              child: const Text('+ Нова'),
            ),
          ],
        ),
        SearchSortBar(
          hint: 'Пошук груп',
          sortOptions: _sortOptions,
          selectedSort: _sortIndex,
          onChanged: (value) => setState(() => _query = value),
          onSortSelected: (index) => setState(() => _sortIndex = index),
        ),
        if (groups.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: Text('Груп не знайдено')),
          )
        else
          for (final group in groups)
            GroupListItem(group: group, onTap: () => showComingSoon(context)),
      ],
    );
  }

  Widget _buildRecentExpenses() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceGray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Останні витрати',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () => showComingSoon(context),
                child: const Text('Дивитися всі'),
              ),
            ],
          ),
          for (final expense in MockData.recentExpenses)
            ExpenseListItem(expense: expense),
        ],
      ),
    );
  }

  Widget _buildNarrowBody() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 88),
      children: [
        BalanceCard(label: 'Загальний баланс', amount: MockData.totalBalance),
        const SizedBox(height: 16),
        _buildGroupsSection(),
      ],
    );
  }

  Widget _buildWideBody() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 32, 40, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Менеджер спільних витрат',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              _buildNotificationsButton(),
              const SizedBox(width: 16),
              FilledButton(
                style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
                onPressed: () => showComingSoon(context),
                child: const Text('+ Нова група'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 32,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 420),
                          child: BalanceCard(
                            label: 'Загальний баланс',
                            amount: MockData.totalBalance,
                          ),
                        ),
                        _buildGroupsSection(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 360,
                  child: SingleChildScrollView(child: _buildRecentExpenses()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= _wideBreakpoint;
        return Scaffold(
          appBar: isWide
              ? null
              : AppBar(
                  title: const Text('Менеджер спільних витрат'),
                  actions: [
                    _buildNotificationsButton(),
                    const SizedBox(width: 8),
                  ],
                ),
          floatingActionButton: isWide
              ? null
              : FloatingActionButton(
                  onPressed: () => showComingSoon(context),
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.add),
                ),
          body: isWide ? _buildWideBody() : _buildNarrowBody(),
        );
      },
    );
  }
}

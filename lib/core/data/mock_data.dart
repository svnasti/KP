import 'package:shared_expenses_manager/core/models/expense.dart';
import 'package:shared_expenses_manager/core/models/group.dart';

abstract final class MockData {
  static const String userName = 'Анастасія Сивик';
  static const String userEmail = 'anastasiia@example.com';
  static const String userInitials = 'АС';
  static const String paymentDetails = '5375 4141 0000 1234';

  static const List<Group> groups = [
    Group(name: 'Поїздка у Карпати', members: 4, balance: 320),
    Group(name: 'Квартира на Личаківській', members: 3, balance: -120),
    Group(name: 'Офісні обіди', members: 6, balance: 250),
  ];

  static const List<Expense> recentExpenses = [
    Expense(
      title: 'Вечеря у кафе',
      subtitle: 'Заплатила Олена • 12.09',
      amount: 640,
    ),
    Expense(title: 'Таксі', subtitle: 'Заплатив Іван • 11.09', amount: 180),
    Expense(title: 'Продукти', subtitle: 'Заплатила Ви • 10.09', amount: 560),
  ];

  static int get totalBalance =>
      groups.fold(0, (sum, group) => sum + group.balance);
}

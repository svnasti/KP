import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_expenses_manager/app.dart';
import 'package:shared_expenses_manager/core/utils/formatters.dart';

Future<void> pumpApp(
  WidgetTester tester, {
  Size size = const Size(390, 844),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(const SharedExpensesApp());
}

Future<void> tapText(WidgetTester tester, String text) async {
  final finder = find.text(text);
  await tester.ensureVisible(finder);
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  group('Форматування', () {
    test('formatAmount додає знак і розділяє тисячі', () {
      expect(formatAmount(1200), '1 200 грн');
      expect(formatAmount(320, withSign: true), '+320 грн');
      expect(formatAmount(-120, withSign: true), '-120 грн');
    });

    test('membersLabel правильно відмінює слово «учасник»', () {
      expect(membersLabel(1), '1 учасник');
      expect(membersLabel(3), '3 учасники');
      expect(membersLabel(6), '6 учасників');
      expect(membersLabel(12), '12 учасників');
      expect(membersLabel(21), '21 учасник');
    });
  });

  group('Автентифікація', () {
    testWidgets('застосунок стартує з екрана входу', (tester) async {
      await pumpApp(tester);
      expect(find.text('Вхід'), findsOneWidget);
      expect(find.text('Увійти'), findsOneWidget);
    });

    testWidgets('кнопка «Увійти» відкриває головний екран', (tester) async {
      await pumpApp(tester);
      await tapText(tester, 'Увійти');
      expect(find.text('Ваші групи'), findsOneWidget);
      expect(find.text('Загальний баланс'), findsOneWidget);
    });

    testWidgets('реєстрація доступна лише після згоди з правилами', (
      tester,
    ) async {
      await pumpApp(tester);
      await tapText(tester, 'Немає акаунту? Зареєструватися');

      final button = find.widgetWithText(FilledButton, 'Зареєструватися');
      expect(tester.widget<FilledButton>(button).onPressed, isNull);

      await tester.tap(find.byType(Checkbox));
      await tester.pump();
      expect(tester.widget<FilledButton>(button).onPressed, isNotNull);

      await tester.tap(button);
      await tester.pumpAndSettle();
      expect(find.text('Ваші групи'), findsOneWidget);
    });

    testWidgets('відновлення пароля показує підтвердження', (tester) async {
      await pumpApp(tester);
      await tapText(tester, 'Забули пароль?');
      expect(find.text('Відновлення паролю'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'test@example.com');
      await tapText(tester, 'Надіслати посилання');
      expect(find.text('Перевірте пошту'), findsOneWidget);
      expect(find.textContaining('test@example.com'), findsOneWidget);

      await tapText(tester, 'Повернутися до входу');
      expect(find.text('Вхід'), findsOneWidget);
    });

    testWidgets('іконка «око» показує і ховає пароль', (tester) async {
      await pumpApp(tester);
      TextField passwordField() =>
          tester.widget<TextField>(find.byType(TextField).last);

      expect(passwordField().obscureText, isTrue);
      await tester.tap(find.byIcon(Icons.visibility_outlined));
      await tester.pump();
      expect(passwordField().obscureText, isFalse);
    });
  });

  group('Головний екран', () {
    testWidgets('пошук фільтрує список груп', (tester) async {
      await pumpApp(tester);
      await tapText(tester, 'Увійти');

      expect(find.text('Поїздка у Карпати'), findsOneWidget);
      expect(find.text('Офісні обіди'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'обіди');
      await tester.pump();
      expect(find.text('Поїздка у Карпати'), findsNothing);
      expect(find.text('Офісні обіди'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'невідома');
      await tester.pump();
      expect(find.text('Груп не знайдено'), findsOneWidget);
    });

    testWidgets('на вузькому екрані є нижня навігація', (tester) async {
      await pumpApp(tester);
      await tapText(tester, 'Увійти');
      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.byType(NavigationRail), findsNothing);
    });

    testWidgets('на широкому екрані є бічна навігація та блок витрат', (
      tester,
    ) async {
      await pumpApp(tester, size: const Size(1100, 720));
      await tapText(tester, 'Увійти');
      expect(find.byType(NavigationRail), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);
      expect(find.text('Останні витрати'), findsOneWidget);
    });
  });

  group('Профіль', () {
    testWidgets('перехід на вкладку «Профіль» і зміна пароля', (tester) async {
      await pumpApp(tester);
      await tapText(tester, 'Увійти');
      await tester.tap(find.text('Профіль').last);
      await tester.pumpAndSettle();
      expect(find.text('Платіжні реквізити'), findsOneWidget);

      await tapText(tester, 'Змінити пароль');
      expect(find.text('Зміна пароля'), findsOneWidget);

      await tapText(tester, 'Зберегти пароль');
      expect(find.text('Пароль змінено'), findsOneWidget);
    });

    testWidgets('вихід з акаунта повертає на екран входу', (tester) async {
      await pumpApp(tester);
      await tapText(tester, 'Увійти');
      await tester.tap(find.text('Профіль').last);
      await tester.pumpAndSettle();

      await tapText(tester, 'Вийти з акаунта');
      expect(find.text('Вийти з акаунта?'), findsOneWidget);

      await tapText(tester, 'Вийти');
      expect(find.text('Вхід'), findsOneWidget);
    });
  });
}

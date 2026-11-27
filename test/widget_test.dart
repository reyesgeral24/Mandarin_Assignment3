import 'package:flutter_test/flutter_test.dart';
import 'package:mandarin/main.dart';

void main() {
  testWidgets('Shows the Mandarin home screen', (tester) async {
    await tester.pumpWidget(const MandarinApp());

    expect(find.text('MANDARIN'), findsOneWidget);
    expect(
      find.text('Enjoy the Taste of Mandarin at Home'),
      findsOneWidget,
    );
  });
}
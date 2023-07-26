import 'package:furnday/constants.dart';

class DecoratedCard extends StatelessWidget {
  const DecoratedCard({
    super.key,
    required this.child,
  });

  final child;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: kBorderRadiusCard,
      elevation: 8,
      child: Container(
        decoration: BoxDecoration(
          color: kWhiteBackground,
          borderRadius: kBorderRadiusCard,
          border: Border.all(
            color: kYellowColor,
          ),
        ),
        child: child,
      ),
    );
  }
}

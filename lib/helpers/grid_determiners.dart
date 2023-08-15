import 'package:furnday/constants.dart';

gridCrossAxisCountDeterminer(BuildContext context) {
  if (MediaQuery.of(context).size.height > 1100.0 ||
      MediaQuery.of(context).size.width > 800.0) {
    return 3;
  } else if (MediaQuery.of(context).size.width > 300.0 ||
      MediaQuery.of(context).size.height > 700.0) {
    return 2;
  } else {
    return 1;
  }
}

gridChildAspectRatioDeterminer(BuildContext context, gridCrossAxisCount) {
  if (gridCrossAxisCount == 3) {
    return (MediaQuery.of(context).size.width / 2) /
        ((MediaQuery.of(context).size.height - 56 - 24) / 2);
  } else {
    return (MediaQuery.of(context).size.width / 2) /
        ((MediaQuery.of(context).size.height - 56 - 24) / 2.10);
  }
}

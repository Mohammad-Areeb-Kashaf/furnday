import 'package:furnday/constants.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay(
      {super.key, required this.child, required this.isLoading});
  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return OverlayLoaderWithAppIcon(
      appIcon: Image.asset("assets/logo.png"),
      isLoading: isLoading,
      circularProgressColor: kYellowColor,
      overlayBackgroundColor: Colors.black26,
      child: child,
    );
  }
}

import 'package:furnday/constants.dart';

class HeadingSectionText extends StatelessWidget {
  const HeadingSectionText(
      {super.key,
      required this.headingText,
      this.isAddress = false,
      this.onPressed});
  final bool isAddress;
  final VoidCallback? onPressed;

  final String headingText;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 246, 195, 60),
        borderRadius: BorderRadius.only(
          topLeft: kRadius,
          topRight: kRadius,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                headingText,
                style: Theme.of(context).textTheme.labelLarge,
                minFontSize: 18,
                maxFontSize: 26,
                maxLines: 1,
              ),
            ),
          ),
          isAddress
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: TextButton(
                    onPressed: isAddress ? onPressed : null,
                    child: Text(
                      'Edit',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

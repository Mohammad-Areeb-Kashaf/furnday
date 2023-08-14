import 'package:furnday/constants.dart';

typedef RatingChangeCallback = void Function(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final onRatingChanged;

  const StarRating({
    super.key,
    this.starCount = 5,
    this.rating = .0,
    this.onRatingChanged,
  });

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = const Icon(
        Icons.star_border,
        color: kGreyTextColor,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = const Icon(
        Icons.star_half,
        color: kYellowColor,
      );
    } else {
      icon = const Icon(
        Icons.star,
        color: kYellowColor,
      );
    }
    return InkResponse(
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        starCount,
        (index) => buildStar(context, index),
      ),
    );
  }
}

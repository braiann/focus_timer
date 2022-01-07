import 'category.dart';

class FocusPeriod {
  late DateTime createdAt;
  Duration duration;
  Category category;
  Duration? interruptedAt;

  FocusPeriod(
      {required this.duration, required this.category, this.interruptedAt}) {
    createdAt = DateTime.now();
  }

  getDuration() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return (duration.inHours > 0 ? '${twoDigits(duration.inHours)}:' : '') +
        '$twoDigitMinutes:$twoDigitSeconds';
  }
}

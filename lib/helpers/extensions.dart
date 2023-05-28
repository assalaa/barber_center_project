extension StringTime on DateTime {
  String toStringTime({bool twelveHours = false}) {
    int hours = hour;
    final int minutes = minute;

    if (!twelveHours) {
      return '${hours < 10 ? '0' : ''}$hours:${minutes < 10 ? '0' : ''}$minutes';
    } else {
      String tag = 'AM';
      if (hours > 12) {
        hours = hours - 12;
        tag = 'PM';
      } else if (hours == 12) {
        tag = 'PM';
      } else if (hours == 0) {
        hours = 12;
        tag = 'AM';
      }

      return '${hours < 10 ? '0' : ''}$hours:${minutes < 10 ? '0' : ''}$minutes $tag';
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

extension ToDateTime on String {
  DateTime? toDateTime() {
    if (contains(':')) {
      final List<String> hourMinute = split(':');

      return DateTime(DateTime.now().year).copyWith(
        hour: int.parse(hourMinute[0]),
        minute: int.parse(hourMinute[1]),
      );
    }
    return null;
  }
}

extension StringTime on DateTime {
  String toStringTime() {
    final int hours = hour;
    final int minutes = minute;
    return '${hours < 10 ? '0' : ''}$hours:${minutes < 10 ? '0' : ''}$minutes';
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

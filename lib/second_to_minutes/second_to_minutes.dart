Duration convertSecondsToDuration(int seconds) {
  int minutes = seconds ~/ 60; // Get the whole minutes
  int remainingSeconds = seconds % 60; // Get the remaining seconds

  // Create a Duration object with the given minutes and remaining seconds
  return Duration(minutes: minutes, seconds: remainingSeconds);
}

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');

  // Extract minutes and seconds from the duration
  int minutes = duration.inMinutes;
  int seconds = duration.inSeconds.remainder(60);

  // Format the duration as "MM:SS"
  return '${twoDigits(minutes)}:${twoDigits(seconds)}';
}

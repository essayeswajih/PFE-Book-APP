import 'package:intl/intl.dart';
class Calc {
  String formatYearFromString(String timestamp) {
    try {
      print("Processing timestamp for year extraction: $timestamp");

      // Regular expression to extract seconds
      final regex = RegExp(r'Timestamp\(seconds=(\d+), nanoseconds=\d+\)');
      final match = regex.firstMatch(timestamp);

      if (match != null) {
        print("Regex match found: ${match.group(1)}");

        // Parse the seconds value
        final seconds = int.parse(match.group(1)!);
        print("Extracted seconds: $seconds");

        // Convert seconds to DateTime
        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
        print("Converted DateTime: $dateTime");

        // Format and return the year
        String formattedYear = DateFormat('yyyy').format(dateTime);
        print("Formatted year: $formattedYear");
        return formattedYear;
      } else {
        print("Regex did not match the timestamp.");
        return 'Unknown'; // Fallback if regex does not match
      }
    } catch (e) {
      print("Error in formatYearFromString: $e");
      return 'Unknown'; // Fallback for errors
    }
  }

  String formatYearRange(String timestamp) {
    try {
      print("Input timestamp: $timestamp");

      // Extract year from the timestamp string
      String yearString = formatYearFromString(timestamp);
      print("Extracted year: $yearString");

      // Parse the year and add 1 for the next year
      int currentYear = int.parse(yearString);
      int nextYear = currentYear + 1;

      // Return the range in the desired format
      return '$currentYear - $nextYear';
    } catch (e) {
      print("Error in formatYearRange: $e");
      return 'Unknown'; // Fallback for errors
    }
  }
}
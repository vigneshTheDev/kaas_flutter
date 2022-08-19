import 'package:intl/intl.dart';

class ParsedDescription {
  String description = '';
  double amount = 0.0;
  String amountFormatted = '0.00';
  List<Segment> segments = [];

  final NumberFormat _formatter = NumberFormat.compactSimpleCurrency();

  ParsedDescription({this.description = ''}) {
    _parseDescription();
  }

  updateDescription(String desc) {
    description = desc;
    _parseDescription();
  }

  _parseDescription() {
    final desc = description;

    amount = _getAmount(desc);
    amountFormatted = _formatter.format(amount);

    final trimmed = _trimDescription(desc);
    segments = _getSegments(trimmed);
  }

  double _getAmount(String value) {
    final amountPattern = RegExp('\\+?[0-9]+(\\.[0-9]*)?');
    final amountMatch = amountPattern.allMatches(value);
    final amount = amountMatch.isEmpty
        ? '+0.0'
        : value.substring(amountMatch.last.start, amountMatch.last.end);
    return double.parse(RegExp('^\\+').hasMatch(amount) ? amount : '-$amount');
  }

  List<Segment> _getSegments(String value) {
    final tagPattern = RegExp('#[a-z,A-Z,-_]*');
    final tagMatches = tagPattern.allMatches(value);

    final List<Segment> segments = [];

    int start = 0;
    for (var t in tagMatches) {
      if (start < t.start) {
        segments.add(
          Segment(start, t.start, value.substring(start, t.start)),
        );
      }
      segments.add(
        Segment(t.start, t.end, value.substring(t.start, t.end), isTag: true),
      );
      start = t.end;
    }

    if (start < value.length) {
      segments.add(
          Segment(start, value.length, value.substring(start, value.length)));
    }

    return segments;
  }

  String _trimDescription(String value) {
    final amountInEndPattern = RegExp('\\+?[0-9]+(\\.[0-9]+)?\$');
    if (amountInEndPattern.hasMatch(value)) {
      return value.replaceAll(amountInEndPattern, '');
    }
    return value;
  }
}

class Segment {
  final int start;
  final int end;
  final String string;
  final bool isTag;
  Segment(this.start, this.end, this.string, {this.isTag = false});
}

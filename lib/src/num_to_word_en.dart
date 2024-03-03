///A class handle convert number to words
///
class NumberToWordEn {
  NumberToWordEn._();

  static const String _zero = 'zero';
  static const String _hundred = 'hundred';
  static const String _thousand = 'thousand';
  static const String _million = 'million';
  static const String _billion = 'billion';

  static const List<String> _nums = [
    '',
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine',
    'ten',
    'eleven',
    'twelve',
    'thirteen',
    'fourteen',
    'fifteen',
    'sixteen',
    'seventeen',
    'eighteen',
    'nineteen'
  ];

  static const List<String> _tens = [
    '',
    'ten',
    'twenty',
    'thirty',
    'forty',
    'fifty',
    'sixty',
    'seventy',
    'eighty',
    'ninety'
  ];

  ///handle converter
  static String enToText({int? number = 0}) {
    if (number == 0) {
      return _zero;
    }
    final String strNumber = number.toString().padLeft(12, '0');

    final int bils = int.parse(strNumber.substring(0, 3));

    final int mils = int.parse(strNumber.substring(3, 6));

    final int hundredThousands = int.parse(strNumber.substring(6, 9));

    final int thousands = int.parse(strNumber.substring(9, 12));

    final String tradBils = getBillions(bils);
    String result = tradBils;

    final String tradMils = getMillions(mils);
    result = result + tradMils;

    final String tradHundredThousands = getThousands(hundredThousands);
    result = result + tradHundredThousands;

    String tradThousand;
    tradThousand = lessThanOneThousand(thousands, true);
    result = result + tradThousand;

    // remove spaces
    result = result
        .replaceAll(RegExp('\\s+'), ' ')
        .replaceAll('\\b\\s{2,}\\b', ' ')
        .trim();
    return result.substring(0, 1).toUpperCase() + result.substring(1);
  }

  ///get Billions
  static String getBillions(int billions) {
    String tradBillions;
    switch (billions) {
      case 0:
        tradBillions = '';
        break;
      case 1:
        tradBillions = '${lessThanOneThousand(billions)} $_billion ';
        break;
      default:
        tradBillions = '${lessThanOneThousand(billions)} $_billion ';
    }
    return tradBillions;
  }

  ///get Millions
  static String getMillions(int millions) {
    String tradMillions;
    switch (millions) {
      case 0:
        tradMillions = '';
        break;
      case 1:
        tradMillions = '${lessThanOneThousand(millions)} $_million ';
        break;
      default:
        tradMillions = '${lessThanOneThousand(millions)} $_million ';
    }
    return tradMillions;
  }

  ///get Thousands
  static String getThousands(int hundredThousands) {
    String tradHundredThousands;
    switch (hundredThousands) {
      case 0:
        tradHundredThousands = '';
        break;
      case 1:
        tradHundredThousands =
            '${lessThanOneThousand(hundredThousands)} $_thousand ';
        break;
      default:
        tradHundredThousands =
            '${lessThanOneThousand(hundredThousands)} $_thousand ';
    }

    return tradHundredThousands;
  }

  static String lessThanOneThousand(int number,
      [bool isLastThreeDigits = false]) {
    String soFar = '';

    if (number % 100 < 20) {
      soFar = _nums[number % 100];
      number = (number ~/ 100).toInt();
    } else {
      final int numFirst = number;
      soFar = _nums[number % 10];
      number = (number ~/ 10).toInt();
      final String unionSeparator =
          ((number ~/ 10).toInt() != 0 && numFirst % 10 != 0) ||
                  (numFirst % 10 != 0 && numFirst < 100)
              ? " "
              : '';
      soFar = _tens[number % 10] + unionSeparator + soFar;
      number = (number ~/ 10).toInt();
    }
    if (number == 0) {
      return soFar;
    }
    return '${_nums[number]} $_hundred $soFar';
  }
}

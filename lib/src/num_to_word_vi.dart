class NumberToWordsVi {
  NumberToWordsVi._();

  static addSeperator({
    result = "",
    seperator = "",
  }) {
    final array = result.split(" ").reverse();
    final tram = array.findIndex((e) => e == "trăm");
    final nghin = array.findIndex((e) => e == "nghìn");
    final trieu = array.findIndex((e) => e == "triệu");
    final ty = array.findIndex((e) => e == "tỷ");

    if (ty != -1 && !!seperator) {
      array.splice(ty, 1, '${array[ty]}$seperator');
    }
    if (trieu != -1 && !!seperator) {
      array.splice(trieu, 1, '${array[trieu]}$seperator');
    }
    if (nghin != -1 && !!seperator && tram != -1) {
      array.splice(nghin, 1, '${array[nghin]}$seperator');
    }
    return array.reverse().join(" ");
  }

  static List<String> base = [
    "không",
    "một",
    "hai",
    "ba",
    "bốn",
    "năm",
    "sáu",
    "bảy",
    "tám",
    "chín",
  ];
  static List<String> baseTen = [
    "mười",
    "hai mươi",
    "ba mươi",
    "bốn mươi",
    "năm mươi",
    "sáu mươi",
    "bảy mươi",
    "tám mươi",
    "chín mươi",
  ];
  static List<String> baseHundred = [
    "không trăm",
    "một trăm",
    "hai trăm",
    "ba trăm",
    "bốn trăm",
    "năm trăm",
    "sáu trăm",
    "bảy trăm",
    "tám trăm",
    "chín trăm",
  ];

  static String _getTen(number) {
    final array = '$number'.split("");
    final first = int.tryParse(array[0]) ?? 0;
    final second = int.tryParse(array[1]) ?? 0;
    if (second == 0) {
      return baseTen[first - 1];
    }
    if (second == 5) {
      return '${baseTen[first - 1]} lăm';
    }
    if (second == 4) {
      return '${baseTen[first - 1]} tư';
    }
    if (second == 1) {
      if (first == 1) {
        return '${baseTen[first - 1]} một';
      }
      return '${baseTen[first - 1]} mốt';
    }

    return '${baseTen[first - 1]} ${base[second]}';
  }

  static String _getHundred(number) {
    final array = '$number'.split("");
    final first = int.tryParse(array[0]) ?? 0;
    final second = int.tryParse(array[1]) ?? 0;
    final third = int.tryParse(array[2]) ?? 0;
    if (second > 0) {
      return '${baseHundred[first]} ${_getTen('$second$third')}';
    }
    if (third == 0) {
      return baseHundred[first];
    }
    if (third == 4) {
      return '${baseHundred[first]} linh tư';
    }
    return '${baseHundred[first]} linh ${base[third]}';
  }

  static String _getThousand(number) {
    final reverseArray = '$number'.split("").reversed.toList();

    final afterNumber = reverseArray.sublist(0, 3).reversed.toList().join("");

    final beforeNumber = int.tryParse(reverseArray
            .sublist(3, reverseArray.length)
            .reversed
            .toList()
            .join("")) ??
        0;

    final beforeLength = '$beforeNumber'.length;

    var afterText = "";

    if ((int.tryParse(afterNumber) ?? 0) >= 1) {
      afterText = _getHundred(afterNumber);
    }

    if (beforeLength == 1) {
      return '${base[beforeNumber]} nghìn $afterText';
    }

    if (beforeLength == 2) {
      return '${_getTen(beforeNumber)} nghìn $afterText';
    }
    return '${_getHundred(beforeNumber)} nghìn $afterText';
  }

  static String _getMillion(number) {
    final reverseArray = '$number'.split("").reversed.toList();
    final afterNumber = reverseArray.sublist(0, 6).reversed.toList().join("");
    final beforeNumber = int.tryParse(reverseArray
        .sublist(6, reverseArray.length)
        .reversed
        .toList()
        .join(""));
    final beforeLength = '$beforeNumber'.length;

    var afterText = "";
    if ((int.tryParse(afterNumber) ?? 0) > 999) {
      afterText = _getThousand(afterNumber);
    } else if ((int.tryParse(afterNumber) ?? 0) <= 999 &&
        (int.tryParse(afterNumber) ?? 0) >= 1) {
      afterText = _getHundred(
          afterNumber.split("").sublist(3, 6).reversed.toList().join(""));
    }

    if (beforeLength == 1) {
      return '${base[beforeNumber ?? 0]} triệu $afterText';
    }

    if (beforeLength == 2) {
      return '${_getTen(beforeNumber)} triệu $afterText';
    }

    return '${_getHundred(beforeNumber)} triệu $afterText';
  }

  static String _getBillion(number) {
    final reverseArray = '$number'.split("").reversed.toList();

    final afterNumber = reverseArray.sublist(0, 9).reversed.toList().join("");

    final beforeNumber = int.tryParse(reverseArray
        .sublist(9, reverseArray.length)
        .reversed
        .toList()
        .join(""));

    var afterText = "";
    if ((int.tryParse(afterNumber) ?? 0) > 999999 &&
        (int.tryParse(afterNumber) ?? 0) <= 999999999) {
      afterText = _getMillion(afterNumber);
    } else if ((int.tryParse(afterNumber) ?? 0) <= 999999 &&
        (int.tryParse(afterNumber) ?? 0) > 999) {
      afterText = _getThousand(afterNumber.split("").sublist(3, 9).join(""));
    } else if ((int.tryParse(afterNumber) ?? 0) <= 999 &&
        (int.tryParse(afterNumber) ?? 0) >= 1) {
      afterText = _getHundred(afterNumber.split("").sublist(6, 9).join(""));
    }

    final beforeLength = '$beforeNumber'.length;
    if (beforeLength == 1) {
      return '${base[beforeNumber ?? 0]} tỷ $afterText';
    }

    if (beforeLength == 2) {
      return '${_getTen(beforeNumber)} tỷ $afterText';
    }

    if (beforeLength == 3) {
      return '${_getHundred(beforeNumber)} tỷ $afterText';
    }

    if (beforeLength > 3 && beforeLength <= 6) {
      return '${_getThousand(beforeNumber)} tỷ $afterText';
    }

    if (beforeLength > 6 && beforeLength <= 9) {
      return '${_getMillion(beforeNumber)} tỷ $afterText';
    }
    return "";
  }

  static vnToTextVI({number, seperator = ''}) {
    try {
      final length = '$number'.length;

      var result;

      if (length == 1) {
        result = base[number];
      }
      if (length == 2) {
        result = _getTen(number);
      }
      if (length == 3) {
        result = _getHundred(number);
      }
      if (length > 3 && length <= 6) {
        result = _getThousand(number);
      }
      if (length > 6 && length <= 9) {
        result = _getMillion(number);
      }
      if (length > 9) {
        result = _getBillion(number);
      }
      if (seperator.toString().isNotEmpty) {
        return addSeperator(result: result, seperator: seperator);
      }
      var firstUpperLetter = '';
      if (result.endsWith(" ")) {
        firstUpperLetter = result;
      } else {
        firstUpperLetter = result;
      }
      return firstUpperLetter.substring(0, 1).toUpperCase() +
          firstUpperLetter.substring(1);
    } catch (error) {
      return "";
    }
  }
}

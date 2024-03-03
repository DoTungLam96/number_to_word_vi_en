// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:num_to_word_en_vi/src/num_to_word_en.dart';
import 'package:num_to_word_en_vi/src/num_to_word_vi.dart';

class NumberToWord {
  final String? language;
  final int number;

  ///parameter [language] : [vi] or [en]
  ///
  ///vi: Vietnamese to word
  ///
  ///en: English to word
  ///
  ///default: vi
  NumberToWord({
    this.language = 'vi',
    required this.number,
  });
  String textToWord() {
    switch (language) {
      case 'vi':
        return NumberToWordsVi.vnToTextVI(number: number);
      case 'en':
        return NumberToWordEn.enToText(number: number);

      default:
        return NumberToWordsVi.vnToTextVI(number: number);
    }
  }
}

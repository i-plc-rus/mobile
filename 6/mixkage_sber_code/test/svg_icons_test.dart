import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mixkage_sber_code/assets/resources.dart';

void main() {
  test('svg_icons assets test', () {
    expect(File(SvgIcons.githubIcon).existsSync(), isTrue);
  });
}

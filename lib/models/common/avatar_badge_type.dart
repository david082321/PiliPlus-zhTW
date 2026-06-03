import 'package:flutter/material.dart';

enum BadgeType {
  none(),
  vip('大會員'),
  person('認證個人', Color(0xFFFFCC00)),
  institution('認證機構', Colors.lightBlueAccent),
  ;

  final String? desc;
  final Color? color;
  const BadgeType([this.desc, this.color]);
}

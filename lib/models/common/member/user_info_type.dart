import 'package:flutter/material.dart' show Alignment;

enum UserInfoType {
  fan('粉絲', .centerLeft),
  follow('關注', .center),
  like('獲讚', .centerRight),
  ;

  final String title;
  final Alignment alignment;

  const UserInfoType(this.title, this.alignment);
}

enum DmBlockType {
  keyword('關鍵字'),
  regex('正則'),
  uid('使用者'),
  ;

  final String label;
  const DmBlockType(this.label);
}

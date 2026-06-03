enum BtmProgressBehavior {
  alwaysShow('始終展示'),
  alwaysHide('始終隱藏'),
  onlyShowFullScreen('僅全螢幕時展示'),
  onlyHideFullScreen('僅全螢幕時隱藏'),
  ;

  final String desc;
  const BtmProgressBehavior(this.desc);
}

enum SettingType {
  privacySetting('隱私設定'),
  recommendSetting('推薦流設定'),
  videoSetting('影音設定'),
  playSetting('播放器設定'),
  styleSetting('外觀設定'),
  extraSetting('其它設定'),
  webdavSetting('WebDAV 設定'),
  about('關於'),
  ;

  final String title;
  const SettingType(this.title);
}

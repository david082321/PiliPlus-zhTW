// ignore_for_file: constant_identifier_names
enum SearchType {
  // all('綜合'),
  // 影片：video
  video('影片'),
  // 番劇：media_bangumi,
  media_bangumi('番劇'),
  // 影視：media_ft
  media_ft('影視'),
  // 直播間及主播：live
  // live,
  // 直播間：live_room
  live_room('直播間'),
  // 主播：live_user
  // live_user,
  // 話題：topic
  // topic,
  // 使用者：bili_user
  bili_user('使用者'),
  // 專欄：article
  article('專欄'),
  ;
  // 相簿：photo
  // photo

  final String label;
  const SearchType(this.label);
}

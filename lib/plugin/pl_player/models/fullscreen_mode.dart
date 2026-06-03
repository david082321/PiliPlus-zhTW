const double kScreenRatio = 1.2;

// 全螢幕模式
enum FullScreenMode {
  // 根據內容自適應
  auto('按影片方向（預設）'),
  // 不改變當前方向
  none('不改變當前方向'),
  // 始終豎屏
  vertical('強制豎屏'),
  // 始終橫屏
  horizontal('強制橫屏'),
  // 螢幕長寬比 < kScreenRatio 或為豎屏影片時豎屏，否則橫屏
  ratio('螢幕長寬比<$kScreenRatio或為豎屏影片時豎屏，否則橫屏'),
  // 強制重力轉屏（僅安卓）
  gravity('忽略系統方向鎖定，強制按重力轉屏（僅安卓）'),
  ;

  final String desc;
  const FullScreenMode(this.desc);
}

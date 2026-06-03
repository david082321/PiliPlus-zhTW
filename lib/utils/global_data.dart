import 'package:PiliPlus/utils/storage_pref.dart';

class GlobalData {
  int imgQuality = Pref.picQuality;

  num? coins;

  void afterCoin(num coin) {
    if (coins != null) {
      coins = coins! - coin;
    }
  }

  Set<int> blackMids = Pref.blackMids;

  bool dynamicsWaterfallFlow = Pref.dynamicsWaterfallFlow;

  bool showMedal = Pref.showMedal;

  // 私有建構子
  GlobalData._();

  // 單例實例
  static final GlobalData _instance = GlobalData._();

  // 取得全域實例
  factory GlobalData() => _instance;
}

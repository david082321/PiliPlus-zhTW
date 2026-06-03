import 'dart:io' show Platform;

import 'package:PiliPlus/common/widgets/custom_icon.dart';
import 'package:PiliPlus/models/common/super_chat_type.dart';
import 'package:PiliPlus/models/common/video/subtitle_pref_type.dart';
import 'package:PiliPlus/pages/main/controller.dart';
import 'package:PiliPlus/pages/setting/models/model.dart';
import 'package:PiliPlus/pages/setting/pages/fullscreen_sc_size.dart';
import 'package:PiliPlus/pages/setting/widgets/select_dialog.dart';
import 'package:PiliPlus/pages/setting/widgets/slider_dialog.dart';
import 'package:PiliPlus/plugin/pl_player/models/bottom_progress_behavior.dart';
import 'package:PiliPlus/plugin/pl_player/models/fullscreen_mode.dart';
import 'package:PiliPlus/plugin/pl_player/models/play_repeat.dart';
import 'package:PiliPlus/services/service_locator.dart';
import 'package:PiliPlus/utils/platform_utils.dart';
import 'package:PiliPlus/utils/storage.dart';
import 'package:PiliPlus/utils/storage_key.dart';
import 'package:PiliPlus/utils/storage_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

List<SettingsModel> get playSettings => [
  const SwitchModel(
    title: '彈幕開關',
    subtitle: '是否展示彈幕',
    leading: Icon(CustomIcons.dm_settings),
    setKey: SettingBoxKey.enableShowDanmaku,
    defaultVal: true,
  ),
  if (PlatformUtils.isMobile)
    const SwitchModel(
      title: '啟用點擊彈幕',
      subtitle: '點擊彈幕懸停，支援按讚、複製、檢舉操作',
      leading: Icon(Icons.touch_app_outlined),
      setKey: SettingBoxKey.enableTapDm,
      defaultVal: true,
    ),
  NormalModel(
    onTap: (context, setState) => Get.toNamed('/playSpeedSet'),
    leading: const Icon(Icons.speed_outlined),
    title: '倍速設定',
    subtitle: '設定影片播放速度',
  ),
  if (Platform.isAndroid)
    NormalModel(
      onTap: _showAngleDegreesDialog,
      leading: const Icon(MdiIcons.angleAcute),
      title: '傾斜角度閾值',
      getSubtitle: () => '目前:「${Pref.angleDegrees}°」',
    ),
  const SwitchModel(
    title: '自動播放',
    subtitle: '進入詳情頁自動播放',
    leading: Icon(Icons.motion_photos_auto_outlined),
    setKey: SettingBoxKey.autoPlayEnable,
    defaultVal: false,
  ),
  const SwitchModel(
    title: '全螢幕顯示鎖定按鈕',
    leading: Icon(Icons.lock_outline),
    setKey: SettingBoxKey.showFsLockBtn,
    defaultVal: true,
  ),
  const SwitchModel(
    title: '全螢幕顯示截圖按鈕',
    leading: Icon(Icons.photo_camera_outlined),
    setKey: SettingBoxKey.showFsScreenshotBtn,
    defaultVal: true,
  ),
  SwitchModel(
    title: '全螢幕顯示電池電量',
    leading: const Icon(Icons.battery_3_bar),
    setKey: SettingBoxKey.showBatteryLevel,
    defaultVal: PlatformUtils.isMobile,
  ),
  const SwitchModel(
    title: '雙擊快退/快進',
    subtitle: '左側雙擊快退/右側雙擊快進，關閉則雙擊均為暫停/播放',
    leading: Icon(Icons.touch_app_outlined),
    setKey: SettingBoxKey.enableQuickDouble,
    defaultVal: true,
  ),
  const SwitchModel(
    title: '左右側滑動調節亮度/音量',
    leading: Icon(MdiIcons.tuneVerticalVariant),
    setKey: SettingBoxKey.enableSlideVolumeBrightness,
    defaultVal: true,
  ),
  if (Platform.isAndroid)
    const SwitchModel(
      title: '調節系統亮度',
      leading: Icon(Icons.brightness_6_outlined),
      setKey: SettingBoxKey.setSystemBrightness,
      defaultVal: false,
    ),
  const SwitchModel(
    title: '中間滑動進入/退出全螢幕',
    leading: Icon(MdiIcons.panVertical),
    setKey: SettingBoxKey.enableSlideFS,
    defaultVal: true,
  ),
  getVideoFilterSelectModel(
    title: '雙擊快進/快退時長',
    suffix: 's',
    key: SettingBoxKey.fastForBackwardDuration,
    values: [5, 10, 15],
    defaultValue: 10,
    isFilter: false,
  ),
  const SwitchModel(
    title: '滑動快進/快退使用相對時長',
    leading: Icon(Icons.swap_horiz_outlined),
    setKey: SettingBoxKey.useRelativeSlide,
    defaultVal: false,
  ),
  getVideoFilterSelectModel(
    title: '滑動快進/快退時長',
    subtitle: '從播放器一端滑到另一端的快進/快退時長',
    suffix: Pref.useRelativeSlide ? '%' : 's',
    key: SettingBoxKey.sliderDuration,
    values: [25, 50, 90, 100],
    defaultValue: 90,
    isFilter: false,
  ),
  NormalModel(
    title: '自動啟用字幕',
    leading: const Icon(Icons.closed_caption_outlined),
    getSubtitle: () => '目前選擇偏好：${Pref.subtitlePreferenceV2.desc}',
    onTap: _showSubtitleDialog,
  ),
  if (PlatformUtils.isDesktop)
    SwitchModel(
      title: '最小化時暫停/還原時播放',
      leading: const Icon(Icons.pause_circle_outline),
      setKey: SettingBoxKey.pauseOnMinimize,
      defaultVal: false,
      onChanged: (value) {
        try {
          Get.find<MainController>().pauseOnMinimize = value;
        } catch (_) {}
      },
    ),
  const SwitchModel(
    title: '啟用鍵盤控制',
    leading: Icon(Icons.keyboard_alt_outlined),
    setKey: SettingBoxKey.keyboardControl,
    defaultVal: true,
  ),
  NormalModel(
    title: 'SuperChat (醒目留言) 顯示類型',
    leading: const Icon(Icons.live_tv),
    getSubtitle: () => '目前:「${Pref.superChatType.title}」',
    onTap: _showSuperChatDialog,
  ),
  NormalModel(
    title: '全螢幕 SC 大小',
    subtitle: 'SuperChat (醒目留言) 大小設定',
    leading: const Icon(Icons.open_in_full),
    onTap: (_, _) => Get.to(const FullScreenScSize()),
  ),
  const SwitchModel(
    title: '豎屏擴大展示',
    subtitle: '小屏豎屏視頻寬高比由16:9擴大至1:1（不支援收起）；橫屏適配時，擴大至9:16',
    leading: Icon(Icons.expand_outlined),
    setKey: SettingBoxKey.enableVerticalExpand,
    defaultVal: false,
  ),
  const SwitchModel(
    title: '自動全螢幕',
    subtitle: '影片開始播放時進入全螢幕',
    leading: Icon(Icons.fullscreen_outlined),
    setKey: SettingBoxKey.enableAutoEnter,
    defaultVal: false,
  ),
  const SwitchModel(
    title: '自動退出全螢幕',
    subtitle: '影片結束播放時退出全螢幕',
    leading: Icon(Icons.fullscreen_exit_outlined),
    setKey: SettingBoxKey.enableAutoExit,
    defaultVal: true,
  ),
  const SwitchModel(
    title: '延長播放控制項顯示時間',
    subtitle: '開啟後延長至30秒，便於螢幕閱讀器滑動切換控制項焦點',
    leading: Icon(Icons.timer_outlined),
    setKey: SettingBoxKey.enableLongShowControl,
    defaultVal: false,
  ),
  if (PlatformUtils.isMobile)
    const SwitchModel(
      title: '後台播放',
      subtitle: '進入後台時繼續播放',
      leading: Icon(Icons.motion_photos_pause_outlined),
      setKey: SettingBoxKey.continuePlayInBackground,
      defaultVal: false,
    ),
  if (Platform.isAndroid) ...[
    SwitchModel(
      title: '後台畫中畫',
      subtitle: '進入後台時以小窗形式（PiP）播放',
      leading: const Icon(Icons.picture_in_picture_outlined),
      setKey: SettingBoxKey.autoPiP,
      defaultVal: false,
      onChanged: (val) {
        if (val && !videoPlayerServiceHandler!.enableBackgroundPlay) {
          SmartDialog.showToast('建議開啟後台音訊服務');
        }
      },
    ),
    const SwitchModel(
      title: '畫中畫不載入彈幕',
      subtitle: '當彈幕開關開啟時，小窗封鎖彈幕以獲得較好的體驗',
      leading: Icon(CustomIcons.dm_off),
      setKey: SettingBoxKey.pipNoDanmaku,
      defaultVal: false,
    ),
  ],
  const SwitchModel(
    title: '全螢幕手勢反向',
    subtitle: '預設播放器中部向上滑動進入全螢幕，向下退出\n開啟後向下全螢幕，向上退出',
    leading: Icon(Icons.swap_vert),
    setKey: SettingBoxKey.fullScreenGestureReverse,
    defaultVal: false,
  ),
  const SwitchModel(
    title: '全螢幕展示按讚/投幣/收藏等操作按鈕',
    leading: Icon(MdiIcons.dotsHorizontalCircleOutline),
    setKey: SettingBoxKey.showFSActionItem,
    defaultVal: true,
  ),
  const SwitchModel(
    title: '觀看人數',
    subtitle: '展示同時在看人數',
    leading: Icon(Icons.people_outlined),
    setKey: SettingBoxKey.enableOnlineTotal,
    defaultVal: false,
  ),
  NormalModel(
    title: '預設全螢幕方向',
    leading: const Icon(Icons.open_with_outlined),
    getSubtitle: () => '目前全螢幕方向：${Pref.fullScreenMode.desc}',
    onTap: _showFullScreenModeDialog,
  ),
  NormalModel(
    title: '底部進度條展示',
    leading: const Icon(Icons.border_bottom_outlined),
    getSubtitle: () => '目前展示方式：${Pref.btmProgressBehavior.desc}',
    onTap: _showProgressBehaviorDialog,
  ),
  if (PlatformUtils.isMobile)
    SwitchModel(
      title: '後台音訊服務',
      subtitle: '避免畫中畫沒有播放暫停功能',
      leading: const Icon(Icons.volume_up_outlined),
      setKey: SettingBoxKey.enableBackgroundPlay,
      defaultVal: true,
      onChanged: (value) =>
          videoPlayerServiceHandler!.enableBackgroundPlay = value,
    ),
  PopupModel(
    title: '播放順序',
    leading: const Icon(Icons.repeat),
    value: () => Pref.playRepeat,
    items: PlayRepeat.values,
    onSelected: (value, setState) => GStorage.video
        .put(VideoBoxKey.playRepeat, value.index)
        .whenComplete(setState),
  ),
  const SwitchModel(
    title: '播放器設定僅對目前生效',
    subtitle: '彈幕、字幕及部分設定中沒有的設定除外',
    leading: Icon(Icons.video_settings_outlined),
    setKey: SettingBoxKey.tempPlayerConf,
    defaultVal: false,
  ),
];

Future<void> _showSubtitleDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<SubtitlePrefType>(
    context: context,
    builder: (context) => SelectDialog<SubtitlePrefType>(
      title: '字幕選擇偏好',
      value: Pref.subtitlePreferenceV2,
      values: SubtitlePrefType.values.map((e) => (e, e.desc)).toList(),
    ),
  );
  if (res != null) {
    await GStorage.setting.put(
      SettingBoxKey.subtitlePreferenceV2,
      res.index,
    );
    setState();
  }
}

Future<void> _showSuperChatDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<SuperChatType>(
    context: context,
    builder: (context) => SelectDialog<SuperChatType>(
      title: 'SuperChat (醒目留言) 顯示類型',
      value: Pref.superChatType,
      values: SuperChatType.values.map((e) => (e, e.title)).toList(),
    ),
  );
  if (res != null) {
    await GStorage.setting.put(SettingBoxKey.superChatType, res.index);
    setState();
  }
}

Future<void> _showFullScreenModeDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<FullScreenMode>(
    context: context,
    builder: (context) => SelectDialog<FullScreenMode>(
      title: '預設全螢幕方向',
      value: Pref.fullScreenMode,
      values: FullScreenMode.values.map((e) => (e, e.desc)).toList(),
    ),
  );
  if (res != null) {
    await GStorage.setting.put(SettingBoxKey.fullScreenMode, res.index);
    setState();
  }
}

Future<void> _showProgressBehaviorDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<BtmProgressBehavior>(
    context: context,
    builder: (context) => SelectDialog<BtmProgressBehavior>(
      title: '底部進度條展示',
      value: Pref.btmProgressBehavior,
      values: BtmProgressBehavior.values.map((e) => (e, e.desc)).toList(),
    ),
  );
  if (res != null) {
    await GStorage.setting.put(
      SettingBoxKey.btmProgressBehavior,
      res.index,
    );
    setState();
  }
}

Future<void> _showAngleDegreesDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<double>(
    context: context,
    builder: (context) => SliderDialog(
      title: '傾斜角度閾值',
      min: 10.0,
      max: 90.0,
      divisions: 90,
      precise: 0,
      value: Pref.angleDegrees.toDouble(),
      suffix: '°',
    ),
  );
  if (res != null) {
    await GStorage.setting.put(SettingBoxKey.angleDegrees, res.toInt());
    setState();
  }
}

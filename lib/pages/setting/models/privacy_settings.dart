import 'package:PiliPlus/models/common/account_type.dart';
import 'package:PiliPlus/pages/mine/controller.dart';
import 'package:PiliPlus/pages/setting/models/model.dart';
import 'package:PiliPlus/utils/accounts.dart';
import 'package:PiliPlus/utils/accounts/api_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

List<SettingsModel> get privacySettings => [
  NormalModel(
    onTap: (context, setState) {
      if (!Accounts.main.isLogin) {
        SmartDialog.showToast('登入後查看');
        return;
      }
      Get.toNamed('/blackListPage');
    },
    title: '黑名單管理',
    subtitle: '已封鎖使用者',
    leading: const Icon(Icons.block),
  ),
  NormalModel(
    onTap: (context, setState) {
      MineController.onChangeAnonymity();
      setState();
    },
    leading: const Icon(Icons.privacy_tip_outlined),
    getTitle: () => MineController.anonymity.value ? '退出無痕模式' : '進入無痕模式',
    getSubtitle: () => MineController.anonymity.value
        ? '已進入無痕模式，搜尋、觀看影片/直播不攜帶Cookie與CSRF，其餘操作不受影響'
        : '未開啟無痕模式，將使用帳戶資訊提供完整服務',
  ),
  NormalModel(
    onTap: (context, setState) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('帳號模式詳情'),
          content: SingleChildScrollView(
            child: _getAccountDetail(context),
          ),
          actions: [
            TextButton(
              onPressed: Get.back,
              child: const Text('確認'),
            ),
          ],
        ),
      );
    },
    leading: const Icon(Icons.flag_outlined),
    title: '了解帳號模式',
    subtitle: '查看各個帳號模式作用的API列表',
  ),
];

Widget _getAccountDetail(BuildContext context) {
  final slivers = <Widget>[];
  final theme = TextTheme.of(context);
  for (final i in AccountType.values) {
    final url = ApiType.apiTypeSet[i];
    if (url == null) continue;

    slivers
      ..add(Center(child: Text(i.title, style: theme.titleMedium)))
      ..add(SelectableText(url.join('\n')));
  }
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 8,
    children: slivers,
  );
}

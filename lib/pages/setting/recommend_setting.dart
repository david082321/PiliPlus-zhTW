import 'package:PiliPlus/common/widgets/flutter/list_tile.dart';
import 'package:PiliPlus/pages/setting/models/recommend_settings.dart';
import 'package:flutter/material.dart' hide ListTile;

class RecommendSetting extends StatefulWidget {
  const RecommendSetting({super.key, this.showAppBar = true});

  final bool showAppBar;

  @override
  State<RecommendSetting> createState() => _RecommendSettingState();
}

class _RecommendSettingState extends State<RecommendSetting> {
  final list = recommendSettings;

  @override
  Widget build(BuildContext context) {
    final showAppBar = widget.showAppBar;
    final padding = MediaQuery.viewPaddingOf(context);
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: widget.showAppBar ? AppBar(title: const Text('推薦流設定')) : null,
      body: ListView(
        padding: EdgeInsets.only(
          left: showAppBar ? padding.left : 0,
          right: showAppBar ? padding.right : 0,
          bottom: padding.bottom + 100,
        ),
        children: [
          ...list.take(4).map((item) => item.widget),
          const Divider(height: 1),
          ...list.skip(4).map((item) => item.widget),
          ListTile(
            dense: true,
            subtitle: Text(
              '¹ 由於介面未提供關注資訊，無法豁免相關影片中的已關注Up。\n\n'
              '* 其它（如熱門影片、手動搜尋、連結跳轉等）均不受過濾器影響。\n'
              '* 設定較嚴苛的條件可導致推薦項數銳減或多次請求，請酌情選擇。\n'
              '* 後續可能會增加更多過濾條件，敬請期待。',
              style: theme.textTheme.labelSmall!.copyWith(
                color: theme.colorScheme.outline.withValues(alpha: 0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

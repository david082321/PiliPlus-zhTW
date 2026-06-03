import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:PiliPlus/common/widgets/dialog/dialog.dart';
import 'package:PiliPlus/grpc/bilibili/im/type.pbenum.dart';
import 'package:PiliPlus/grpc/bilibili/main/community/reply/v1.pb.dart'
    show ReplyInfo;
import 'package:PiliPlus/grpc/im.dart';
import 'package:PiliPlus/http/dynamics.dart';
import 'package:PiliPlus/http/fav.dart';
import 'package:PiliPlus/http/loading_state.dart';
import 'package:PiliPlus/http/member.dart';
import 'package:PiliPlus/http/user.dart';
import 'package:PiliPlus/http/validate.dart';
import 'package:PiliPlus/http/video.dart';
import 'package:PiliPlus/models/dynamics/result.dart';
import 'package:PiliPlus/models/login/model.dart';
import 'package:PiliPlus/models_new/fav/fav_detail/media.dart';
import 'package:PiliPlus/models_new/later/list.dart';
import 'package:PiliPlus/models_new/relation/data.dart';
import 'package:PiliPlus/pages/common/multi_select/base.dart';
import 'package:PiliPlus/pages/dynamics_tab/controller.dart';
import 'package:PiliPlus/pages/fav_detail/controller.dart'
    show BaseFavController;
import 'package:PiliPlus/pages/group_panel/view.dart';
import 'package:PiliPlus/pages/login/geetest/geetest_webview_dialog.dart';
import 'package:PiliPlus/utils/accounts.dart';
import 'package:PiliPlus/utils/extension/context_ext.dart';
import 'package:PiliPlus/utils/extension/size_ext.dart';
import 'package:PiliPlus/utils/extension/string_ext.dart';
import 'package:PiliPlus/utils/extension/theme_ext.dart';
import 'package:PiliPlus/utils/feed_back.dart';
import 'package:PiliPlus/utils/platform_utils.dart';
import 'package:PiliPlus/utils/storage.dart';
import 'package:PiliPlus/utils/storage_key.dart';
import 'package:PiliPlus/utils/storage_pref.dart';
import 'package:PiliPlus/utils/theme_utils.dart';
import 'package:PiliPlus/utils/utils.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show LengthLimitingTextInputFormatter;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:gt3_flutter_plugin/gt3_flutter_plugin.dart';

abstract final class RequestUtils {
  static Future<void> syncHistoryStatus() async {
    final account = Accounts.history;
    if (!account.isLogin) {
      return;
    }
    final res = await UserHttp.historyStatus(account: account);
    if (res case Success(:final response)) {
      GStorage.localCache.put(LocalCacheKey.historyPause, response);
    }
  }

  // 1：小影片（已棄用）
  // 2：相簿
  // 3：純文字
  // 4：直播（此類型不常用，見分享其他內容消息）
  // 5：影片
  // 6：專欄
  // 7：番劇（id 為 season_id）
  // 8：音樂
  // 9：國產動畫（id 為 AV 號）
  // 10：圖片
  // 11：動態
  // 16：番劇（id 為 epid）
  // 17：番劇
  // https://github.com/SocialSisterYi/bilibili-API-collect/tree/master/docs/message/private_msg_content.md
  static Future<bool> pmShare({
    required int receiverId,
    required Map content,
    String? message,
  }) async {
    final ownerMid = Accounts.main.mid;
    final contentRes = await ImGrpc.sendMsg(
      senderUid: ownerMid,
      receiverId: receiverId,
      content: jsonEncode(content),
      msgType: content['source'] is String
          ? MsgType.EN_MSG_TYPE_COMMON_SHARE_CARD
          : MsgType.EN_MSG_TYPE_SHARE_V2,
    );

    if (contentRes.isSuccess) {
      if (message?.isNotEmpty == true) {
        final msgRes = await ImGrpc.sendMsg(
          senderUid: ownerMid,
          receiverId: receiverId,
          content: jsonEncode({"content": message}),
          msgType: MsgType.EN_MSG_TYPE_TEXT,
        );
        return msgRes.isSuccess;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  static Future<void> createFavTag(
    BuildContext context,
    ValueChanged<({int tagid, String tagName})> onSuccess,
  ) async {
    String tagName = '';
    final onCreate = await showConfirmDialog(
      context: context,
      title: const Text('建立分組'),
      content: TextFormField(
        autofocus: true,
        initialValue: tagName,
        onChanged: (value) => tagName = value,
        inputFormatters: [
          LengthLimitingTextInputFormatter(16),
        ],
        decoration: const InputDecoration(border: OutlineInputBorder()),
      ),
    );
    if (onCreate) {
      final res = await MemberHttp.createFollowTag(tagName);
      if (res case Success(:final response)) {
        onSuccess((tagid: response, tagName: tagName));
        SmartDialog.showToast('建立成功');
      } else {
        res.toast();
      }
    }
  }

  static Future<void> actionRelationMod({
    required BuildContext context,
    required dynamic mid,
    required bool isFollow,
    required ValueChanged<int>? afterMod,
    RelationData? followStatus,
  }) async {
    if (mid == null) {
      return;
    }
    feedBack();
    if (!isFollow) {
      final res = await VideoHttp.relationMod(
        mid: mid,
        act: 1,
        reSrc: 11,
      );
      if (res.isSuccess) {
        SmartDialog.showToast('關注成功');
        afterMod?.call(2);
      } else {
        res.toast();
      }
    } else {
      if (followStatus?.tag == null) {
        final res = await UserHttp.userRelation(mid);
        if (res case Success(:final response)) {
          followStatus = response;
        } else {
          res.toast();
          return;
        }
      }

      if (context.mounted) {
        bool isSpecialFollowed = followStatus!.special == 1;
        String text = isSpecialFollowed ? '移除特別關注' : '加入特別關注';
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            clipBehavior: Clip.hardEdge,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  dense: true,
                  onTap: () async {
                    Get.back();
                    final res = await MemberHttp.specialAction(
                      fid: mid,
                      isAdd: !isSpecialFollowed,
                    );
                    if (res.isSuccess) {
                      SmartDialog.showToast('$text成功');
                      afterMod?.call(isSpecialFollowed ? 2 : -10);
                    } else {
                      res.toast();
                    }
                  },
                  title: Text(
                    text,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                ListTile(
                  dense: true,
                  onTap: () async {
                    Get.back();
                    final result = await showModalBottomSheet<Set<int>>(
                      context: context,
                      useSafeArea: true,
                      isScrollControlled: true,
                      constraints: BoxConstraints(
                        maxWidth: min(640, context.mediaQueryShortestSide),
                      ),
                      builder: (BuildContext context) {
                        final maxChildSize =
                            PlatformUtils.isMobile &&
                                !context.mediaQuerySize.isPortrait
                            ? 1.0
                            : 0.7;
                        return DraggableScrollableSheet(
                          minChildSize: 0,
                          maxChildSize: 1,
                          snap: true,
                          expand: false,
                          snapSizes: [maxChildSize],
                          initialChildSize: maxChildSize,
                          builder: (context, scrollController) {
                            return GroupPanel(
                              mid: mid,
                              tags: followStatus!.tag,
                              scrollController: scrollController,
                            );
                          },
                        );
                      },
                    );
                    if (result != null) {
                      followStatus!.tag = result.toList();
                      afterMod?.call(result.contains(-10) ? -10 : 2);
                    }
                  },
                  title: const Text(
                    '設定分組',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                ListTile(
                  dense: true,
                  onTap: () async {
                    Get.back();
                    final res = await VideoHttp.relationMod(
                      mid: mid,
                      act: 2,
                      reSrc: 11,
                    );
                    if (res.isSuccess) {
                      SmartDialog.showToast('取消關注成功');
                      afterMod?.call(0);
                    } else {
                      res.toast();
                    }
                  },
                  title: const Text(
                    '取消關注',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  static ReplyInfo replyCast(Map res) {
    Map? emote = res['content']['emote'];
    emote?.forEach((key, value) {
      value['size'] = value['meta']['size'];
    });
    return ReplyInfo.create()..mergeFromProto3Json(
      res
        ..['content'].remove('members')
        ..['id'] = res['rpid']
        ..['member']['name'] = res['member']['uname']
        ..['member']['face'] = res['member']['avatar']
        ..['member']['level'] = res['member']['level_info']['current_level']
        ..['member']['vipStatus'] = res['member']['vip']['vipStatus']
        ..['member']['vipType'] = res['member']['vip']['vipType']
        ..['member']['officialVerifyType'] =
            res['member']['official_verify']['type']
        ..['content']['emotes'] = emote,
      ignoreUnknownFields: true,
    );
  }

  // static Future<dynamic> getWwebid(mid) async {
  //   try {
  //     final response = await Request().get(
  //       '${HttpString.spaceBaseUrl}/$mid/dynamic',
  //       options: Options(
  //         extra: {'account': AnonymousAccount()},
  //       ),
  //     );
  //     dom.Document document = html_parser.parse(response.data);
  //     dom.Element? scriptElement =
  //         document.querySelector('script#__RENDER_DATA__');
  //     return jsonDecode(
  //         Uri.decodeComponent(scriptElement?.text ?? ''))['access_id'];
  //   } catch (e) {
  //     if (kDebugMode) debugPrint('failed to get wwebid: $e');
  //     return null;
  //   }
  // }

  static Future<void> insertCreatedDyn(dynamic id) async {
    if (id != null) {
      try {
        await Future.delayed(const Duration(milliseconds: 450));
        final res = await DynamicsHttp.dynamicDetail(id: id);
        if (res case final Success<DynamicItemModel> e) {
          final ctr = Get.find<DynamicsTabController>(tag: 'all');
          if (ctr.loadingState.value case Success(:final response?)) {
            response.insert(0, e.response);
            ctr.loadingState.refresh();
            return;
          }
          ctr.loadingState.value = Success([e.response]);
        }
      } catch (e) {
        if (kDebugMode) debugPrint('create dyn $e');
      }
    }
  }

  static Future<void> checkCreatedDyn({
    dynamic id,
    String? dynText,
    bool isManual = false,
  }) async {
    if (isManual || Pref.enableCreateDynAntifraud) {
      try {
        if (id != null) {
          if (!isManual) {
            await Future.delayed(const Duration(seconds: 5));
          }
          final res = await DynamicsHttp.dynamicDetail(
            id: id,
            clearCookie: true,
          );
          final isSuccess = res.isSuccess;
          final theme = ThemeUtils.theme;
          final actions = [
            if (!isSuccess)
              TextButton(
                onPressed: () {
                  Get.back();
                  Utils.copyText('https://www.bilibili.com/opus/$id');
                  Get.toNamed(
                    '/webview',
                    parameters: {
                      'url':
                          'https://www.bilibili.com/h5/comment/appeal?${ThemeUtils.themeUrl(theme.isDark)}',
                    },
                  );
                },
                child: const Text('申訴'),
              ),
            if (!isManual)
              TextButton(
                onPressed: Get.back,
                child: Text(
                  '關閉',
                  style: TextStyle(color: theme.colorScheme.outline),
                ),
              ),
          ];
          showDialog(
            context: Get.context!,
            barrierDismissible: isManual,
            builder: (context) => AlertDialog(
              title: const Text('動態檢查結果'),
              content: SelectableText(
                '${isSuccess ? '無帳號狀態下找到了你的動態，動態正常！' : '你的動態被shadow ban（僅自己可見）！'}${dynText != null ? ' \n\n動態內容: $dynText' : ''}',
              ),
              actions: actions.isEmpty ? null : actions,
            ),
          );
        }
      } catch (e) {
        if (kDebugMode) debugPrint('check dyn error: $e');
      }
    }
  }

  // 動態按讚
  static Future<void> onLikeDynamic(
    DynamicItemModel item,
    bool uiStatus,
    VoidCallback onSuccess,
  ) async {
    feedBack();

    final like = item.modules.moduleStat?.like;
    final status = like?.status ?? false;

    if (status ^ uiStatus) {
      SmartDialog.showToast(status ? '點贊成功' : '取消讚');
      onSuccess();
      return;
    }

    final res = await DynamicsHttp.thumbDynamic(
      dynamicId: item.idStr!,
      up: status ? 2 : 1, // 1 已按讚 2 不喜歡 0 未操作
    );
    if (res.isSuccess) {
      SmartDialog.showToast(status ? '取消讚' : '點贊成功');
      like
        ?..count = (like.count ?? 0) + (status ? -1 : 1)
        ..status = !status;
      onSuccess();
    } else {
      res.toast();
    }
  }

  static void onCopyOrMove<T extends MultiSelectData>({
    required BuildContext context,
    required bool isCopy,
    required CommonMultiSelectMixin<T> ctr,
    required dynamic mediaId,
    required dynamic mid,
  }) {
    FavHttp.allFavFolders(mid).then((res) {
      if (!context.mounted) return;
      if (res case Success(:final response)) {
        final list = response.list;
        if (list == null || list.isEmpty) return;
        int? checkedId;
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('${isCopy ? '複製' : '移動'}到'),
              contentPadding: const EdgeInsets.only(top: 5),
              content: SingleChildScrollView(
                child: RadioGroup(
                  onChanged: (value) {
                    checkedId = value;
                    (context as Element).markNeedsBuild();
                  },
                  groupValue: checkedId,
                  child: Column(
                    children: list.map((item) {
                      return RadioListTile<int>(
                        dense: true,
                        title: Text(item.title),
                        value: item.id,
                      );
                    }).toList(),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: Get.back,
                  child: Text(
                    '取消',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (checkedId != null) {
                      final removeList = ctr.allChecked.toSet();
                      SmartDialog.showLoading();
                      FavHttp.copyOrMoveFav(
                        isCopy: isCopy,
                        isFav: ctr is BaseFavController,
                        srcMediaId: mediaId,
                        tarMediaId: checkedId,
                        resources: removeList
                            .map(
                              (e) => switch (e) {
                                LaterItemModel _ => e.aid,
                                FavDetailItemModel _ => '${e.id}:${e.type}',
                                _ => throw UnsupportedError(e.toString()),
                              },
                            )
                            .join(','),
                        mid: isCopy ? mid : null,
                      ).then((res) {
                        if (res.isSuccess) {
                          ctr.handleSelect(checked: false);
                          if (!isCopy) {
                            ctr.loadingState
                              ..value.data!.removeWhere(removeList.contains)
                              ..refresh();
                          }
                          SmartDialog.dismiss();
                          SmartDialog.showToast('${isCopy ? '複製' : '移動'}成功');
                          Get.back();
                        } else {
                          SmartDialog.dismiss();
                          res.toast();
                        }
                      });
                    }
                  },
                  child: const Text('確認'),
                ),
              ],
            );
          },
        );
      } else {
        res.toast();
      }
    });
  }

  static Future<void> validate(
    String vVoucher,
    ValueChanged<String> onSuccess,
  ) async {
    final res = await ValidateHttp.gaiaVgateRegister(vVoucher);
    if (!res.isSuccess) {
      res.toast();
      return;
    }

    final resData = res.data;
    if (resData == null) {
      SmartDialog.showToast("null data");
      return;
    }

    CaptchaDataModel captchaData = CaptchaDataModel();

    final geetest = resData['geetest'];
    String? gt = geetest?['gt'];
    String? challenge = geetest?['challenge'];
    captchaData.token = resData['token'];

    bool isGeeArgumentValid() {
      return gt?.isNotEmpty == true &&
          challenge?.isNotEmpty == true &&
          captchaData.token?.isNotEmpty == true;
    }

    if (!isGeeArgumentValid()) {
      SmartDialog.showToast("參數為空");
      return;
    }

    Future<void> gaiaVgateValidate() async {
      final res = await ValidateHttp.gaiaVgateValidate(
        challenge: captchaData.geetest?.challenge,
        seccode: captchaData.seccode,
        token: captchaData.token,
        validate: captchaData.validate,
      );
      if (res case Success(:final response?)) {
        if (response['is_valid'] == 1) {
          final griskId = response['grisk_id'];
          if (griskId is String) {
            onSuccess(griskId);
          }
        } else {
          SmartDialog.showToast('invalid');
        }
      } else {
        res.toast();
      }
    }

    if (PlatformUtils.isDesktop) {
      final json = await showDialog<Map<String, dynamic>>(
        context: Get.context!,
        builder: (context) => GeetestWebviewDialog(gt!, challenge!),
      );
      if (json != null) {
        captchaData
          ..validate = json['geetest_validate']
          ..seccode = json['geetest_seccode']
          ..geetest = GeetestData(
            challenge: json['geetest_challenge'],
            gt: gt!,
          );
        gaiaVgateValidate();
      }
      return;
    }

    final registerData = Gt3RegisterData(
      challenge: challenge,
      gt: gt,
      success: true,
    );

    Gt3FlutterPlugin()
      ..addEventHandler(
        onClose: (Map<String, dynamic> message) {
          SmartDialog.showToast('關閉驗證');
        },
        onResult: (Map<String, dynamic> message) {
          if (kDebugMode) debugPrint("Captcha result: $message");
          String code = message["code"];
          if (code == "1") {
            // 發送 message["result"] 中的資料向 B 端的業務服務介面進行查詢
            SmartDialog.showToast('驗證成功');
            final result = message['result'];
            captchaData
              ..validate = result?['geetest_validate']
              ..seccode = result?['geetest_seccode']
              ..geetest = GeetestData(
                challenge: result?['geetest_challenge'],
                gt: gt!,
              );
            gaiaVgateValidate();
          } else {
            // 終端使用者完成驗證失敗，自動重試 If the verification fails, it will be automatically retried.
            if (kDebugMode) debugPrint("Captcha result code : $code");
          }
        },
        onError: (Map<String, dynamic> message) {
          SmartDialog.showToast("Captcha onError: $message");
          String code = message["code"];
          // 處理驗證中返回的錯誤 Handling errors returned in verification
          if (Platform.isAndroid) {
            // Android 平台
            if (code == "-2") {
              // Dart 呼叫異常 Call exception
            } else if (code == "-1") {
              // Gt3RegisterData 參數不合法 Parameter is invalid
            } else if (code == "201") {
              // 網路無法訪問 Network inaccessible
            } else if (code == "202") {
              // Json 解析錯誤 Analysis error
            } else if (code == "204") {
              // WebView 載入超時，請檢查是否混淆極驗 SDK   Load timed out
            } else if (code == "204_1") {
              // WebView 載入前端頁面錯誤，請查看日誌 Error loading front-end page, please check the log
            } else if (code == "204_2") {
              // WebView 載入 SSLError
            } else if (code == "206") {
              // gettype 介面錯誤或返回為 null   API error or return null
            } else if (code == "207") {
              // getphp 介面錯誤或返回為 null    API error or return null
            } else if (code == "208") {
              // ajax 介面錯誤或返回為 null      API error or return null
            } else {
              // 更多錯誤碼參考開發文件  More error codes refer to the development document
              // https://docs.geetest.com/sensebot/apirefer/errorcode/android
            }
          }

          if (Platform.isIOS) {
            // iOS 平台
            if (code == "-1009") {
              // 網路無法訪問 Network inaccessible
            } else if (code == "-1004") {
              // 無法尋找到 HOST  Unable to find HOST
            } else if (code == "-1002") {
              // 非法的 URL  Illegal URL
            } else if (code == "-1001") {
              // 網路超時 Network timeout
            } else if (code == "-999") {
              // 請求被意外中斷, 一般由使用者進行取消操作導致 The interrupted request was usually caused by the user cancelling the operation
            } else if (code == "-21") {
              // 使用了重複的 challenge   Duplicate challenges are used
              // 檢查取得 challenge 是否進行了快取  Check if the fetch challenge is cached
            } else if (code == "-20") {
              // 嘗試過多, 重新引導使用者觸發驗證即可 Try too many times, lead the user to request verification again
            } else if (code == "-10") {
              // 預判斷時被封禁, 不會再進行圖形驗證 Banned during pre-judgment, and no more image captcha verification
            } else if (code == "-2") {
              // Dart 呼叫異常 Call exception
            } else if (code == "-1") {
              // Gt3RegisterData 參數不合法  Parameter is invalid
            } else {
              // 更多錯誤碼參考開發文件 More error codes refer to the development document
              // https://docs.geetest.com/sensebot/apirefer/errorcode/ios
            }
          }
        },
      )
      ..startCaptcha(registerData);
  }

  static Future<void> showUserRealName(String mid) async {
    final res = await UserHttp.getUserRealName(mid);
    if (res case Success(:final response)) {
      final show = !response.name.isNullOrEmpty;
      showDialog(
        context: Get.context!,
        builder: (context) => AlertDialog(
          title: SelectableText(
            show ? response.name! : response.rejectPage?.title ?? '',
          ),
          content: show ? null : Text(response.rejectPage?.text ?? ''),
          actions: [
            TextButton(
              onPressed: Get.back,
              child: const Text('關閉'),
            ),
          ],
        ),
      );
    } else {
      res.toast();
    }
  }
}

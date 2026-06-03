import 'package:PiliPlus/http/api.dart';
import 'package:PiliPlus/http/init.dart';
import 'package:PiliPlus/http/loading_state.dart';
import 'package:PiliPlus/models_new/danmaku/post.dart';
import 'package:PiliPlus/utils/accounts.dart';
import 'package:dio/dio.dart';

abstract final class DanmakuHttp {
  static Future<LoadingState<DanmakuPost>> shootDanmaku({
    int type = 1, //彈幕類選擇(1：影片彈幕 2：漫畫彈幕)
    required int oid, // 影片cid
    required String msg, //彈幕文字(長度小於 100 字元)
    // 彈幕類型(1：滾動彈幕 4：底端彈幕 5：頂端彈幕 6：逆向彈幕(不能使用） 7：進階彈幕 8：程式碼彈幕（不能使用） 9：BAS彈幕（pool必須為2）)
    int mode = 1,
    // String? aid,// 稿件avid
    // String? bvid,// bvid與aid必須有一個
    required String bvid,
    int? progress, // 彈幕出現在影片內的時間（單位為毫秒，預設為0）
    int? color, // 彈幕顏色(預設白色，16777215）
    int? fontSize, // 彈幕字號（預設25）
    int? pool, // 彈幕池選擇（0：普通池 1：字幕池 2：特殊池（程式碼/BAS彈幕）預設普通池，0）
    //int? rnd,// 目前時間戳*1000000（若無此項，則發送彈幕冷卻時間限制為90s；若有此項，則發送彈幕冷卻時間限制為5s）
    bool colorful = false, //60001：專屬漸變彩色（需要會員）
    int? checkboxType, //是否帶 UP 身份標識（0：普通；4：帶有標識）
    // String? csrf,//CSRF Token（位於 Cookie）	Cookie 方式必要
    // String? access_key,//	APP 登入 Token		APP 方式必要
  }) async {
    // 構建參數物件
    // assert(aid != null || bvid != null);
    // assert(csrf != null || access_key != null);
    // 構建參數物件
    final data = <String, Object>{
      'type': type,
      'oid': oid,
      'msg': msg,
      'mode': mode,
      //'aid': aid,
      'bvid': bvid,
      'progress': ?progress,
      'color': ?colorful ? 16777215 : color,
      'fontsize': ?fontSize,
      'pool': ?pool,
      'rnd': DateTime.now().microsecondsSinceEpoch,
      'colorful': ?colorful ? 60001 : null,
      'checkbox_type': ?checkboxType,
      'csrf': Accounts.main.csrf,
      // 'access_key': access_key,
    };

    final res = await Request().post(
      Api.shootDanmaku,
      data: data,
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    if (res.data['code'] == 0) {
      return Success(DanmakuPost.fromJson(res.data['data']));
    } else {
      return Error(res.data['message'], code: res.data['code']);
    }
  }

  static Future<LoadingState<void>> danmakuLike({
    required bool isLike,
    required int cid,
    required int id,
  }) async {
    final data = {
      'op': isLike ? 1 : 2,
      'dmid': id,
      'oid': cid,
      'platform': 'web_player',
      'polaris_app_id': 100,
      'polaris_platform': 5,
      'spmid': '333.788.0.0',
      'from_spmid': '333.788.0.0',
      'statistics': '{"appId":100,"platform":5,"abtest":"","version":""}',
      'csrf': Accounts.main.csrf,
    };
    final res = await Request().post(
      Api.danmakuLike,
      data: data,
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    if (res.data['code'] == 0) {
      return const Success(null);
    } else {
      return Error(res.data['message'], code: res.data['code']);
    }
  }

  static Future<LoadingState<void>> danmakuReport({
    required int reason,
    required int cid,
    required int id,
    bool block = false,
    String? content,
  }) async {
    final data = {
      'cid': cid,
      'dmid': id,
      'reason': reason,
      'block': block,
      'originCid': cid,
      'content': ?content,
      'polaris_app_id': 100,
      'polaris_platform': 5,
      'spmid': '333.788.0.0',
      'from_spmid': '333.788.0.0',
      'statistics': '{"appId":100,"platform":5,"abtest":"","version":""}',
      'csrf': Accounts.main.csrf,
    };
    final res = await Request().post(
      Api.danmakuReport,
      data: data,
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    if (res.data['code'] == 0) {
      return const Success(null);
    } else {
      return Error(res.data['message']);
    }

    /// res.data['data']['block']
    /// {
    ///       0: "檢舉已提交",
    ///       "-1": "檢舉失敗，請先啟用帳號。",
    ///       "-2": "檢舉失敗，系統拒絕受理您的檢舉請求。",
    ///       "-3": "檢舉失敗，您已經被禁言。",
    ///       "-4": "您的操作過於頻繁，請稍後再試。",
    ///       "-5": "您已經檢舉過這條彈幕了。",
    ///       "-6": "檢舉失敗，系統錯誤。"
    /// }
  }

  static Future<LoadingState<String?>> danmakuRecall({
    required int cid,
    required int id,
  }) async {
    final data = {
      'dmid': id,
      'cid': cid,
      'type': 1,
      'csrf': Accounts.main.csrf,
    };
    final res = await Request().post(
      Api.danmakuRecall,
      data: data,
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    if (res.data['code'] == 0) {
      return Success(res.data['message']);
    } else {
      return Error(res.data['message']);
    }
  }

  static Future<LoadingState<String?>> danmakuEditState({
    required int oid,
    required Iterable<int> ids,
    required int state,
  }) async {
    /// 0: 取消刪除
    /// 1：刪除彈幕
    /// 2：彈幕保護
    /// 3：取消保護
    final data = {
      'dmids': ids.join(','),
      'oid': oid,
      'state': state,
      'type': 1,
      'csrf': Accounts.main.csrf,
    };
    final res = await Request().post(
      Api.danmakuRecall,
      data: data,
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    if (res.data['code'] == 0) {
      return Success(res.data['message']);
    } else {
      return Error(res.data['message']);
    }
  }
}

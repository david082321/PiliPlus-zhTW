import 'package:PiliPlus/models/model_rec_video_item.dart';
import 'package:PiliPlus/models/model_video.dart';
import 'package:PiliPlus/utils/id_utils.dart';
import 'package:PiliPlus/utils/num_utils.dart';

class RcmdVideoItemAppModel extends BaseRcmdVideoItemModel {
  int? get id => aid;
  String? talkBack;

  String? cardType;
  ThreePoint? threePoint;

  RcmdVideoItemAppModel.fromJson(Map<String, dynamic> json) {
    aid = json['player_args']?['aid'] ?? int.tryParse(json['param'] ?? '0');
    bvid = json['bvid'] ?? IdUtils.av2bv(aid!);
    cid = json['player_args']?['cid'];
    cover = json['cover'];
    stat = RcmdStat.fromJson(json);
    // 改用player_args中的duration作為原始資料（秒數）
    duration = json['player_args']?['duration'] ?? 0;
    //duration = json['cover_right_text'];
    title = json['title'];
    owner = RcmdOwner.fromJson(json);
    rcmdReason = json['rcmd_reason'];
    //     json['bottom_rcmd_reason'] ??
    //     json['top_rcmd_reason'];
    if (rcmdReason != null && rcmdReason!.contains('讚')) {
      // 有時能在推薦原因裡獲得按讚數
      (stat as RcmdStat).like = NumUtils.parseNum(rcmdReason!);
    }
    // 由於app端api並不會直接返回與owner的關注狀態
    // 所以借用推薦原因是否為「已關注」、「新關注」判別關注狀態，從而與web端介面等效
    isFollowed = const {'已關注', '新關注'}.contains(rcmdReason);
    // 如果是，就無需再顯示推薦原因，交由view統一處理即可
    if (isFollowed) rcmdReason = null;

    goto = json['goto'];
    param = int.parse(json['param']);
    uri = json['uri'];
    talkBack = json['talk_back'];

    if (json['goto'] == 'bangumi') {
      pgcBadge = json['cover_right_text'];
    }

    cardType = json['card_type'];
    threePoint = json['three_point_v2'] != null
        ? ThreePoint.fromJson(json['three_point_v2'])
        : null;
    desc = json['desc'];
  }
}

class RcmdStat extends BaseStat {
  RcmdStat.fromJson(Map<String, dynamic> json) {
    view = NumUtils.parseNum(json["cover_left_text_1"] ?? '');
    danmu = NumUtils.parseNum(json["cover_left_text_2"] ?? '');
  }
}

class RcmdOwner extends BaseOwner {
  RcmdOwner.fromJson(Map<String, dynamic> json) {
    name = json['goto'] == 'av'
        ? (json['args']?['up_name'] ?? '')
        : (json['desc_button']?['text'] ?? '');
    mid = json['args']?['up_id'] ?? 0;
  }
}

class ThreePoint {
  List<Reason>? dislikeReasons;
  List<Reason>? feedbacks;
  // int? watchLater;

  ThreePoint.fromJson(List json) {
    for (final elem in json) {
      switch (elem['type']) {
        // case 'watch_later':
        //   watchLater = 1;
        //   break;
        case 'feedback':
          feedbacks = (elem['reasons'] as List?)
              ?.map((i) => Reason.fromJson(i))
              .toList();
          break;
        case 'dislike':
          dislikeReasons = (elem['reasons'] as List?)
              ?.map((i) => Reason.fromJson(i))
              .toList();
          break;
      }
    }
  }
}

class Reason {
  int? id;
  String? name;
  String? toast;

  Reason.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    toast = json['toast'];
  }
}

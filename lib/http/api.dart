import 'package:PiliPlus/http/constants.dart';

abstract final class Api {
  // 推薦影片
  static const String recommendListApp =
      '${HttpString.appBaseUrl}/x/v2/feed/index';
  static const String recommendListWeb =
      '/x/web-interface/wbi/index/top/feed/rcmd';

  // APP端不感興趣、取消不感興趣
  static const String feedDislike = '${HttpString.appBaseUrl}/x/feed/dislike';
  static const String feedDislikeCancel =
      '${HttpString.appBaseUrl}/x/feed/dislike/cancel';

  // 熱門影片
  static const String hotList = '/x/web-interface/popular';

  // 影片串流
  // https://github.com/SocialSisterYi/bilibili-API-collect/blob/master/docs/video/videostream_url.md
  static const String ugcUrl = '/x/player/wbi/playurl';

  // 番劇影片串流
  // https://api.bilibili.com/pgc/player/web/v2/playurl?cid=104236640&bvid=BV13t411n7ex
  static const String pgcUrl = '/pgc/player/web/v2/playurl';

  static const String pugvUrl = '/pugv/player/web/playurl';

  static const String tvPlayUrl = '/x/tv/playurl';

  // 字幕
  // aid, cid
  static const String playInfo = '/x/player/wbi/v2';

  // 影片詳情
  // 豎屏 https://api.bilibili.com/x/web-interface/view?aid=527403921
  // https://api.bilibili.com/x/web-interface/view/detail  取得影片超詳細資訊(web端)
  static const String videoIntro = '/x/web-interface/view';
  // 影片詳情 超詳細
  // https://api.bilibili.com/x/web-interface/view/detail?aid=527403921

  /// https://github.com/SocialSisterYi/bilibili-API-collect/blob/master/docs/video/action.md
  // 按讚 Post
  /// aid	num	稿件avid	必要（可選）	avid與bvid任選一個
  /// bvid	str	稿件bvid	必要（可選）	avid與bvid任選一個
  /// like	num	操作方式	必要	1：按讚 2：取消讚
  // csrf	str	CSRF Token（位於cookie）	必要
  // https://api.bilibili.com/x/web-interface/archive/like
  // static const String likeVideo = '/x/web-interface/archive/like';

  // 改用app端按讚介面
  static const String likeVideo = '${HttpString.appBaseUrl}/x/v2/view/like';
  //判斷影片是否被按讚（雙端）Get
  // access_key	str	APP登入Token	APP方式必要
  /// aid	num	稿件avid	必要（可選）	avid與bvid任選一個
  /// bvid	str	稿件bvid	必要（可選）	avid與bvid任選一個
  // https://api.bilibili.com/x/web-interface/archive/has/like
  // static const String hasLikeVideo = '/x/web-interface/archive/has/like';

  static const String pgcLikeCoinFav = '/pgc/season/episode/community';

  // 影片點踩 web端不支援

  // 點踩 Post(app端)
  /// access_key str	APP登入Token 必要
  /// aid num	稿件avid	必要
  ///
  static const String dislikeVideo =
      '${HttpString.appBaseUrl}/x/v2/view/dislike';

  // 投幣影片（web端）POST
  /// aid	num	稿件avid	必要（可選）	avid與bvid任選一個
  /// bvid	str	稿件bvid	必要（可選）	avid與bvid任選一個
  /// multiply	num	投幣數量	必要	上限為2
  /// select_like	num	是否附加按讚	非必要	0：不按讚 1：同時按讚 預設為0
  // csrf	str	CSRF Token（位於cookie）	必要
  // https://api.bilibili.com/x/web-interface/coin/add
  // static const String coinVideo = '/x/web-interface/coin/add';

  // 改用app端投幣介面
  static const String coinVideo = '${HttpString.appBaseUrl}/x/v2/view/coin/add';

  // 判斷影片是否被投幣（雙端）GET
  // access_key	str	APP登入Token	APP方式必要
  /// aid	num	稿件avid	必要（可選）	avid與bvid任選一個
  /// bvid	str	稿件bvid	必要（可選）	avid與bvid任選一個
  /// https://api.bilibili.com/x/web-interface/archive/coins
  // static const String hasCoinVideo = '/x/web-interface/archive/coins';

  /// 收藏夾 詳情
  /// media_id  目前收藏夾id 搜尋全部時為預設收藏夾id
  /// pn int 目前頁
  /// ps int pageSize
  /// keyword String 搜尋詞
  /// order String 排序方式 view 最多播放 mtime 最近收藏 pubtime 最近投稿
  /// tid int 分區id
  /// platform web
  /// type 0 目前收藏夾 1 全部收藏夾
  // https://api.bilibili.com/x/v3/fav/resource/list?media_id=76614671&pn=1&ps=20&keyword=&order=mtime&type=0&tid=0
  static const String favResourceList = '/x/v3/fav/resource/list';

  // 收藏影片（雙端）POST
  // access_key	str	APP登入Token	APP方式必要
  /// rid	num	稿件avid	必要
  /// type	num	必須為2	必要
  /// add_media_ids	nums	需要加入的收藏夾mlid	非必要	同時新增多個，用,（%2C）分隔
  /// del_media_ids	nums	需要取消的收藏夾mlid	非必要	同時取消多個，用,（%2C）分隔
  // csrf	str	CSRF Token（位於cookie）	Cookie方式必要
  // https://api.bilibili.com/medialist/gateway/coll/resource/deal
  // https://api.bilibili.com/x/v3/fav/resource/deal
  static const String favVideo = '/x/v3/fav/resource/batch-deal';

  static const String unfavAll = '/x/v3/fav/resource/unfav-all';

  static const String copyFav = '/x/v3/fav/resource/copy';

  static const String moveFav = '/x/v3/fav/resource/move';

  static const String cleanFav = '/x/v3/fav/resource/clean';

  static const String sortFav = '/x/v3/fav/resource/sort';

  static const String sortFavFolder = '/x/v3/fav/folder/sort';

  // 判斷影片是否被收藏（雙端）GET
  /// aid
  // https://api.bilibili.com/x/v2/fav/video/favoured
  // static const String hasFavVideo = '/x/v2/fav/video/favoured';

  // 分享影片 （Web端） POST
  // https://api.bilibili.com/x/web-interface/share/add
  // aid	num	稿件avid	必要（可選）	avid與bvid任選一個
  // bvid	str	稿件bvid	必要（可選）	avid與bvid任選一個
  // csrf	str	CSRF Token（位於cookie）	必要

  // 一鍵三連
  // https://api.bilibili.com/x/web-interface/archive/like/triple
  // aid	num	稿件avid	必要（可選）	avid與bvid任選一個
  // bvid	str	稿件bvid	必要（可選）	avid與bvid任選一個
  // csrf	str	CSRF Token（位於cookie）	必要
  static const String ugcTriple = '/x/web-interface/archive/like/triple';

  static const String pgcTriple = '/pgc/season/episode/like/triple';

  // 取得指定使用者建立的所有收藏夾資訊
  // 該介面也能查詢目標內容id存在於那些收藏夾中
  // up_mid	num	目標使用者mid	必要
  // type	num	目標內容屬性	非必要	預設為全部 0：全部 2：影片稿件
  // rid	num	目標 影片稿件avid
  static const String favFolder = '/x/v3/fav/folder/created/list-all';

  static const String copyToview = '/x/v2/history/toview/copy';

  static const String moveToview = '/x/v2/history/toview/move';

  // 影片詳情頁 相關影片
  static const String relatedList = '/x/web-interface/archive/related';

  // 查詢使用者與自己關係_僅查關注
  static const String relation = '/x/relation';

  static const String relations = '/x/relation/relations';

  // 操作使用者關係
  static const String relationMod = '/x/relation/modify';

  // 相互關係查詢 // 失效
  // static const String relationSearch = '/x/space/wbi/acc/relation';

  // 評論列表
  // https://api.bilibili.com/x/v2/reply/main?csrf=6e22efc1a47225ea25f901f922b5cfdd&mode=3&oid=254175381&pagination_str=%7B%22offset%22:%22%22%7D&plat=1&seek_rpid=0&type=11
  static const String replyList = '/x/v2/reply';

  // 樓中樓
  static const String replyReplyList = '/x/v2/reply/reply';

  // 評論按讚
  static const String likeReply = '/x/v2/reply/action';

  static const String hateReply = '/x/v2/reply/hate';

  // 發表評論
  // https://github.com/SocialSisterYi/bilibili-API-collect/blob/master/docs/comment/action.md
  static const String replyAdd = '/x/v2/reply/add';

  // 刪除評論
  // https://github.com/SocialSisterYi/bilibili-API-collect/blob/master/docs/comment/action.md
  static const String replyDel = '/x/v2/reply/del';

  // 使用者(被)關注數、投稿數
  // https://api.bilibili.com/x/relation/stat?vmid=697166795
  static const String userStat = '/x/relation/stat';

  // 取得我的表情列表
  // business:reply（回復）dynamic（動態）
  //https://api.bilibili.com/x/emote/user/panel/web?business=reply
  static const String myEmote = '/x/emote/user/panel/web';

  // 取得使用者資訊
  static const String userInfo = '/x/web-interface/nav';

  // 取得目前使用者狀態
  static const String userStatOwner = '/x/web-interface/nav/stat';

  // 收藏夾
  // https://api.bilibili.com/x/v3/fav/folder/created/list?pn=1&ps=10&up_mid=17340771
  static const String userFavFolder = '/x/v3/fav/folder/created/list';

  static const String favFolderInfo = '/x/v3/fav/folder/info';

  static const String addFolder = '/x/v3/fav/folder/add';

  static const String editFolder = '/x/v3/fav/folder/edit';

  static const String deleteFolder = '/x/v3/fav/folder/del';

  // 正在直播的up & 關注的up
  // https://api.bilibili.com/x/polymer/web-dynamic/v1/portal
  static const String followUp = '/x/polymer/web-dynamic/v1/portal';

  static const String dynUplist = '/x/polymer/web-dynamic/v1/uplist';

  // 關注的up動態
  // https://api.bilibili.com/x/polymer/web-dynamic/v1/feed/all
  // https://api.bilibili.com/x/polymer/web-dynamic/v1/feed/all?timezone_offset=-480&type=video&page=1&features=itemOpusStyle
  // https://api.bilibili.com/x/polymer/web-dynamic/v1/feed/all?host_mid=548196587&offset=&page=1&features=itemOpusStyle
  static const String followDynamic = '/x/polymer/web-dynamic/v1/feed/all';

  // 動態按讚
  // static const String likeDynamic =
  //     '${HttpString.tUrl}/dynamic_like/v1/dynamic_like/thumb';

  // 動態按讚 new
  static const String thumbDynamic = '/x/dynamic/feed/dyn/thumb';

  // 取得稍後再看
  static const String seeYouLater = '/x/v2/history/toview/web';

  // 取得歷史記錄
  static const String historyList = '/x/web-interface/history/cursor';

  // 暫停歷史記錄
  static const String pauseHistory = '/x/v2/history/shadow/set';

  // 查詢歷史記錄暫停狀態
  static const String historyStatus = '/x/v2/history/shadow?jsonp=jsonp';

  // 清空歷史記錄
  static const String clearHistory = '/x/v2/history/clear';

  // 刪除某條歷史記錄
  static const String delHistory = '/x/v2/history/delete';

  // 搜尋歷史記錄
  static const String searchHistory = '/x/web-interface/history/search';

  // 熱搜
  static const String hotSearchList =
      'https://s.search.bilibili.com/main/hotword';

  // 預設搜尋詞
  static const String searchDefault = '/x/web-interface/wbi/search/default';

  // 搜尋關鍵字
  static const String searchSuggest =
      'https://s.search.bilibili.com/main/suggest';

  // 分類搜尋
  static const String searchByType = '/x/web-interface/wbi/search/type';

  static const String searchAll = '/x/web-interface/wbi/search/all/v2';

  // 記錄影片播放進度
  // https://github.com/SocialSisterYi/bilibili-API-collect/blob/master/docs/video/report.md
  static const String heartBeat = '/x/click-interface/web/heartbeat';

  static const String historyReport = '/x/v2/history/report';

  static const String roomEntryAction =
      '${HttpString.liveBaseUrl}/xlive/web-room/v1/index/roomEntryAction';

  static const String mediaListHistory = '/x/v1/medialist/history';

  // 查詢影片分P列表 (avid/bvid轉cid)
  static const String ab2c = '/x/player/pagelist';

  // 番劇/劇集明細
  static const String pgcInfo = '/pgc/view/web/season';

  static const String pugvInfo = '/pugv/view/web/season';

  // https://api.bilibili.com/pgc/season/episode/web/info?ep_id=12345678
  static const String episodeInfo = '/pgc/season/episode/web/info';

  // 全部關注的up
  // vmid 使用者id pn 頁碼 ps 每頁個數，最大50 order: desc
  // order_type 排序規則 最近訪問傳空，最常訪問傳 attention
  static const String followings = '/x/relation/followings';

  // 搜尋follow
  static const followSearch = '/x/relation/followings/search';

  // 粉絲
  // vmid 使用者id pn 頁碼 ps 每頁個數，最大50 order: desc
  // order_type 排序規則 最近訪問傳空，最常訪問傳 attention
  static const String fans = '/x/relation/fans';

  // 直播
  // ?page=1&page_size=30&platform=web
  static const String liveList =
      '${HttpString.liveBaseUrl}/xlive/web-interface/v1/second/getUserRecommend';

  // 直播間詳情
  // cid roomId
  // qn 80:流暢，150:高畫質，400:藍光，10000:原畫，20000:4K, 30000:杜比
  static const String liveRoomInfo =
      '${HttpString.liveBaseUrl}/xlive/web-room/v2/index/getRoomPlayInfo';

  static const String sendLiveMsg = '${HttpString.liveBaseUrl}/msg/send';

  // 直播間詳情 H5
  static const String liveRoomInfoH5 =
      '${HttpString.liveBaseUrl}/xlive/web-room/v1/index/getH5InfoByRoom';

  // 直播間彈幕預取得
  // roomid roomId
  static const String liveRoomDmPrefetch =
      '${HttpString.liveBaseUrl}/xlive/web-room/v1/dM/gethistory';

  //直播間彈幕金鑰取得介面
  static const String liveRoomDmToken =
      '${HttpString.liveBaseUrl}/xlive/web-room/v1/index/getDanmuInfo';

  // 使用者資訊 需要Wbi簽名
  // https://api.bilibili.com/x/space/wbi/acc/info?mid=503427686&token=&platform=web&web_location=1550101&w_rid=d709892496ce93e3d94d6d37c95bde91&wts=1689301482
  static const String memberInfo = '/x/space/wbi/acc/info';

  static const String space = '${HttpString.appBaseUrl}/x/v2/space';

  static const String spaceArchive =
      '${HttpString.appBaseUrl}/x/v2/space/archive/cursor';

  static const String spaceStory =
      '${HttpString.appBaseUrl}/x/v2/feed/index/space/story/cursor';

  static const String spaceChargingArchive =
      '${HttpString.appBaseUrl}/x/v2/space/archive/charging';

  static const String spaceSeason =
      '${HttpString.appBaseUrl}/x/v2/space/season/videos';

  static const String spaceSeries =
      '${HttpString.appBaseUrl}/x/v2/space/series';

  static const String spaceBangumi =
      '${HttpString.appBaseUrl}/x/v2/space/bangumi';

  static const String spaceArticle =
      '${HttpString.appBaseUrl}/x/v2/space/article';

  static const String spaceFav = '/x/v3/fav/folder/space';

  static const String seasonSeries = '/x/polymer/web-space/seasons_series_list';

  // 使用者名稱片資訊
  static const String memberCardInfo = '/x/web-interface/card';

  // 使用者投稿
  // https://api.bilibili.com/x/space/wbi/arc/search?
  // mid=85754245&
  // ps=30&
  // tid=0&
  // pn=1&
  // keyword=&
  // order=pubdate&
  // platform=web&
  // web_location=1550101&
  // order_avoided=true&
  // w_rid=d893cf98a4e010cf326373194a648360&
  // wts=1689767832
  static const String searchArchive = '/x/space/wbi/arc/search';

  // 使用者動態搜尋
  // static const String memberDynamicSearch = '/x/space/dynamic/search';
  static const String dynSearch = '/x/polymer/web-dynamic/v1/feed/space/search';

  // 使用者動態
  static const String memberDynamic = '/x/polymer/web-dynamic/v1/feed/space';

  // 稍後再看
  static const String toViewLater = '/x/v2/history/toview/add';

  // 移除已觀看
  static const String toViewDel = '/x/v2/history/toview/v2/dels';

  // 清空稍後再看
  static const String toViewClear = '/x/v2/history/toview/clear';

  // 追番
  static const String pgcAdd = '/pgc/web/follow/add';

  // 取消追番
  static const String pgcDel = '/pgc/web/follow/del';

  static const String pgcUpdate = '/pgc/web/follow/status/update';

  // 我的追番/追劇 ?type=1&pn=1&ps=15
  static const String favPgc = '/x/space/bangumi/follow/list';

  // 黑名單
  static const String blackLst = '/x/relation/blacks';

  // github 取得最新版
  static const String latestApp =
      'https://api.github.com/repos/david082321/PiliPlus-zhTW/releases';

  // 多少人在看
  // https://api.bilibili.com/x/player/online/total?aid=913663681&cid=1203559746&bvid=BV1MM4y1s7NZ&ts=56427838
  static const String onlineTotal = '/x/player/online/total';

  // static const String webDanmaku = '/x/v2/dm/web/seg.so';

  // 發送影片彈幕
  //https://github.com/SocialSisterYi/bilibili-API-collect/blob/master/docs/danmaku/action.md
  static const String shootDanmaku = '/x/v2/dm/post';

  // 彈幕封鎖查詢（Get）
  static const String danmakuFilter = '/x/dm/filter/user';

  // 彈幕封鎖詞新增（Post）
  // 表單內容：
  // type: 0（關鍵字）1（正則）2（使用者）
  // filter: 封鎖內容
  // csrf
  static const String danmakuFilterAdd = '/x/dm/filter/user/add';

  // 彈幕封鎖詞刪除（Post）
  // 表單內容：
  // ids: 被刪除條目編號
  // csrf
  static const String danmakuFilterDel = '/x/dm/filter/user/del';

  // up主分組
  static const String followUpTag = '/x/relation/tags';

  // 設定Up主分組
  // 0 新增至預設分組  否則使用,分割tagid
  static const String addUsers = '/x/relation/tags/addUsers';

  static const String addSpecial = '/x/relation/tag/special/add';

  static const String delSpecial = '/x/relation/tag/special/del';

  // 取得指定分組下的up
  static const String followUpGroup = '/x/relation/tag';

  static const String createFollowTag = '/x/relation/tag/create';

  static const String updateFollowTag = '/x/relation/tag/update';

  static const String delFollowTag = '/x/relation/tag/del';

  // 取得未讀私信數
  // https://api.vc.bilibili.com/session_svr/v1/session_svr/single_unread
  static const String msgUnread =
      '${HttpString.tUrl}/session_svr/v1/session_svr/single_unread';

  // 取得消息中心未讀資訊
  static const String msgFeedUnread = '/x/msgfeed/unread';
  //https://api.bilibili.com/x/msgfeed/reply?platform=web&build=0&mobi_app=web
  static const String msgFeedReply = '/x/msgfeed/reply';
  //https://api.bilibili.com/x/msgfeed/at?platform=web&build=0&mobi_app=web
  static const String msgFeedAt = '/x/msgfeed/at';
  //https://api.bilibili.com/x/msgfeed/like?platform=web&build=0&mobi_app=web
  static const String msgFeedLike = '/x/msgfeed/like';
  //https://message.bilibili.com/x/sys-msg/query_notify_list?page_size=20&cursor=xxx
  static const String msgSysNotify =
      '${HttpString.messageBaseUrl}/x/sys-msg/query_notify_list';

  // 系統資訊游標更新（已讀標記）
  //https://message.bilibili.com/x/sys-msg/update_cursor?csrf=xxxx&csrf=xxxx&cursor=1705288500000000000&has_up=0&build=0&mobi_app=web
  static const String msgSysUpdateCursor =
      '${HttpString.messageBaseUrl}/x/sys-msg/update_cursor';

  /// 私聊
  ///  'https://api.vc.bilibili.com/session_svr/v1/session_svr/get_sessions?
  /// session_type=1&
  /// group_fold=1&
  /// unfollow_fold=0&
  /// sort_rule=2&
  /// build=0&
  /// mobi_app=web&
  /// w_rid=8641d157fb9a9255eb2159f316ee39e2&
  /// wts=1697305010

  static const String sessionList =
      '${HttpString.tUrl}/session_svr/v1/session_svr/get_sessions';

  /// 私聊使用者資訊
  /// uids
  /// build=0&mobi_app=web
  static const String sessionAccountList =
      '${HttpString.tUrl}/account/v1/user/cards';

  /// https://api.vc.bilibili.com/svr_sync/v1/svr_sync/fetch_session_msgs?
  /// talker_id=400787461&
  /// session_type=1&
  /// size=20&
  /// sender_device_id=1&
  /// build=0&
  /// mobi_app=web&
  /// web_location=333.1296&
  /// w_rid=cfe3bf58c9fe181bbf4dd6c75175e6b0&
  /// wts=1697350697

  static const String sessionMsg =
      '${HttpString.tUrl}/svr_sync/v1/svr_sync/fetch_session_msgs';

  /// 標記已讀 POST
  /// talker_id:
  /// session_type: 1
  /// ack_seqno: 920224140918926
  /// build: 0
  /// mobi_app: web
  /// csrf_token:
  /// csrf:
  static const String ackSessionMsg =
      '${HttpString.tUrl}/session_svr/v1/session_svr/update_ack';

  // 取得某個動態詳情
  // timezone_offset=-480
  // id=849312409672744983
  // features=itemOpusStyle
  static const String dynamicDetail = '/x/polymer/web-dynamic/v1/detail';

  // AI總結
  /// https://api.bilibili.com/x/web-interface/view/conclusion/get?
  /// bvid=BV1ju4y1s7kn&
  /// cid=1296086601&
  /// up_mid=4641697&
  /// w_rid=1607c6c5a4a35a1297e31992220900ae&
  /// wts=1697033079
  static const String aiConclusion = '/x/web-interface/view/conclusion/get';

  // captcha驗證碼
  static const String getCaptcha =
      '${HttpString.passBaseUrl}/x/passport-login/captcha?source=main_web';

  // web端簡訊驗證碼
  static const String smsCode =
      '${HttpString.passBaseUrl}/x/passport-login/web/sms/send';

  // web端驗證碼登入

  // web端密碼登入
  static const String logInByWebPwd =
      '${HttpString.passBaseUrl}/x/passport-login/web/login';

  // 取得guestID
  // static const String getGuestId = '/x/passport-user/guest/reg';

  // app端簡訊驗證碼
  static const String appSmsCode =
      '${HttpString.passBaseUrl}/x/passport-login/sms/send';

  // app端驗證碼登入
  static const String logInByAppSms =
      '${HttpString.passBaseUrl}/x/passport-login/login/sms';

  // 取得簡訊驗證碼
  // static const String appSafeSmsCode =
  //     'https://passport.bilibili.com/x/safecenter/common/sms/send';

  /// app端密碼登入
  /// username
  /// password
  /// key
  /// salt
  static const String loginByPwdApi =
      '${HttpString.passBaseUrl}/x/passport-login/oauth2/login';

  /// 密碼登入時，提示「本次登入環境存在風險, 需使用手機號碼進行驗證或綁定」
  /// 根據https://ivan.hanloth.cn/archives/530/流程進行手機號碼驗證
  /// tmp_code
  static const String safeCenterGetInfo =
      '${HttpString.passBaseUrl}/x/safecenter/user/info';

  /// 驗證綁定手機號碼前的人機驗證
  static const String preCapture =
      '${HttpString.passBaseUrl}/x/safecenter/captcha/pre';

  /// 密碼登入時風控發送手機驗證碼
  ///sms_type	str	loginTelCheck
  /// tmp_code	str	驗證標記程式碼	來自資料處理中的解析出的參數tmp_token
  /// gee_challenge	str	極驗id	申請人機驗證時得到(data->gee_challenge)
  /// gee_seccode	str	極驗key	人機驗證後得到(result->geetest_seccode)
  /// gee_validate	str	極驗result	人機驗證後得到(result->geetest_validate)
  /// recaptcha_token	str	驗證token	申請人機驗證時得到(data->recaptcha_token)
  static const String safeCenterSmsCode =
      '${HttpString.passBaseUrl}/x/safecenter/common/sms/send';

  /// type	str	loginTelCheck
  /// code	int	驗證碼內容
  /// tmp_code	str	驗證標記程式碼	來自資料處理中的解析出的參數tmp_token
  /// request_id	str	驗證請求標記	來自資料處理中的解析出的參數requestId
  /// captcha_key	str	驗證秘鑰	來自申請驗證碼的captcha_key（data->captcha_key）
  static const String safeCenterSmsVerify =
      '${HttpString.passBaseUrl}/x/safecenter/login/tel/verify';

  static const String oauth2AccessToken =
      '${HttpString.passBaseUrl}/x/passport-login/oauth2/access_token';

  /// 密碼加密金鑰
  /// disable_rcmd
  /// local_id
  static const getWebKey = '${HttpString.passBaseUrl}/x/passport-login/web/key';

  /// cookie轉access_key
  static const qrcodeConfirm =
      '${HttpString.passBaseUrl}/x/passport-tv-login/h5/qrcode/confirm';

  /// 申請二維碼(TV端)
  static const getTVCode =
      '${HttpString.passBaseUrl}/x/passport-tv-login/qrcode/auth_code';

  ///掃碼登入（TV端）
  static const qrcodePoll =
      '${HttpString.passBaseUrl}/x/passport-tv-login/qrcode/poll';

  static const logout = '${HttpString.passBaseUrl}/login/exit/v2';

  /// 置頂影片
  static const getTopVideoApi = '/x/space/top/arc';

  /// 首頁 - 最近投幣的影片
  /// vmid
  /// gaia_source = main_web
  /// web_location
  /// w_rid
  /// wts
  static const getRecentCoinVideoApi = '/x/space/coin/video';

  /// 最近按讚的影片
  static const getRecentLikeVideoApi = '/x/space/like/video';

  /// 使用者專欄
  static const getMemberSeasonsApi = '/x/polymer/web-space/home/seasons_series';

  /// 獲讚數 播放數
  /// mid
  static const getMemberViewApi = '/x/space/upstat';

  static const seasonArchives = '/x/polymer/web-space/seasons_archives_list';

  static const seriesArchives = '/x/series/archives';

  /// 取得未讀動態數
  static const getUnreadDynamic = '/x/web-interface/dynamic/entrance';

  /// 使用者動態首頁
  static const dynamicSpmPrefix = '${HttpString.spaceBaseUrl}/1/dynamic';

  /// 啟用buvid3
  static const activateBuvidApi = '/x/internal/gaia-gateway/ExClimbWuzhi';

  /// 我的訂閱
  static const userSubFolder = '/x/v3/fav/folder/collected/list';

  /// 我的訂閱-合集詳情
  static const favSeasonList = '/x/space/fav/season/list';

  /// 發送私信
  static const String sendMsg = '${HttpString.tUrl}/web_im/v1/web_im/send_msg';

  /// 排行榜
  static const String getRankApi = "/x/web-interface/ranking/v2";

  static const String pgcRank = "/pgc/web/rank/list";

  static const String pgcSeasonRank = "/pgc/season/rank/web/list";

  /// 取消訂閱-播單
  static const String unfavFolder = '/x/v3/fav/folder/unfav';

  // static const String videoTags = '/x/tag/archive/tags';
  static const String videoTags = '/x/web-interface/view/detail/tag';

  static const String reportMember =
      '${HttpString.spaceBaseUrl}/ajax/report/add';

  static const String removeMsg = '/session_svr/v1/session_svr/remove_session';

  static const String delSysMsg = '/x/sys-msg/del_notify_list';

  static const String delMsgfeed = '/x/msgfeed/del';

  static const String setTop = '/session_svr/v1/session_svr/set_top';

  static const String createDynamic = '/x/dynamic/feed/create/dyn';

  static const String createTextDynamic = '/dynamic_svr/v1/dynamic_svr/create';

  // static const String removeDynamic = '${HttpString.tUrl}/dynamic_svr/v1/dynamic_svr/rm_dynamic';

  static const String removeDynamic = '/x/dynamic/feed/operate/remove';

  static const String uploadBfs = '/x/dynamic/feed/draw/upload_bfs';

  static const String uploadImage = '/x/upload/web/image';

  // 按讚投幣收藏關注
  static const String videoRelation = '/x/web-interface/archive/relation';

  static const String favSeason = '/x/v3/fav/season/fav';

  static const String unfavSeason = '/x/v3/fav/season/unfav';

  /// 稍後再看&收藏夾影片列表
  static const String mediaList = '/x/v2/medialist/resource/list';

  static const String pgcIndexCondition = '/pgc/season/index/condition';

  static const String pgcIndexResult = '/pgc/season/index/result';

  static const String archiveNoteList = '/x/note/publish/list/archive';

  static const String noteList = '/x/note/list';

  static const String userNoteList = '/x/note/publish/list/user';

  static const String addNote = '/x/note/add';

  static const String delNote = '/x/note/del';

  static const String delPublishNote = '/x/note/publish/del';

  static const String archiveNote = '/x/note/list/archive';

  static const String favArticle = '/x/polymer/web-dynamic/v1/opus/feed/fav';

  static const String communityAction =
      '/x/community/cosmo/interface/simple_action';

  static const String delFavArticle = '/x/article/favorites/del';

  static const String addFavArticle = '/x/article/favorites/add';

  static const String replyTop = '/x/v2/reply/top';

  static const String getCoin = '${HttpString.accountBaseUrl}/site/getCoin';

  static const String getLiveEmoticons =
      '${HttpString.liveBaseUrl}/xlive/web-ucenter/v2/emoticon/GetEmoticons';

  static const String pgcTimeline = '/pgc/web/timeline';

  static const String searchTrending = '/x/v2/search/trending/ranking';

  static const String setTopDyn = '/x/dynamic/feed/space/set_top';

  static const String rmTopDyn = '/x/dynamic/feed/space/rm_top';

  static const String searchRecommend =
      '${HttpString.appBaseUrl}/x/v2/search/recommend';

  static const String articleInfo = '/x/article/viewinfo';

  static const String dynamicReport = '/x/dynamic/feed/dynamic_report/add';

  // https://github.com/SocialSisterYi/bilibili-API-collect/pull/1242
  static const String articleView = '/x/article/view';

  static const String opusDetail = '/x/polymer/web-dynamic/v1/opus/detail';

  static const String gaiaVgateRegister = '/x/gaia-vgate/v1/register';

  static const String gaiaVgateValidate = '/x/gaia-vgate/v1/validate';

  static const String voteInfo = '/x/vote/vote_info';

  static const String doVote = '/x/vote/do_vote';

  static const String liveFeedIndex =
      '${HttpString.liveBaseUrl}/xlive/app-interface/v2/index/feed';

  static const String liveFollow =
      '${HttpString.liveBaseUrl}/xlive/web-ucenter/user/following';

  static const String liveSecondList =
      '${HttpString.liveBaseUrl}/xlive/app-interface/v2/second/getList';

  static const String msgSetNotice = '/x/msgfeed/notice';

  static const String liveAreaList =
      '${HttpString.liveBaseUrl}/xlive/app-interface/v2/index/getAreaList';

  static const String liveRoomAreaList =
      '${HttpString.liveBaseUrl}/room/v1/Area/getList';

  static const String getLiveFavTag =
      '${HttpString.liveBaseUrl}/xlive/app-interface/v2/second/get_fav_tag';

  static const String setLiveFavTag =
      '${HttpString.liveBaseUrl}/xlive/app-interface/v2/second/set_fav_tag';

  static const String liveSearch =
      '${HttpString.liveBaseUrl}/xlive/app-interface/v2/search_live';

  static const String topicTop =
      '${HttpString.appBaseUrl}/x/topic/web/details/top';

  static const String topicFeed = '/x/polymer/web-dynamic/v1/feed/topic';

  static const String spaceOpus = '/x/polymer/web-dynamic/v1/opus/feed/space';

  static const String articleList = '/x/article/list/web/articles';

  static const String setMsgDnd =
      '${HttpString.tUrl}/link_setting/v1/link_setting/set_msg_dnd';

  static const String imUserInfos = '${HttpString.tUrl}/x/im/user_infos';

  static const String getSessionSs =
      '${HttpString.tUrl}/link_setting/v1/link_setting/get_session_ss';

  static const String getMsgDnd =
      '${HttpString.tUrl}/link_setting/v1/link_setting/get_msg_dnd';

  static const String setPushSs =
      '${HttpString.tUrl}/link_setting/v1/link_setting/set_push_ss';

  static const String dynReserve = '/x/dynamic/feed/reserve/click';

  static const String spaceReserve = '/x/space/reserve';

  static const String spaceReserveCancel = '/x/space/reserve/cancel';

  static const String favPugv = '/pugv/app/web/favorite/page';

  static const String addFavPugv = '/pugv/app/web/favorite/add';

  static const String delFavPugv = '/pugv/app/web/favorite/del';

  static const String favTopicList = '/x/topic/web/fav/list';

  static const String addFavTopic = '/x/topic/fav/sub/add';

  static const String delFavTopic = '/x/topic/fav/sub/cancel';

  static const String likeTopic = '/x/topic/like';

  static const String pgcReviewL = '/pgc/review/long/list';

  static const String pgcReviewS = '/pgc/review/short/list';

  static const String pgcReviewLike = '/pgc/review/action/like';

  static const String pgcReviewDislike = '/pgc/review/action/dislike';

  static const String pgcReviewPost = '/pgc/review/short/post';

  static const String pgcReviewMod = '/pgc/review/short/modify';

  static const String pgcReviewDel = '/pgc/review/short/del';

  static const String topicPubSearch =
      '${HttpString.appBaseUrl}/x/topic/pub/search';

  static const String upowerRank = '/x/upower/up/member/rank/v2';

  static const String favFavFolder = '/x/v3/fav/folder/fav';

  static const String unfavFavFolder = '/x/v3/fav/folder/unfav';

  static const String coinArc = '${HttpString.appBaseUrl}/x/v2/space/coinarc';

  static const String likeArc = '${HttpString.appBaseUrl}/x/v2/space/likearc';

  static const String spaceSetting = '/x/space/setting/app';

  static const String spaceSettingMod = '/x/space/privacy/batch/modify';

  static const String vipExpAdd = '/x/vip/experience/add';

  static const String coinLog = '/x/member/web/coin/log';

  static const String dynTopicRcmd = '/x/topic/web/dynamic/rcmd';

  static const String matchInfo = '/x/esports/match/info';

  static const String dynPic = '/x/polymer/web-dynamic/v1/detail/pic';

  static const String msgLikeDetail = '/x/msgfeed/like_detail';

  static const String getLiveInfoByUser =
      '${HttpString.liveBaseUrl}/xlive/web-room/v1/index/getInfoByUser';

  static const String liveSetSilent =
      '${HttpString.liveBaseUrl}/liveact/user_silent';

  static const String addShieldKeyword =
      '${HttpString.liveBaseUrl}/xlive/web-ucenter/v1/banned/AddShieldKeyword';

  static const String delShieldKeyword =
      '${HttpString.liveBaseUrl}/xlive/web-ucenter/v1/banned/DelShieldKeyword';

  static const String liveShieldUser =
      '${HttpString.liveBaseUrl}/liveact/shield_user';

  static const String spaceComic = '${HttpString.appBaseUrl}/x/v2/space/comic';

  static const String spaceAudio = '/audio/music-service/web/song/upper';

  static const String spaceCheese = '/pugv/app/web/season/page';

  static const String dynMention = '/x/polymer/web-dynamic/v1/mention/search';

  static const String createVote = '/x/vote/create';

  static const String updateVote = '/x/vote/update';

  static const String createReserve = '/x/new-reserve/up/reserve/create';

  static const String updateReserve = '/x/new-reserve/up/reserve/update';

  static const String reserveInfo = '/x/new-reserve/up/reserve/info';

  static const String loginLog = '/x/member/web/login/log';

  static const String expLog = '/x/member/web/exp/log';

  static const String moralLog = '/x/member/web/moral/log';

  static const String liveLikeReport =
      '${HttpString.liveBaseUrl}/xlive/app-ucenter/v1/like_info_v3/like/likeReportV3';

  static const String loginDevices =
      '${HttpString.passBaseUrl}/x/safecenter/user_login_devices';

  static const String bgmDetail = '/x/copyright-music-publicity/bgm/detail';

  static const String wishUpdate =
      '/x/copyright-music-publicity/bgm/wish/update';

  static const String bgmRecommend =
      '/x/copyright-music-publicity/bgm/recommend_list';

  static const String spaceShop =
      '${HttpString.mallBaseUrl}/community-hub/small_shop/feed/tab/item';

  static const String superChatMsg =
      '${HttpString.liveBaseUrl}/av/v1/SuperChat/getMessageList';

  static const String popularSeriesOne = '/x/web-interface/popular/series/one';

  static const String popularSeriesList =
      '/x/web-interface/popular/series/list';

  static const String popularPrecious = '/x/web-interface/popular/precious';

  static const String userRealName = '/x/member/app/up/realname';

  static const String liveDmReport =
      '${HttpString.liveBaseUrl}/xlive/web-ucenter/v1/dMReport/Report';

  static const String danmakuLike = '/x/v2/dm/thumbup/add';

  static const String danmakuReport = '/x/dm/report/add';

  static const String danmakuRecall = '/x/dm/recall';

  static const String danmakuEditState = '/x/v2/dm/edit/state';

  static const String followedUp = '/x/relation/followings/followed_upper';

  static const String sameFollowing = '/x/relation/same/followings';

  static const String seasonStatus = '/pgc/view/web/season/user/status';

  static const String followeeVotes =
      '${HttpString.tUrl}/vote_svr/v1/vote_svr/followee_votes';

  static const String liveContributionRank =
      '${HttpString.liveBaseUrl}/xlive/general-interface/v1/rank/queryContributionRank';

  static const String superChatReport =
      '${HttpString.liveBaseUrl}/av/v1/SuperChat/report';

  static const String imMsgReport = '${HttpString.tUrl}/x/bplus/im/report/add';

  static const String dynPrivatePubSetting =
      '/x/dynamic/feed/dyn/private_pub_setting';

  static const String editDyn = '/x/dynamic/feed/edit/dyn';

  static const String replyInteraction =
      '/x/v2/reply/subject/interaction-status';

  static const String replySubjectModify = '/x/v2/reply/subject/modify';

  static const String videoshot = '/x/player/videoshot';

  static const String liveMedalWall =
      '${HttpString.liveBaseUrl}/xlive/web-ucenter/user/MedalWall';

  static const String memberGuard =
      '${HttpString.liveBaseUrl}/xlive/app-ucenter/v1/guard/MainGuardCardAll';

  static const String bubble = '/x/tribee/v1/dyn/all';

  static const String sortFollowTag = '/x/relation/tags/update_sort';
}

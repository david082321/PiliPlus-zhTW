enum VideoQuality {
  hdrVivid(129, 'HDR Vivid', 'HDR Vivid'),
  super8k(127, '8K 超高畫質', '8K'),
  dolbyVision(126, '杜比視界', '杜比'),
  hdr(125, 'HDR 真彩', 'HDR'),
  super4K(120, '4K 超高畫質', '4K'),
  high108060(116, '1080P 60幀', '1080P60'),
  high1080plus(112, '1080P 高碼率', '1080P+'),
  high1080(80, '1080P 高畫質', '1080P'),
  high72060(74, '720P 60幀', '720P60'),
  high720(64, '720P 准高畫質', '720P'),
  clear480(32, '480P 標清', '480P'),
  fluent360(16, '360P 流暢', '360P'),
  speed240(6, '240P 極速', '240P'),
  ;

  final int code;
  final String desc;
  final String shortDesc;

  const VideoQuality(this.code, this.desc, this.shortDesc);

  static final _codeMap = {for (final i in values) i.code: i};

  static VideoQuality fromCode(int code) => _codeMap[code]!;
}

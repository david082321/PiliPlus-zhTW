// mpv --hwdec=help
enum HwDecType {
  no('no', '啟用軟解'),
  auto('auto', '啟用任意可用解碼器'),
  autoSafe('auto-safe', '啟用最佳解碼器'),
  autoCopy('auto-copy', '啟用帶複製功能的最佳解碼器'),
  d3d12va('d3d12va', 'DirectX 12 (Windows10 及以上)'),
  d3d12vaCopy('d3d12va-copy', 'DirectX 12 (Windows10 及以上) (非直通)'),
  d3d11va('d3d11va', 'DirectX 11 (Windows8 及以上)'),
  d3d11vaCopy('d3d11va-copy', 'DirectX 11 (Windows8 及以上) (非直通)'),
  dxva2('dxva2', 'DXVA2 (Windows7 及以上)'),
  dxva2Copy('dxva2-copy', 'DXVA2 (Windows7 及以上) (非直通)'),
  videotoolbox('videotoolbox', 'VideoToolbox (macOS / iOS)'),
  videotoolboxCopy('videotoolbox-copy', 'VideoToolbox (macOS / iOS) (非直通)'),
  vaapi('vaapi', 'VAAPI (Linux)'),
  vaapiCopy('vaapi-copy', 'VAAPI (Linux) (非直通)'),
  nvdec('nvdec', 'NVDEC (NVIDIA獨占)'),
  nvdecCopy('nvdec-copy', 'NVDEC (NVIDIA獨占) (非直通)'),
  drm('drm', 'DRM (Linux)'),
  drmCopy('drm-copy', 'DRM (Linux) (非直通)'),
  vulkan('vulkan', 'Vulkan (全平台) (實驗性)'),
  vulkanCopy('vulkan-copy', 'Vulkan (全平台) (實驗性) (非直通)'),
  vdpau('vdpau', 'VDPAU (Linux)'),
  vdpauCopy('vdpau-copy', 'VDPAU (Linux) (非直通)'),
  mediacodec('mediacodec', 'MediaCodec (Android)'),
  mediacodecCopy('mediacodec-copy', 'MediaCodec (Android) (非直通)'),
  cuda('cuda', 'CUDA (NVIDIA獨占) (過時)'),
  cudaCopy('cuda-copy', 'CUDA (NVIDIA獨占) (過時) (非直通)'),
  crystalhd('crystalhd', 'CrystalHD (全平台) (過時)'),
  rkmpp('rkmpp', 'Rockchip MPP (僅部分Rockchip晶片)'),
  amf('amf', 'AMF (AMD獨占)'),
  amfCopy('amf-copy', 'AMF (AMD獨占) (非直通)'),
  qsv('qsv', 'Quick Sync Video (Intel獨占)'),
  qsvCopy('qsv-copy', 'Quick Sync Video (Intel獨占) (非直通)'),
  ;

  final String hwdec;
  final String desc;
  const HwDecType(this.hwdec, this.desc);
}

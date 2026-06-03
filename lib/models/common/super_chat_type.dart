enum SuperChatType {
  valid('有效時間內顯示'),
  persist('常駐顯示'),
  disable('不顯示'),
  ;

  final String title;
  const SuperChatType(this.title);
}

enum ReplySortType {
  time('最新評論', '最新', text: '按時間'),
  hot('最熱評論', '最熱', text: '按熱度'),
  select('精選評論', '精選'),
  ;

  final String title;
  final String label;
  final String? text;
  const ReplySortType(this.title, this.label, {this.text});
}

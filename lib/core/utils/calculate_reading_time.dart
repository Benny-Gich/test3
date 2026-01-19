int calculateReadingTime(String? content) {
  if(content==null)return 0;
  final wordCount = content.split(RegExp(r'\s+')).length;
  final readingTime = wordCount / 225;

  return readingTime.ceil();
}

// Model for journal entries
class JournalEntry {
  final int id;
  final String title;
  final String date;
  final String preview;
  final String content;

  JournalEntry({
    required this.id,
    required this.title,
    required this.date,
    required this.preview,
    required this.content,
  });
}
import 'package:intl/intl.dart';

class Podcast {
  String id;
  String title;
  String summary;
  String body;
  String audio;
  String duration;
  DateTime date;
  bool published;

  String get fullBody => '$summary \n $body';
  String get fullPodcastText => '$title\n\n$summary\n\n$body';
  String get localAudioName => '$id.opus';

  Podcast({
    required this.id,
    required this.title,
    required this.summary,
    required this.body,
    required this.audio,
    required this.date,
    required this.duration,
    required this.published,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'summary': summary,
      'body': body,
      'audio': audio,
      'duration': duration,
      'date': DateFormat('yyyy-MM-dd').format(date),
      'published': published,
    };
  }

  factory Podcast.fromJson(Map<String, dynamic> map) {
    return Podcast(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      summary: map['summary'] ?? '',
      body: map['body'] ?? '',
      audio: map['audio'] ?? '',
      duration: map['duration'] ?? '00:00',
      date: DateFormat('yyyy-MM-dd').parse(map['date']),
      published: (map['published'] ?? 'null').toString() == 'true',
    );
  }

  Podcast copyWith({
    String? id,
    String? title,
    String? summary,
    String? body,
    String? audio,
    DateTime? date,
    bool? published,
    String? duration,
  }) {
    return Podcast(
      id: id ?? this.id,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      body: body ?? this.body,
      audio: audio ?? this.audio,
      duration: duration ?? this.duration,
      date: date ?? this.date,
      published: published ?? this.published,
    );
  }
}

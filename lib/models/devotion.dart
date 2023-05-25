import 'package:intl/intl.dart';
import 'package:simple_flutter_app/res/utils.dart';

class Devotion {
  String? id;
  String? title;
  String? summary;
  String? body;
  String? audioPath;
  DateTime? date;
  String? datestamp;
  String? timestamp;
  bool? published;
  int? statsDownloads;

  int get dateDay => date?.day ?? 0;
  int get dateMonth => date?.month ?? 0;
  int get dateYear => date?.year ?? 0;

  String get fullBody => '$summary \n $body';
  String get fullDevotionText => '$title\n\n$summary\n\n$body';
  String get localAudioName => '$id.opus';

  bool get savedOrPublished => !Utils.isEmptyOrNull(id);

  Devotion({
    this.id,
    this.title,
    this.summary,
    this.body,
    this.audioPath,
    this.date,
    this.datestamp,
    this.timestamp,
    this.published,
    this.statsDownloads,
  });

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'title': title,
  //     'summary': summary,
  //     'body': body,
  //     'audioPath': audioPath,
  //     'date': date?.millisecondsSinceEpoch,
  //     'published': published,
  //   };
  // }

  factory Devotion.fromJson(Map<String, dynamic> map) {
    return Devotion(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      summary: map['summary'] ?? '',
      body: map['body'] ?? '',
      audioPath: map['audioPath'] ?? '',
      date: DateFormat('yyyy-MM-dd').parse(map['date']),
      published: map['published'] == '1',
      datestamp: map['datestamp'],
      timestamp: map['timestamp'],
      statsDownloads: map['stats_downloads'],
    );
  }

  Devotion copyWith({
    String? id,
    String? title,
    String? summary,
    String? body,
    String? audioPath,
    DateTime? date,
    bool? published,
    String? datestamp,
    String? timestamp,
    int? statsDownloads,
  }) {
    return Devotion(
      id: id ?? this.id,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      body: body ?? this.body,
      audioPath: audioPath ?? this.audioPath,
      date: date ?? this.date,
      published: published ?? this.published,
      datestamp: datestamp ?? this.datestamp,
      timestamp: timestamp ?? this.timestamp,
      statsDownloads: statsDownloads ?? this.statsDownloads,
    );
  }
}

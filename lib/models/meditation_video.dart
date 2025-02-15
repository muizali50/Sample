class MeditationVideo {
  String? videoId;
  String? title;
  String? status;
  String? duration;
  String? meditationCategory;
  String? mood;
  String? videoIcon;
  Map<String, List<String>>? reactions;
  String? videoUrl;

  MeditationVideo({
    this.videoId,
    this.title,
    this.status,
    this.videoIcon,
    this.duration,
    this.meditationCategory,
    this.mood,
    this.reactions,
    this.videoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'videoId': videoId,
      'title': title,
      'status': status,
      'duration': duration,
      'meditationCategory': meditationCategory,
      'mood': mood,
      'videoIcon': videoIcon,
      'reactions': reactions,
      'videoUrl': videoUrl,
    };
  }

  factory MeditationVideo.fromMap(Map<String, dynamic> map) {
    return MeditationVideo(
      videoId: map['videoId'],
      title: map['title'],
      status: map['status'],
      duration: map['duration'],
      meditationCategory: map['meditationCategory'],
      mood: map['mood'],
      videoIcon: map['videoIcon'],
      reactions: (map['reactions'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(
              key,
              List<String>.from(value),
            ),
          ) ??
          {},
      videoUrl: map['videoUrl'],
    );
  }
}

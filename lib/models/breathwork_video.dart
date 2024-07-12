class BreathworkVideo {
  String? videoId;
  String? title;
  String? status;
  String? duration;
  String? breathworkCategory;
  String? mood;
  String? videoIcon;
  Map<String, List<String>>? reactions;
  String? videoUrl;

  BreathworkVideo({
    this.videoId,
    this.title,
    this.status,
    this.videoIcon,
    this.duration,
    this.breathworkCategory,
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
      'breathworkCategory': breathworkCategory,
      'mood': mood,
      'videoIcon': videoIcon,
      'reactions': reactions,
      'videoUrl': videoUrl,
    };
  }

  factory BreathworkVideo.fromMap(Map<String, dynamic> map) {
    return BreathworkVideo(
      videoId: map['videoId'],
      title: map['title'],
      status: map['status'],
      duration: map['duration'],
      breathworkCategory: map['breathworkCategory'],
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

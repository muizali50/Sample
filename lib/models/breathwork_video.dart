class BreathworkVideo {
  String? videoId;
  String? title;
  String? status;
  String? duration;
  String? breathworkCategory;
  String? mood;
  String? videoIcon;
  String? video;
  Map<String, List<String>>? reactions;

  BreathworkVideo({
    this.videoId,
    this.title,
    this.status,
    this.videoIcon,
    this.duration,
    this.breathworkCategory,
    this.mood,
    this.video,
    this.reactions,
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
      'video': video,
      'reactions': reactions,
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
      video: map['video'],
      reactions: (map['reactions'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(
              key,
              List<String>.from(value),
            ),
          ) ??
          {},
    );
  }
}

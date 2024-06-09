class BreathworkVideo {
  String? videoId;
  String? title;
  String? status;
  String? duration;
  String? breathworkCategory;
  String? mood;
  String? videoIcon;
  String? video;

  BreathworkVideo({
    this.videoId,
    this.title,
    this.status,
    this.videoIcon,
    this.duration,
    this.breathworkCategory,
    this.mood,
    this.video,
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
    );
  }
}

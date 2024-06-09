class MeditationVideo {
  String? videoId;
  String? title;
  String? status;
  String? duration;
  String? meditationCategory;
  String? mood;
  String? videoIcon;
  String? video;

  MeditationVideo({
    this.videoId,
    this.title,
    this.status,
    this.videoIcon,
    this.duration,
    this.meditationCategory,
    this.mood,
    this.video,
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
      'video': video,
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
      video: map['video'],
    );
  }
}

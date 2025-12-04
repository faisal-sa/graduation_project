import 'package:equatable/equatable.dart';

enum FormStatus { initial, loading, success, failure }

class AboutMeState extends Equatable {
  final String summary;
  final String? videoPath;
  final String? existingVideoUrl;
  final FormStatus status;

  const AboutMeState({
    this.summary = '',
    this.videoPath,
    this.existingVideoUrl,
    this.status = FormStatus.initial,
  });

  AboutMeState copyWith({
    String? summary,
    String? videoPath,
    String? existingVideoUrl,
    FormStatus? status,
  }) {
    return AboutMeState(
      summary: summary ?? this.summary,
      videoPath: videoPath ?? this.videoPath,
      existingVideoUrl: existingVideoUrl ?? this.existingVideoUrl,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [summary, videoPath, existingVideoUrl, status];
}

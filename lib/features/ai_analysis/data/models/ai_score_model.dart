class AiScoreModel {
  final int score;
  final String summary;
  final List<String> pros;
  final List<String> cons;

  const AiScoreModel({
    required this.score,
    required this.summary,
    required this.pros,
    required this.cons,
  });

  factory AiScoreModel.fromJson(Map<String, dynamic> json) {
    return AiScoreModel(
      score: _parseInt(json['score']),
      summary: json['summary'] as String? ?? 'No summary provided.',
      pros: _parseStringList(json['pros']),
      cons: _parseStringList(json['cons']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'score': score, 'summary': summary, 'pros': pros, 'cons': cons};
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static List<String> _parseStringList(dynamic value) {
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }
    return [];
  }
}

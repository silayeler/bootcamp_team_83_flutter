class UserProgress {
  final String userId;
  final Map<String, bool> completedSections; // sectionId -> isCompleted
  final Map<String, Map<String, bool>> completedLevels; // sectionId -> levelId -> isCompleted
  final Map<String, Map<String, Map<String, bool>>> completedQuestions; // sectionId -> levelId -> questionId -> isCompleted

  UserProgress({
    required this.userId,
    required this.completedSections,
    required this.completedLevels,
    required this.completedQuestions,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'completedSections': completedSections,
      'completedLevels': completedLevels,
      'completedQuestions': completedQuestions,
    };
  }

  factory UserProgress.fromMap(Map<String, dynamic> map) {
    return UserProgress(
      userId: map['userId'],
      completedSections: Map<String, bool>.from(map['completedSections']),
      completedLevels: (map['completedLevels'] as Map<String, dynamic>).map((key, value) =>
          MapEntry(key, Map<String, bool>.from(value))),
      completedQuestions: (map['completedQuestions'] as Map<String, dynamic>).map((key, value) =>
          MapEntry(key, (value as Map<String, dynamic>).map((key2, value2) =>
              MapEntry(key2, Map<String, bool>.from(value2))))),
    );
  }
}

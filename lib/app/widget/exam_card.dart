import 'package:flutter/material.dart';
import 'package:exam_app/app/data/exam_question_data.dart';
import 'package:exam_app/app/utils/app_text_style.dart';

class ExamCard extends StatelessWidget {
  final ExamModel exam;
  final VoidCallback onStartTest;

  const ExamCard({super.key, required this.exam, required this.onStartTest});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title & Difficulty Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      exam.title,
                      style: boldStyle.copyWith(fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getDifficultyColor(
                        exam.difficulty,
                      ).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      exam.difficulty,
                      style: boldStyle.copyWith(
                        fontSize: 14,
                        color: _getDifficultyColor(exam.difficulty),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),

              /// Description
              Text(
                exam.description,
                style: normalStyle.copyWith(color: Colors.grey[700]),
              ),
              const SizedBox(height: 16),

              /// Exam Details (Time, Questions, Attempts, Pass Rate)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    _buildInfoRow(
                      Icons.timer_outlined,
                      "${exam.duration} minutes",
                      Icons.summarize_outlined,
                      "${exam.totalQuestions} questions",
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow(
                      Icons.people_alt_outlined,
                      "${exam.attempts} attempts",
                      Icons.verified_outlined,
                      "${exam.passRate}% pass rate",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// Tags
              Wrap(
                spacing: 8,
                children:
                    exam.tags
                        .map(
                          (tag) => DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey.shade100,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                tag,
                                style: subtitleStyle.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),

              const SizedBox(height: 12),

              /// Start Test Button (Aligned Right)
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  iconAlignment: IconAlignment.end,
                  onPressed: onStartTest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  label: const Text("Start Test"),
                  icon: Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds an info row with two pairs of icons and text.
  Widget _buildInfoRow(
    IconData icon1,
    String text1,
    IconData icon2,
    String text2,
  ) {
    return Row(
      children: [
        Icon(icon1, size: 18, color: Colors.grey),
        const SizedBox(width: 6),
        Expanded(child: Text(text1, style: normalStyle)),
        Icon(icon2, size: 18, color: Colors.grey),
        const SizedBox(width: 6),
        Expanded(child: Text(text2, style: normalStyle)),
      ],
    );
  }

  /// Returns color based on difficulty level.
  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Beginner":
        return Colors.green;
      case "Intermediate":
        return Colors.orange;
      case "Advanced":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

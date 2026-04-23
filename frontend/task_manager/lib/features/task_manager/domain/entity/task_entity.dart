import '../../utils/task_filter_utils.dart';

class TaskEntity {
  final String title;
  final String imagePath;
  final TaskStatus taskStatus;
  final String? subTitle;
  final bool isCompleted;
  final String id;
  TaskEntity({
    required this.title,
    required this.imagePath,
    required this.taskStatus,
    this.subTitle,
    required this.isCompleted,
    required this.id
  });
}



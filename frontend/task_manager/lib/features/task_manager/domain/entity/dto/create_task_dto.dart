class CreateTaskDto {
  final String title;
  final String? subTitle;
  final String imagePath;

  CreateTaskDto({
    required this.title,
    required this.subTitle,
    required this.imagePath,
  });
}

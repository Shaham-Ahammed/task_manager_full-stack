import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entity/task_entity.dart';
part 'tasks_state.freezed.dart';

@freezed
sealed class TaskState with _$TaskState {
  const factory TaskState({TaskEntity? task, XFile? pickedImage}) =
      _TaskState;
}

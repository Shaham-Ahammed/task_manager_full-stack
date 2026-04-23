import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entity/dto/create_task_dto.dart';
import '../../domain/entity/task_entity.dart';
import '../../utils/task_filter_utils.dart';
import '../pages/task_list_screen.dart';
import 'tasks_state.dart';

part 'task_controller.g.dart';

//dart run build_runner watch use this for generating

@riverpod
class TaskNotifier extends _$TaskNotifier {
  @override
  FutureOr<TaskState> build() {
    return TaskState();
  }

  Future uploadImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      state = AsyncData(state.value!.copyWith(pickedImage: pickedImage));
    }
  }

  void deleteImage() {
    state = AsyncData(state.value!.copyWith(pickedImage: null));
  }

  Future<void> getTask(String id) async {
    //todo: api for getting task by id
    final task = tasks.where((element) => element.id == id).first;
    state = AsyncData(
      TaskState(
        task: TaskEntity(
          subTitle: task.subTitle,
          title: task.title,
          imagePath: task.imagePath,
          taskStatus: task.taskStatus,
          isCompleted: task.isCompleted,
          id: id,
        ),
      ),
    );
  }

  void createTask(CreateTaskDto createTaskDto) {
    //todo: api for creating the task
    tasks.add(
      TaskEntity(
        title: createTaskDto.title,
        imagePath: createTaskDto.imagePath,
        taskStatus: TaskStatus.pending,
        isCompleted: false,
        id: tasks.isEmpty ? '1' : (int.parse(tasks.last.id) + 1).toString(),
      ),
    );
  }

  void updateTask() {}

  void deleteTask() {
    //todo:delete api
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../../../shared/widgets/text_field.dart';
import '../../domain/entity/dto/create_task_dto.dart';
import '../controller/task_controller.dart';

class TaskAddEditScreen extends ConsumerStatefulWidget {
  final String? id;
  const TaskAddEditScreen({super.key, this.id});

  @override
  ConsumerState<TaskAddEditScreen> createState() => _TaskAddEditScreenState();
}

class _TaskAddEditScreenState extends ConsumerState<TaskAddEditScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subTitleController = TextEditingController();

  @override
  void initState() {
    if (widget.id != null) {
      ref.read(taskProvider.notifier).getTask(widget.id!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.id != null) {
      titleController.text = ref.read(taskProvider).value?.task?.title ?? '';
      subTitleController.text =
          ref.read(taskProvider).value?.task?.subTitle ?? '';
    }

    final bool isAdd = widget.id == null;
    final controller = ref.read(taskProvider.notifier);
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isAdd ? 'Add Task' : 'Edit Task',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    final pickedImage = ref.watch(
                      taskProvider.select((state) => state.value?.pickedImage),
                    );
                    return FormField<XFile?>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null) {
                          return 'Please upload an image';
                        }
                        return null;
                      },
                      builder: (field) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.cyan,
                                  width: 2,
                                ),
                              ),
                              width: .9.sw,
                              height: .8.sw,
                              child:
                                  pickedImage != null ||
                                      ref
                                              .read(taskProvider)
                                              .value
                                              ?.task
                                              ?.imagePath !=
                                          null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Stack(
                                        children: [
                                          Image.asset(
                                            height: double.infinity,
                                            width: double.infinity,
                                            ref
                                                    .read(taskProvider)
                                                    .value
                                                    ?.task
                                                    ?.imagePath ??
                                                pickedImage!.path,
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned(
                                            right: 0,
                                            top: 0,
                                            child: IconButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStatePropertyAll(
                                                      AppColors.background,
                                                    ),
                                              ),
                                              onPressed: () {
                                                controller.deleteImage();
                                                field.didChange(null);
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: AppColors.red,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            bottom: 0,
                                            child: IconButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStatePropertyAll(
                                                      AppColors.background,
                                                    ),
                                              ),
                                              onPressed: () async {
                                                await controller.uploadImage();
                                                final newImage = ref
                                                    .read(taskProvider)
                                                    .value
                                                    ?.pickedImage;
                                                field.didChange(newImage);
                                              },
                                              icon: Icon(
                                                Icons.edit,
                                                color: AppColors.cyan,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        await controller.uploadImage();
                                        final newImage = ref
                                            .read(taskProvider)
                                            .value
                                            ?.pickedImage;
                                        field.didChange(newImage);
                                      },

                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Icon(
                                              Icons.image,
                                              color: AppColors.white,
                                              size: 64,
                                            ),
                                          ),
                                          6.verticalSpaceFromWidth,
                                          AppText('Add Image'),
                                        ],
                                      ),
                                    ),
                            ),
                            if (field.hasError)
                              AppText(
                                field.errorText ?? 'Field required',
                                color: AppColors.red,
                              ),
                          ],
                        );
                      },
                    );
                  },
                ),
                12.verticalSpaceFromWidth,
                AppTextField(title: 'Task Title', controller: titleController),
                12.verticalSpaceFromWidth,
                AppTextField(
                  required: false,
                  title: 'Task Subtitle',
                  controller: subTitleController,
                ),
                20.verticalSpaceFromWidth,
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 20.w),
                      ),
                      backgroundColor: WidgetStatePropertyAll(AppColors.cyan),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        controller.createTask(
                          CreateTaskDto(
                            title: titleController.text.trim(),
                            subTitle: subTitleController.text.trim(),
                            imagePath:
                                ref
                                    .read(taskProvider)
                                    .value
                                    ?.pickedImage
                                    ?.path ??
                                '',
                          ),
                        );
                        context.pop();
                      }
                    },
                    child: AppText('Create', color: AppColors.darkGrey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

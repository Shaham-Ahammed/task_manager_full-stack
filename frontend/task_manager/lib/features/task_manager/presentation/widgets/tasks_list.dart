import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../utils/task_filter_utils.dart';
import '../pages/task_list_screen.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<TaskFilter>(
        valueListenable: taskFilterNotifier,
        builder: (context, filter, _) {
          // UI-only: keep the task list unchanged.
          final filteredTasks = tasks;

          return ListView.separated(
            separatorBuilder: (context, index) {
              return 12.verticalSpaceFromWidth;
            },
            itemBuilder: (context, index) {
              final task = filteredTasks[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: task.isCompleted
                      ? null
                      : [
                          BoxShadow(
                            color: AppColors.darkBlue,
                            blurRadius: 16,
                            spreadRadius: 2,
                            offset: const Offset(0, 6),
                          ),
                        ],
                ),
                child: Material(
                  color: AppColors.darkGrey,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {},
                    child: Opacity(
                      opacity: task.isCompleted ? .7 : 1,
                      child: Container(
                        height: 140,
                        width: 1.sw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: task.isCompleted
                                ? AppColors.green.withValues(alpha: .6)
                                : AppColors.white.withValues(alpha: .3),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.error,size: 70,);
                                  },
                                  task.imagePath,
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: 100,
                                ),
                              ),
                              10.horizontalSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: task.isCompleted
                                              ? AppColors.green
                                              : AppColors.yellow,
                                        ),
                                      ),
                                      6.horizontalSpace,
                                      Text(
                                        task.isCompleted
                                            ? 'Completed'
                                            : 'Pending',
                                        style: TextStyle(
                                          color: task.isCompleted
                                              ? AppColors.green
                                              : AppColors.yellow,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  AppText(
                                    task.title,
                                    isHeader: true,
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: 16),
                                ],
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  context.push(
                                    RouteNames.editTask,
                                    extra: task.id,
                                  );
                                },
                                icon: Icon(Icons.edit),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: filteredTasks.length,
          );
        },
      ),
    );
  }
}

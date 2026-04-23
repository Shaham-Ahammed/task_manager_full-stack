

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../utils/task_filter_utils.dart';


class FilterMenuWidget extends StatelessWidget {
  const FilterMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TaskFilter>(
      valueListenable: taskFilterNotifier,
      builder: (context, filter, _) {
        return ValueListenableBuilder<bool>(
          valueListenable: taskFilterExpandedNotifier,
          builder: (context, expanded, _) {
            final headerLabel = filter == TaskFilter.all
                ? 'All'
                : filter == TaskFilter.pending
                ? 'Pending'
                : 'Completed';

            Widget filterOption({
              required String label,

              required VoidCallback onTap,
            }) {
              return InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.zero,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 10.w,
                  ),
                  child: AppText(label, fontweight: FontWeight.w600),
                ),
              );
            }

            final optionFilters = <TaskFilter>[
              TaskFilter.all,
              TaskFilter.pending,
              TaskFilter.completed,
            ].where((f) => f != filter).toList();

            String labelFor(TaskFilter f) {
              switch (f) {
                case TaskFilter.all:
                  return 'All';
                case TaskFilter.pending:
                  return 'Pending';
                case TaskFilter.completed:
                  return 'Completed';
              }
            }

            return Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.textColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          taskFilterExpandedNotifier.value = !expanded;
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                headerLabel,
                                fontweight: FontWeight.w600,
                                color: AppColors.cyan.shade700,
                              ),
                              Icon(
                                expanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.filter_list_alt,
                              ),
                            ],
                          ),
                        ),
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        alignment: Alignment.topCenter,
                        child: expanded
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  filterOption(
                                    label: labelFor(optionFilters[0]),

                                    onTap: () {
                                      taskFilterNotifier.value =
                                          optionFilters[0];
                                      taskFilterExpandedNotifier.value = false;
                                    },
                                  ),
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: AppColors.textColor.withValues(
                                      alpha: .3,
                                    ),
                                  ),
                                  filterOption(
                                    label: labelFor(optionFilters[1]),

                                    onTap: () {
                                      taskFilterNotifier.value =
                                          optionFilters[1];
                                      taskFilterExpandedNotifier.value = false;
                                    },
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
                12.verticalSpaceFromWidth,
              ],
            );
          },
        );
      },
    );
  }
}
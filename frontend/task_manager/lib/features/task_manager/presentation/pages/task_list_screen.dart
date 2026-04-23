import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entity/task_entity.dart';
import '../../utils/task_filter_utils.dart';
import '../widgets/empty_tasks_widget.dart';
import '../widgets/filter_menu_widget.dart';
import '../widgets/tasks_list.dart';

List<TaskEntity> tasks = [];

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: tasks.isEmpty
          ? null
          : FloatingActionButton(
              onPressed: () {
                context.push(RouteNames.addTask);
              },
              backgroundColor: AppColors.cyan.shade700,
              child: Icon(Icons.add),
            ),
      appBar: AppBar(
        title: Text('Tasks', style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: tasks.isEmpty
            ? EmptyTasksWidget()
            : Column(children: [FilterMenuWidget(), TasksList()]),
      ),
    );
  }
}

import 'package:go_router/go_router.dart';

import '../../features/task_manager/presentation/pages/task_add_edit_screen.dart';
import '../../features/task_manager/presentation/pages/task_list_screen.dart';
import 'route_names.dart';

final router = GoRouter(
  initialLocation: RouteNames.home,
  routes: [
    GoRoute(
      path: RouteNames.home,
      builder: (context, state) {
        return TaskListScreen();
      },
    ),
    GoRoute(
      path: RouteNames.addTask,
      builder: (context, state) {
        return TaskAddEditScreen();
      },
    ),
    GoRoute(
      path: RouteNames.editTask,
      builder: (context, state) {
        final String id = state.extra as String;
        return TaskAddEditScreen(id: id);
      },
      redirect: (context, state) {
        if (state.extra == null || state.extra is String == false) {
          return RouteNames.home;
        }
      },
    ),
  ],
);

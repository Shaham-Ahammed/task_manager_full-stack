import 'package:flutter/material.dart';

enum TaskStatus { pending, completed }

enum TaskFilter { all, pending, completed }

final ValueNotifier<TaskFilter> taskFilterNotifier = ValueNotifier<TaskFilter>(
  TaskFilter.all,
);
final ValueNotifier<bool> taskFilterExpandedNotifier = ValueNotifier<bool>(
  false,
);

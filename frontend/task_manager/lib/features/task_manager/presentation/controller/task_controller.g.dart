// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TaskNotifier)
const taskProvider = TaskNotifierProvider._();

final class TaskNotifierProvider
    extends $AsyncNotifierProvider<TaskNotifier, TaskState> {
  const TaskNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskNotifierHash();

  @$internal
  @override
  TaskNotifier create() => TaskNotifier();
}

String _$taskNotifierHash() => r'4cdb6e5a2f74a96ee08dbd4133f273e87d7b189b';

abstract class _$TaskNotifier extends $AsyncNotifier<TaskState> {
  FutureOr<TaskState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<TaskState>, TaskState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TaskState>, TaskState>,
              AsyncValue<TaskState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

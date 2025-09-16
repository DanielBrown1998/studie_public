class TaskNotExistsException implements Exception {
  final String message;
  TaskNotExistsException(this.message);

  @override
  String toString() {
    return message;
  }
}

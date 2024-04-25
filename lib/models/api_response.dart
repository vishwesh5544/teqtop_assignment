class ApiResponse<T> {
  final bool success;
  final T? data;
  final String message;

  ApiResponse({this.data, required this.success, required this.message});
}

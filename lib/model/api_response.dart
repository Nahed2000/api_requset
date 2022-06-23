class ApiResponse<T> {
   String message;
   bool status;
   List<T>? data ;
  ApiResponse({
    required this.message,
    required this.status,
  });
  ApiResponse.listImage({
    required this.message,
    required this.status,
    required this.data,
  });
}

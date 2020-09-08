class APIResponse<T>{
  T data; // Generic type, the data returned by the API of type T
  bool error; // Did the server returned an error or not?
  String errorMessage;// error message if error was returned


  APIResponse({this.data,this.errorMessage, this.error = false});

}
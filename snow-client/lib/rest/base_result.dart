class BaseResult<T> {
  int code;
  String msg;
  T data;
  BaseResult(this.code, this.msg, this.data);
}

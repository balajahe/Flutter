class AbstractState<T> {
  T data;
  bool waiting = false;
  bool done = false;
  String error = '';
  String filter = '';

  AbstractState(this.data);
}

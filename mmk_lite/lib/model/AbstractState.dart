class AbstractState<T> {
  T data;
  bool waiting = false;
  bool done = false;
  String error = '';
  String searchString = '';

  AbstractState(this.data);
}

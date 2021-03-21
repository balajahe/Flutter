abstract class AbstractState {
  bool waiting = false;
  bool done = false;
  String userError = '';
  String fatalError = '';
  String filter = '';
}

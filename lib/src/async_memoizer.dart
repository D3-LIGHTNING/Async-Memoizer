import 'dart:async';

final class AsyncMemoizer<T> {
  final AsynchronousComputation<T> _computation;
  Completer<T>? _completer;

  AsyncMemoizer(this._computation);

  Future<T> run() {
    if (_completer?.isCompleted ?? true) {
      _completer = Completer<T>();
      _asyncRunComputation();
    }

    return _completer!.future;
  }

  void _asyncRunComputation() async {
    try {
      T asyncResult = await _computation();

      _completer!.complete(asyncResult);
    } catch (error, stackTrace) {
      _completer!.completeError(error, stackTrace);
    }
  }
}

typedef AsynchronousComputation<T> = FutureOr<T> Function();
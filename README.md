# async_memoizer

A simple Dart utility class, `AsyncMemoizer`, to prevent re-running an asynchronous computation while it is already in progress.
 
This is useful for "debouncing" expensive operations like network requests or heavy calculations. If you request the result multiple times while the operation is in-flight, it will only be executed once, and all callers will receive the same `Future`.
 
## Usage
 
Import the library and wrap your asynchronous function in an `AsyncMemoizer`.
 
```dart
import 'dart:async';
import 'package:async_computer/async_computer.dart';

void main() async {
  // This computation takes 5 seconds to complete.
  final computer =
      AsyncMemoizer(() => Future.delayed(const Duration(seconds: 5), () => 42));

  // 1. Start the computation.
  print('First call at 0s');
  computer.run().then((value) => print('First computation result: $value (at ~5s)'));

  // 2. After 2 seconds, request the result again.
  // The computation is still running, so a new one is NOT started.
  // Instead, we get the Future for the operation that is already in progress.
  Future.delayed(const Duration(seconds: 2), () {
    print('Second call at 2s');
    computer.run().then((value) => print('Second computation result: $value (at ~5s)'));
  });

  // Both `then` callbacks will fire at roughly the 5-second mark.
}
```

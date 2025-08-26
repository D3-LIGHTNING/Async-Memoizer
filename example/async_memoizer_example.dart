import 'package:async_memoizer/src/async_memoizer.dart';

void main() {
  final AsyncMemoizer<int> memoizer =
      AsyncMemoizer(() => Future.delayed(const Duration(seconds: 5), () => 42));

  memoizer.run().then((value) => print('First call result: $value'));

  Future.delayed(
    const Duration(seconds: 1),
    () => memoizer.run().then((value) => print('Second call result: $value')),
  );
}
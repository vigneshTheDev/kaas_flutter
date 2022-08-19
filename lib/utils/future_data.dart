import 'package:flutter/material.dart';

enum FutureState {
  inactive,
  loading,
  complete,
  failed,
}

class FutureData<T> {
  Future<T> future;

  ValueNotifier<FutureState> state = ValueNotifier(FutureState.inactive);
  ValueNotifier<T?> data = ValueNotifier(null);
  ValueNotifier<String> error = ValueNotifier('');

  VoidCallback? _onFinish;

  FutureData(this.future) {
    waiter();
  }

  then(VoidCallback onFinish) {
    _onFinish = onFinish;
  }

  waiter() async {
    _setState(FutureState.loading);
    try {
      final data = await future;
      _setData(data);
      _setState(FutureState.complete);
    } catch (ex) {
      _setError('Something went wrong');
      _setState(FutureState.failed);
    } finally {
      final onFinish = _onFinish;
      if (onFinish != null) onFinish();
    }
  }

  _setState(FutureState s) {
    state.value = s;
  }

  _setError(String e) {
    error.value = e;
  }

  _setData(T d) {
    data.value = d;
  }
}

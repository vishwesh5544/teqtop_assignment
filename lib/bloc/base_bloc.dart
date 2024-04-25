import 'dart:async';

import 'package:flutter_assignment/bloc/base_event.dart';
import 'package:flutter_assignment/bloc/base_state.dart';
import 'package:flutter_assignment/service/base_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseBloc extends Bloc<BaseEvent, BaseState> {
  final BaseService _service;

  BaseBloc(this._service) : super(InitialState()) {
    on<FetchProducts>(_fetchProducts);
  }

  FutureOr<void> _fetchProducts(FetchProducts event, Emitter<BaseState> emit) async {
    final response = await _service.getAllDummyData();
    if (response.success) {
      emit(ProductsLoaded(products: response.data!.products));
    } else {
      emit(ProductsError(message: response.message));
    }
  }
}

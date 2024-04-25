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
    emit(ProductsLoading());
    final response = await _service.getAllDummyData();
    if (response.success && response.data != null) {
      if (response.data!.products.isEmpty) {
        emit(ProductsLoaded(products: response.data!.products, isDataFound: false));
        return;
      }

      emit(ProductsLoaded(products: response.data!.products, isDataFound: true));
    } else {
      emit(ProductsError(message: response.message));
    }
  }
}

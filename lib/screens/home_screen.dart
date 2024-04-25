import 'package:flutter/material.dart';
import 'package:flutter_assignment/bloc/base_bloc.dart';
import 'package:flutter_assignment/bloc/base_event.dart';
import 'package:flutter_assignment/bloc/base_state.dart';
import 'package:flutter_assignment/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> _products = [];
  late final BaseBloc _bloc;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc = BlocProvider.of<BaseBloc>(context);
      _fetchProducts();
    });
  }

  void _fetchProducts() async {
    _bloc.add(FetchProducts());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Products', style: TextStyle(color: Colors.white)),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
        onPressed: () => _fetchProducts(),
        child: const Icon(Icons.refresh),
      ),

      /// body
      body: BlocConsumer<BaseBloc, BaseState>(

        /// listener
        listener: (context, state) {
          if (state is ProductsLoaded) {
            Fluttertoast.showToast(msg: 'Products loaded successfully');
            setState(() {
              _products = state.products;
            });
          }
        },

        /// builder
        builder: (context, state) {

          /// loading state
          if (state is ProductsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          /// loaded state
          else if (state is ProductsLoaded) {
            return ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return ListTile(
                  title: Text(product.title),
                  subtitle: Text(product.price.toString()),
                );
              },
            );
          }

          else if (state is ProductsError) {
            return Center(
              child: Text(state.message),
            );
          }

          /// error state
          else {
            return Center(child: const CircularProgressIndicator());
          }
        },
      )
    );
  }
}

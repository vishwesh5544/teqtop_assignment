import 'package:cached_network_image/cached_network_image.dart';
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

              /// no data found
              if (state.isDataFound == false) {
                return const Center(
                  child: Column(
                    children: [
                      Icon(Icons.sentiment_dissatisfied),
                      SizedBox(height: 10),
                      Text('No data found'),
                    ],
                  ),
                );
              }

              /// data found
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: ListView.builder(
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    final product = _products[index];
                    return ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(product.thumbnail),
                      ),
                      title: Text(product.title),
                      subtitle: Text("Price: ${product.price}"),
                    );
                  },
                ),
              );
            }

            /// error state
            else if (state is ProductsError) {
              return Center(
                child: Column(
                  children: [
                    const Icon(Icons.error),
                    const SizedBox(height: 10),
                    Text(state.message),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => _fetchProducts(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            /// default
            else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}

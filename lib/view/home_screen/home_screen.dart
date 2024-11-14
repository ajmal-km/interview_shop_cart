import 'package:flutter/material.dart';
import 'package:interview_shop_cart/controller/home_controller.dart';
import 'package:interview_shop_cart/view/product_screen/product_screen.dart';
import 'package:provider/provider.dart';

import 'widgets/product_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<HomeController>().fetchProducts();
      },
    );
    super.initState();
  }

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  final rateController = TextEditingController();
  final ratingCountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        surfaceTintColor: Colors.indigo,
        centerTitle: true,
        title: Text(
          "Fake Store",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.6,
          ),
        ),
      ),
      body: Builder(
        builder: (context) {
          if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: Colors.indigo),
            );
          } else if (state.isError) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Text(
                  state.error,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.7,
                  ),
                ),
              ),
            );
          } else {
            return GridView.builder(
              padding: EdgeInsets.all(16),
              itemCount: state.products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 300,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) => ProductGrid(
                image: state.products[index].image.toString(),
                title: state.products[index].title.toString(),
                price: state.products[index].price.toString(),
                onProductTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductScreen(
                        productId: state.products[index].id.toString(),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
        backgroundColor: Colors.indigo,
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.white,
            context: context,
            builder: (context) {
              return Consumer<HomeController>(
                builder: (context, homestate, child) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: double.infinity,
                    alignment:
                        homestate.isBottomLoading ? Alignment.center : null,
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    color: Colors.white,
                    child: Builder(builder: (context) {
                      if (homestate.isBottomLoading) {
                        return CircularProgressIndicator(color: Colors.indigo);
                      }
                      if (homestate.isError) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            textAlign: TextAlign.center,
                            state.error,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.7,
                            ),
                          ),
                        );
                      }
                      return ListView(
                        children: <Widget>[
                          TextFormField(
                            onTapOutside: (event) {
                              FocusManager.instance.primaryFocus!.unfocus();
                            },
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: "Product Name",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter product ";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            onTapOutside: (event) {
                              FocusManager.instance.primaryFocus!.unfocus();
                            },
                            controller: descriptionController,
                            decoration: InputDecoration(
                              hintText: "Product Description",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter product description";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            onTapOutside: (event) {
                              FocusManager.instance.primaryFocus!.unfocus();
                            },
                            controller: priceController,
                            decoration: InputDecoration(
                              hintText: "Product Price",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter product price";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            onTapOutside: (event) {
                              FocusManager.instance.primaryFocus!.unfocus();
                            },
                            controller: categoryController,
                            decoration: InputDecoration(
                              hintText: "Product Category",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter product category";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            onTapOutside: (event) {
                              FocusManager.instance.primaryFocus!.unfocus();
                            },
                            controller: rateController,
                            decoration: InputDecoration(
                              hintText: "Product Rating",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter product rating";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            onTapOutside: (event) {
                              FocusManager.instance.primaryFocus!.unfocus();
                            },
                            controller: ratingCountController,
                            decoration: InputDecoration(
                              hintText: "Product Rating Count",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter product rating count";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    height: 45,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.indigo,
                                    ),
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.2),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    await context
                                        .read<HomeController>()
                                        .addProduct(
                                          title: nameController.text,
                                          description:
                                              descriptionController.text,
                                          price: priceController.text,
                                          category: categoryController.text,
                                          ratings: rateController.text,
                                          ratingCount:
                                              ratingCountController.text,
                                        )
                                        .then(
                                      (value) {
                                        Navigator.pop(context);
                                        context
                                            .read<HomeController>()
                                            .fetchProducts();
                                      },
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text(
                                              state.message,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )));
                                  },
                                  child: Container(
                                    height: 45,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.indigo,
                                    ),
                                    child: Text(
                                      "Add Product",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: -0.2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

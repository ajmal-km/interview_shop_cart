import 'package:flutter/material.dart';
import 'package:interview_shop_cart/controller/product_controller.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<ProductController>().fetchProduct(widget.productId);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productState = context.watch<ProductController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        surfaceTintColor: Colors.indigo,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
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
          if (productState.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: Colors.indigo),
            );
          } else if (productState.isError) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Text(
                  productState.error,
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
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(16),
                    children: <Widget>[
                      Container(
                        height: 480,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(
                                productState.product!.image.toString()),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        productState.product!.title.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.4,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "${productState.product!.rating!.rate.toString()} - (${productState.product!.rating!.count} ratings)",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.4,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        productState.product!.description.toString(),
                        style: TextStyle(
                          color: Color(0xFF555555),
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    border: Border.all(width: 1.6, color: Colors.indigo),
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Price : \$ ${productState.product!.price.toString()}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 140,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Add to cart",
                              style: TextStyle(
                                color: Colors.indigo,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

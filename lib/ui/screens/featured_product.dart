import 'package:ecommer_user_side/models/productModel.dart';
import 'package:ecommer_user_side/provider/products_provider.dart';
import 'package:ecommer_user_side/ui/widgets/list_item_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class Featured extends StatefulWidget {
  @override
  _FeaturedState createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: FutureBuilder<List<Products>>(
        future: Provider.of<ProductsProvider>(context).setProducts(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<Products> products = snapshot.data;
            if (products.length > 0) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      child: ListItem2(
                        products: products[index],
                      
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          } else {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.black,
                size: 50.0,
              ),
            );
          }
        },
      ),
    );
  }
}

import 'package:ecommer_user_side/models/productModel.dart';
import 'package:ecommer_user_side/provider/products_provider.dart';
import 'package:ecommer_user_side/ui/widgets/list_item_2.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<ProductsProvider>(context);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Search',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (val) async {
                if (val == '' || val == null) {
                } else {
                  await Provider.of<ProductsProvider>(context, listen: false)
                      .searchProductToCard(val);
                }
              },
              decoration: InputDecoration(
                  prefixIcon: IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.arrow_back),
                    iconSize: 20.0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  contentPadding: EdgeInsets.only(left: 25.0),
                  hintText: 'Search by name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0))),
            ),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: Consumer<ProductsProvider>(
              builder:
                  (BuildContext context, ProductsProvider value, Widget child) {
                List<Products> pr = value.products2;
                if (pr.length > 0) {
                  return GridView.builder(
                    itemCount: pr.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 0.7),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 10,
                          bottom: 10,
                        ),
                        child: ListItem2(
                          products: pr[index],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('NO Result Search'),
                  );
                }
              },
            ),
          )
        ]));
  }
}

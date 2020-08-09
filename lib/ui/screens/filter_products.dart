import 'package:ecommer_user_side/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:ecommer_user_side/provider/filter_provider.dart';
import 'package:provider/provider.dart';

import 'filter_product_details.dart';

class FilterProducts extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 370, height: 810);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Filter",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Color(0xff000000),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Consumer<FilterProvider>(
            builder:
                (BuildContext context, FilterProvider value, Widget child) {
              return ExpansionTile(
                title: Text(
                  "Color",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Color(0xff000000),
                  ),
                ),
                subtitle: Text(
                  value.selectedNameColor == null ||
                          value.selectedNameColor == ''
                      ? "No Color"
                      : value.selectedNameColor,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff000000).withOpacity(0.60),
                  ),
                ),
                children: <Widget>[
                  SizedBox(
                    height: 70,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: value.colors.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 50,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color: value.colors[index],
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                            ),
                            onTap: () {
                              value.changeSeclectedColor(index);
                            },
                          );
                        }),
                  ),
                ],
              );
            },
          ),
          Consumer<FilterProvider>(
            builder:
                (BuildContext context, FilterProvider value, Widget child) {
              return ExpansionTile(
                title: Text(
                  "Price",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Color(0xff000000),
                  ),
                ),
                subtitle: Text(
                  value.price == 200 ? "No Price" : value.price.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff000000).withOpacity(0.60),
                  ),
                ),
                children: <Widget>[
                  Center(
                    child: Slider(
                        max: 1000,
                        min: 100,
                        value: value.price.toDouble(),
                        onChanged: (double value1) =>
                            value.changePrice(value1)),
                  )
                ],
              );
            },
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 12,
              ),
              SizedBox(
                width: 90,
                child: Text(
                  "categories",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Container(child: Consumer<FilterProvider>(
                  builder: (BuildContext context, FilterProvider value,
                      Widget child) {
                    return DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          value: value.selectedCategories,
                          items: value.categories
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value1) =>
                              value.changeSelectedCategories(value1),
                        ),
                      ),
                    );
                  },
                )),
              ),
              SizedBox(
                width: 12,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 12,
              ),
              SizedBox(
                width: 90,
                child: Text(
                  "Size",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Container(child: Consumer<FilterProvider>(
                  builder: (BuildContext context, FilterProvider value,
                      Widget child) {
                    return DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          value: value.selectedSize,
                          items: value.sizes
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value1) =>
                              value.changeSelectedSize(value1),
                        ),
                      ),
                    );
                  },
                )),
              ),
              SizedBox(
                width: 12,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
        height: ScreenUtil().setHeight(100),
        width: ScreenUtil().setWidth(200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Center(
              child: SizedBox(
                height: ScreenUtil().setHeight(50),
                width: ScreenUtil().setWidth(150),
                child: FlatButton(
                  onPressed: () async {
                    await Provider.of<FilterProvider>(context, listen: false)
                        .cleanFilter();
                  },
                  shape: BeveledRectangleBorder(
                      side: BorderSide(color: Colors.green)),
                  child: const Text('CLEAR',
                      style: TextStyle(color: Colors.black)),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
                height: ScreenUtil().setHeight(50),
                width: ScreenUtil().setWidth(150),
                child: Consumer<FilterProvider>(
                  builder: (BuildContext context, FilterProvider value,
                      Widget child) {
                    return GestureDetector(
                      onTap: () async {
                        if (value.selectedNameColor == null ||
                            value.price == null ||
                            value.categories == null) {
                          scaffoldKey.currentState.showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Fill all Recourd')));
                        } else {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      FiltersProductsDetails()));
                        }
                      },
                      child: Container(
                        height: ScreenUtil().setHeight(60),
                        width: ScreenUtil().setWidth(300),
                        decoration: BoxDecoration(
                          color: Color(0xff00c569),
                          borderRadius: BorderRadius.circular(4.00),
                        ),
                        child: Center(
                          child: Text(
                            'APPLY',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}

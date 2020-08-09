import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class StepperDelivery extends StatefulWidget {
  @override
  _StepperDeliveryState createState() => _StepperDeliveryState();
}

class _StepperDeliveryState extends State<StepperDelivery> {
  int groupValueRadioDelivery = 0;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 370, height: 810);

    return Column(
      children: <Widget>[
        SizedBox(
          height: ScreenUtil().setHeight(30),
        ),
        RadioListTile(
            dense: true,
            isThreeLine: true,
            activeColor: Colors.green,
            title: Text(
              "Standard Delivery",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Color(0xff000000),
              ),
            ),
            subtitle: Text(
              "Order will be delivered between 3 - 5 business days",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff000000),
              ),
            ),
            value: 0,
            groupValue: groupValueRadioDelivery,
            onChanged: (v) {
              setState(() {
                groupValueRadioDelivery = v;
              });
            }),
        SizedBox(
          height: ScreenUtil().setHeight(30),
        ),
        RadioListTile(
            dense: true,
            isThreeLine: true,
            activeColor: Colors.green,
            title: Text(
              "Next Day Delivery",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Color(0xff000000),
              ),
            ),
            subtitle: Text(
              "Place your order before 6pm and your items will be delivered the next day",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff000000),
              ),
            ),
            value: 1,
            groupValue: groupValueRadioDelivery,
            onChanged: (v) {
              setState(() {
                groupValueRadioDelivery = v;
              });
            }),
        SizedBox(
          height: ScreenUtil().setHeight(30),
        ),
        RadioListTile(
            activeColor: Colors.green,
            title: Text(
              "Nominated Delivery",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Color(0xff000000),
              ),
            ),
            subtitle: Text(
              "Pick a particular date from the calendar and order will be delivered on selected date",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff000000),
              ),
            ),
            value: 2,
            dense: true,
            isThreeLine: true,
            groupValue: groupValueRadioDelivery,
            onChanged: (v) {
              setState(() {
                groupValueRadioDelivery = v;
              });
            }),
        SizedBox(
          height: ScreenUtil().setHeight(50),
        ),
      ],
    );
  }
}

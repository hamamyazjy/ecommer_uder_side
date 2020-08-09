 
import 'package:ecommer_user_side/ui/widgets/stepper_address.dart';
import 'package:ecommer_user_side/ui/widgets/stepper_delivery.dart';
import 'package:fa_stepper/fa_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
 
class CheckoutScreen extends StatefulWidget {
  final int order;
  final int id;
  CheckoutScreen({this.order, this.id});
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _currentStep = 0;
  List<FAStep> _mystep() {
    List<FAStep> _steps = [
      FAStep(
          state: _currentStep > 0 ? FAStepstate.complete : FAStepstate.editing,
          title: Text(
            "Delivery",
            style: TextStyle(
              fontSize: 12,
              color: Color(0xff000000),
            ),
          ),
          content: StepperDelivery()),
      FAStep(
        // isActive: _currentStep > 1,
        state: _currentStep > 1 ? FAStepstate.complete : FAStepstate.editing,
        title: Text(
          "Address",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xff000000).withOpacity(0.50),
          ),
        ),

        content: StepperAddress(),
      ),
      // FAStep(
      //     // isActive: _currentStep > 2,
      //     // state: FAStepstate.complete,
      //     state: _currentStep > 2 ? FAStepstate.complete : FAStepstate.editing,
      //     title: Text(
      //       "Payments",
      //       textAlign: TextAlign.right,
      //       style: TextStyle(
      //         fontFamily: "SF Pro Display",
      //         fontSize: 12,
      //         color: Color(0xff000000).withOpacity(0.50),
      //       ),
      //     ),
      //     content: StepperPayment()),
    ];
    return _steps;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 370, height: 810);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Checkout",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Color(0xff000000),
          ),
        ),
      ),
      body: Container(
        child: FAStepper(
          currentStep: _currentStep,
          type: FAStepperType.horizontal,
          controlsBuilder: (BuildContext context,
              {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
            return Row(
              children: <Widget>[
                _currentStep == 0
                    ? Container()
                    : FlatButton(
                        onPressed: onStepCancel,
                        shape: BeveledRectangleBorder(
                            side: BorderSide(color: Colors.green)),
                        child: const Text('Back',
                            style: TextStyle(color: Colors.black)),
                        color: Colors.white,
                      ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                FlatButton(
                  onPressed: onStepContinue,
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.green,
                ),
              ],
            );
          },
          steps: _mystep(),
          onStepTapped: (step) {
            _currentStep = step;
            setState(() {});
          },
          onStepContinue: () async {
            setState(() {});
            if (_currentStep < _mystep().length) {
              switch (_currentStep) {
                case 0:
                  break;

                case 1:
                  // switch (widget.order) {
                  //   case 0:
                  //     print('dddddd');
                  //     await Provider.of<CardProvider>(context, listen: false)
                  //         .deleteProductFormSqlByIdAndAddToOrderFireStore(
                  //             widget.id);
                  //     Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //         builder: (BuildContext context) => MyOrders()));
                  //     break;
                  //   case 1:
                  //     print('ddddsssssssssssssss');
                  //     await Provider.of<CardProvider>(context, listen: false)
                  //         .deleteAllProductFormSqlAndAddToOrderFireStore();
                  //     Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //         builder: (BuildContext context) => MyOrders()));
                  //     print('object');
                  //     break;
                  //   default:
                  // }

                  break;
              }
              _currentStep++;
            } else {
              print('Complete');
            }
          },
          onStepCancel: () {
            setState(() {
              if (_currentStep > 0) {
                _currentStep--;
              } else {
                _currentStep = 0;
              }
            });
          },
        ),
      ),
    );
  }
}

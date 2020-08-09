import 'package:ecommer_user_side/models/on_bording_model.dart';
import 'package:flutter/material.dart';

class SingleOnBoarding extends StatelessWidget {
  final OnBoardingModel onBoardingModel;
  SingleOnBoarding({this.onBoardingModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * .95,
          height: MediaQuery.of(context).size.height * .3,
          child: Image(
            image: ExactAssetImage(onBoardingModel.image),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          onBoardingModel.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            color: Color(0xff1c1a1a),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text(
            onBoardingModel.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              // height: 1.5,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xff707070),
            ),
          ),
        ),
      ],
    );
  }
}

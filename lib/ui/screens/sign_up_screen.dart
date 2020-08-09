import 'package:ecommer_user_side/auth/auth_firebase.dart';
import 'package:ecommer_user_side/provider/auth_provider.dart';
import 'package:ecommer_user_side/ui/widgets/custom_text_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  Animation animation, delayedAnimation, muchDelayedAnimation;
  AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));
    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn)));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 370, height: 810);
    double width = MediaQuery.of(context).size.width;
    animationController.forward();

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return Scaffold(
            key: FbAuth.auth.scaffoldKeyRegister,
            resizeToAvoidBottomPadding: false,
            body: Column(children: <Widget>[
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                    // color: Color(0xFF075C93),
                    gradient: LinearGradient(colors: <Color>[
                      Color(0xFF075C93),
                      Color(0xFF079893),
                    ], begin: Alignment.topRight, end: Alignment.bottomCenter),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(170))),
                child: Transform(
                  transform:
                      Matrix4.translationValues(animation.value * width, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 50.00,
                        width: 100.00,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Signup',
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Transform(
              //   transform:
              //       Matrix4.translationValues(animation.value * width, 0, 0),
              //   child: Container(
              //     child: Stack(
              //       children: <Widget>[
              //         Container(
              //           padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
              //           child: Text(
              //             'Signup',
              //             style: TextStyle(
              //                 fontSize: 80.0, fontWeight: FontWeight.bold),
              //           ),
              //         ),
              //         Container(
              //           padding: EdgeInsets.fromLTRB(260.0, 125.0, 0.0, 0.0),
              //           child: Text(
              //             '.',
              //             style: TextStyle(
              //                 fontSize: 80.0,
              //                 fontWeight: FontWeight.bold,
              //                 color: Colors.green),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              Consumer<AuthProvider>(builder: (context, authProvider, widget) {
                return Transform(
                  transform: Matrix4.translationValues(
                      delayedAnimation.value * width, 0, 0),
                  child: Form(
                      key: authProvider.formKeyRegister,
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                        child: Column(
                          children: <Widget>[
                            CustomTextField(
                              onSave: authProvider.saveUserName,
                              onValidator: authProvider.validatorUserName,
                              hintText: 'Name',
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(25),
                            ),
                            CustomTextField(
                              onSave: authProvider.saveEmail,
                              onValidator: authProvider.validatorEmail,
                              hintText: 'Email',
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(25),
                            ),
                            CustomTextField(
                              onSave: authProvider.savePaswword,
                              onValidator: authProvider.validatorPaswword,
                              hintText: 'Password',
                              keyboardType: TextInputType.visiblePassword,
                            ),
                          ],
                        ),
                      )),
                );
              }),
              Transform(
                transform: Matrix4.translationValues(
                    muchDelayedAnimation.value * width, 0, 0),
                child: Container(
                    padding:
                        EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            await Provider.of<AuthProvider>(context,
                                    listen: false)
                                .onSubmitRegister(context);
                          },
                          child: Container(
                            height: 40.0,
                            width: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(0xFF075C93),
                                    Color(0xFF079893),
                                  ],
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomCenter),
                            ),
                            child: Center(
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(25)),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 40.0,
                            width: 250,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [BoxShadow(color: Colors.black)]),
                              child: Center(
                                child: Text('GO Back',
                                    style: TextStyle(
                                      color: Color(0xFF075C93),
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ]));
      },
    );
  }
}

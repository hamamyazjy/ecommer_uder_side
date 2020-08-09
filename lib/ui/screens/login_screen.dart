import 'package:ecommer_user_side/auth/auth_firebase.dart';
import 'package:ecommer_user_side/provider/auth_provider.dart';
import 'package:ecommer_user_side/ui/screens/sign_up_screen.dart';
import 'package:ecommer_user_side/ui/widgets/custom_text_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'home_screen.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
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
        return SafeArea(
          child: Scaffold(
              key: FbAuth.auth.scaffoldKeyLogin,
              resizeToAvoidBottomPadding: false,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                              // color: Color(0xFF075C93),
                              gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(0xFF075C93),
                                    Color(0xFF079893),
                                  ],
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomCenter),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(170))),
                          child: Transform(
                            transform: Matrix4.translationValues(
                                animation.value * width, 0, 0),
                            child: Container(
                              height: 50.00,
                              width: 100.00,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/logo.png'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Container(
                        //   padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                        //   child: Text('Hello',
                        //       style: TextStyle(
                        //           fontSize: 80.0,
                        //           fontWeight: FontWeight.bold)),
                        // ),
                        // Container(
                        //   padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                        //   child: Text('There',
                        //       style: TextStyle(
                        //           fontSize: 80.0,
                        //           fontWeight: FontWeight.bold)),
                        // ),
                        // Container(
                        //   padding:
                        //       EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
                        //   child: Text('.',
                        //       style: TextStyle(
                        //           fontSize: 80.0,
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.green)),
                        // )
                      ],
                    ),
                  ),
                  Transform(
                    transform: Matrix4.translationValues(
                        delayedAnimation.value * width, 0, 0),
                    child: Container(
                        padding:
                            EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                        child: Column(
                          children: <Widget>[
                            Consumer<AuthProvider>(
                                builder: (context, authProvider, widget) {
                              return Form(
                                key: authProvider.formKeyLogin,
                                child: Column(
                                  children: <Widget>[
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
                                      onValidator:
                                          authProvider.validatorPaswword,
                                      hintText: 'Password',
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                    ),
                                  ],
                                ),
                              );
                            }),
                            SizedBox(height: ScreenUtil().setHeight(10)),
                            Container(
                              alignment: Alignment(1.0, 0.0),
                              padding: EdgeInsets.only(top: 15.0, left: 20.0),
                              child: InkWell(
                                child: Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                      color: Color(0xFF075C93),
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            HomeScreen()));
                              },
                              child: Container(
                                alignment: Alignment(-1.0, 0.0),
                                child: Text(
                                  "Browse as a visitor",
                                  style: TextStyle(
                                      color: Color(0xFF075C93),
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ),
                            SizedBox(height: 40.0),
                            GestureDetector(
                              onTap: () async {
                                await Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .onSubmitLogin(context);
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
                                    'LOGIN',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            GestureDetector(
                              onTap: () async {
                                await Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .loginUsingGmail(context);
                              },
                              child: Container(
                                height: 40.0,
                                width: 250,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFFFFFF),
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [
                                        BoxShadow(color: Colors.black)
                                      ]),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Center(
                                        child: Icon(
                                          FontAwesomeIcons.google,
                                          // color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      Center(
                                        child: Text('Sign in With Google',
                                            style: TextStyle(
                                              color: Color(0xFF075C93),
                                              fontWeight: FontWeight.bold,
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                  SizedBox(height: 15.0),
                  Transform(
                    transform: Matrix4.translationValues(
                        muchDelayedAnimation.value * width, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Don\'t have an account ?',
                        ),
                        SizedBox(width: 5.0),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => SignUp()));
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                                color: Color(0xFF075C93),
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
        );
      },
    );
  }
}

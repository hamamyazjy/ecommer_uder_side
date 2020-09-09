import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommer_user_side/constant.dart';
import 'package:ecommer_user_side/helper/shared_helper.dart';
import 'package:ecommer_user_side/provider/auth_provider.dart';
import 'package:ecommer_user_side/ui/widgets/custom_drawer.dart';
import 'package:ecommer_user_side/ui/widgets/custom_text_filed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserInformation();
  }

  getUserInformation() async {
    nameController.text = await ShaerdHelper.sHelper.getUserName();
    emailController.text = await ShaerdHelper.sHelper.getEmail();
    mobileController.text = await ShaerdHelper.sHelper.getMobile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text('PROFILE',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  // color: Colors.black
                  )),
        ),
        drawer: CustomDrawer(),
        body: Container(
          // color: Colors.white,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 250.0,
                    // color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Stack(fit: StackFit.loose, children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FutureBuilder<List<String>>(
                                  future: Provider.of<AuthProvider>(context)
                                      .getInformationUser(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.hasData) {
                                      List<String> info = snapshot.data;

                                      if (info[1] == null) {
                                        return CircleAvatar(
                                          maxRadius: 69,
                                          backgroundImage:
                                              Provider.of<AuthProvider>(context,
                                                              listen: false)
                                                          .imageFile ==
                                                      null
                                                  ? AssetImage(
                                                      'assets/images/splash_screen.png',
                                                    )
                                                  : FileImage(
                                                      Provider.of<AuthProvider>(
                                                              context,
                                                              listen: false)
                                                          .imageFile),
                                        );
                                      } else {
                                        return CircleAvatar(
                                          maxRadius: 69,
                                          backgroundImage:
                                              Provider.of<AuthProvider>(context,
                                                              listen: false)
                                                          .imageFile ==
                                                      null
                                                  ? CachedNetworkImageProvider(
                                                       info[1],
                                                    )
                                                  : FileImage(
                                                      Provider.of<AuthProvider>(
                                                              context,
                                                              listen: false)
                                                          .imageFile),
                                        );
                                      }
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ],
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.only(top: 90.0, right: 100.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () async {
                                        showCupertinoModalPopup(
                                            context: context,
                                            builder: (context) {
                                              return CupertinoActionSheet(
                                                title: Text(
                                                  'Upload Image',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.green),
                                                ),
                                                message:
                                                    Text("Select any action "),
                                                actions: <Widget>[
                                                  CupertinoActionSheetAction(
                                                    child: Text(
                                                        "Upload image with camera"),
                                                    // isDefaultAction: true,
                                                    onPressed: () async {
                                                      await Provider.of<
                                                                  AuthProvider>(
                                                              context,
                                                              listen: false)
                                                          .cameraImage(
                                                              ImageSource
                                                                  .camera);
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  CupertinoActionSheetAction(
                                                    child: Text(
                                                        "Upload image with Gallery"),
                                                    // isDestructiveAction: true,
                                                    onPressed: () async {
                                                      await Provider.of<
                                                                  AuthProvider>(
                                                              context,
                                                              listen: false)
                                                          .cameraImage(
                                                              ImageSource
                                                                  .gallery);
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                                cancelButton:
                                                    CupertinoActionSheetAction(
                                                  child: Text("Cancel"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              );
                                            });
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.red,
                                        radius: 25,
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ]),
                        )
                      ],
                    ),
                  ),
                  Form(
                      key:
                          Provider.of<AuthProvider>(context).formKeyEditProfile,
                      child: Container(
                        // color: Color(0xffFFFFFF),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 0.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Text(
                                        'Parsonal Information',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Name',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Flexible(
                                          child: CustomTextField(
                                        controller: nameController,
                                        keyboardType: TextInputType.text,
                                        onSave:
                                            Provider.of<AuthProvider>(context)
                                                .saveUserName,
                                        onValidator:
                                            Provider.of<AuthProvider>(context)
                                                .validatorUserName,
                                      )),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Email',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Flexible(
                                          child: CustomTextField(
                                        controller: emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onSave:
                                            Provider.of<AuthProvider>(context)
                                                .saveEmail,
                                        onValidator:
                                            Provider.of<AuthProvider>(context)
                                                .validatorEmail,
                                      )),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Mobile',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Flexible(
                                        child: CustomTextField(
                                          controller: mobileController,
                                          hintText: 'Enter Mobile',
                                          keyboardType: TextInputType.number,
                                          onSave:
                                              Provider.of<AuthProvider>(context)
                                                  .saveMobile,
                                          onValidator:
                                              Provider.of<AuthProvider>(context)
                                                  .validatorMobile,
                                        ),
                                      ),
                                    ],
                                  )),

                              Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 45.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: Container(
                                            child: RaisedButton(
                                          child: Text("Save"),
                                          textColor: Colors.white,
                                          color: Colors.green,
                                          onPressed: () async {
                                            await Provider.of<AuthProvider>(
                                                    context,
                                                    listen: false)
                                                .onSubmitEditProfile(context);
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                        )),
                                      ),
                                      flex: 2,
                                    ),
                                    // Expanded(
                                    //   child: Padding(
                                    //     padding: EdgeInsets.only(left: 10.0),
                                    //     child: Container(
                                    //         child: new RaisedButton(
                                    //       child: new Text("Cancel"),
                                    //       textColor: Colors.white,
                                    //       color: Colors.red,
                                    //       onPressed: () {},
                                    //       shape: new RoundedRectangleBorder(
                                    //           borderRadius:
                                    //               new BorderRadius.circular(20.0)),
                                    //     )),
                                    //   ),
                                    //   flex: 2,
                                    // ),
                                  ],
                                ),
                              ),

                              // !_status ? _getActionButtons() : new Container(),
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ],
          ),
        ));
  }
}

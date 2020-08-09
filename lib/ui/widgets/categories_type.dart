import 'package:ecommer_user_side/models/type_model.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final TypeModel typeModel;

  const CategoryWidget({Key key, this.typeModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Stack(
        children: <Widget>[
          Container(
            width: 140,
            height: 160,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                        child: Align(
                      alignment: Alignment.center,
                      // child: Loading(),
                    )),
                    Center(child: Image.asset(typeModel.image))
                  ],
                )),
          ),
          Container(
            width: 140,
            height: 160,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.05),
                    Colors.black.withOpacity(0.025),
                  ],
                )),
          ),
          Positioned.fill(
              child: Align(
            alignment: Alignment.center,
            child: Text(
              typeModel.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w300,
              ),
            ),
          ))
        ],
      ),
    );
  }
}

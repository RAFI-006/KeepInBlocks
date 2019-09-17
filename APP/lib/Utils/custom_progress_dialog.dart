import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.white30.withAlpha(200),
      child: Center(
        child: new Container(
          height: 100,
          width: 200,
          padding: const EdgeInsets.all(30.0),
          child: new GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: new Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new CircularProgressIndicator(),
                  new SizedBox(height: 15.0),
                  new Text(
                    "Please wait...."
                        "We re setting things for your block chain",
                    style: new TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(200);
}

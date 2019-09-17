import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget
{
  BuildContext ctx;


   CustomAppBar(BuildContext ctx)
  {
    this.ctx=ctx;

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Widget ColumnDesign()
    {
      return Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              IconButton(icon: Icon(Icons.menu,size: 24,color: Colors.white30,),
                onPressed: (){
                   Scaffold.of(context).openDrawer();

                },
              ),

              Align(
                   alignment: Alignment.center,
                  child: Text("Seach your text here",style: TextStyle(fontSize: 15,color: Colors.white),))



            ],
                 ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,

            children: <Widget>[

              IconButton(icon: Icon(Icons.view_agenda,size: 24,color: Colors.white30,),
                onPressed: (){},

              ),

             IconButton(icon: Icon(Icons.supervised_user_circle,size: 24,color:Colors.white30), onPressed: null)

            ],


          )


        ],
      );

    }

    return Container(
      color: Color(0xff21211f),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(

          decoration: BoxDecoration(
            color: Color(0xff3a3b35),
            borderRadius: BorderRadius.circular(10),

          ),
          child: ColumnDesign() ,

        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(70);



}

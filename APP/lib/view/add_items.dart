import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keep_in_blocks/Utils/save_content.dart';
import 'package:keep_in_blocks/model/data_list_model.dart';
import 'package:keep_in_blocks/services/rest_service.dart';


class AddItems extends StatefulWidget
{

  @override
  State<StatefulWidget> createState() => _AddItemsState();



}

class _AddItemsState extends State<AddItems> {



  DataListModel dataModel;
  TextEditingController headingController=new TextEditingController();
  TextEditingController contentController=new TextEditingController();

  String headingText,contentText;
  @override
  void initState() {
    super.initState();

    dataModel=new DataListModel();
   headingController.addListener((){

     headingText=headingController.text;
   });

   contentController.addListener((){

     contentText=contentController.text;
   });

  }


  @override
  Widget build(BuildContext context) {
    // TODO:implemented build

    Widget BottomWidget()
    {
      return Container(
          color:Color(0xff21211f),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[

              IconButton(icon: Icon(Icons.add_box,size: 24,color: Colors.white70,), onPressed: null),

              Text("Edited"+"  "+TimeOfDay.now().toString(),style: TextStyle(fontSize: 15,color: Colors.white),),

              IconButton(icon: Icon(Icons.open_in_new,size: 24,color: Colors.white70,), onPressed: null),





            ],


          )
      );

    }
    Widget CustomAppBar()
    {
      return Container(
        width: MediaQuery.of(context).size.width,

        color: Color(0xff21211f),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[

            IconButton(icon: Icon(Icons.arrow_back,size: 24,color: Colors.white70,), onPressed:(){


              dataModel.heading=headingText;
              dataModel.note=contentText;
              dataModel.id=0;
  if(headingText!=null && headingText=="" && contentText!=null && contentText==" ") {
    RestService.PostDataInBlocks(dataModel, SaveContent.getUniqueKey())
        .whenComplete(() {
      print("Completed posting Data");
    });

    SaveContent content = new SaveContent();
    content.saveData(dataModel);
    Navigator.pop(context, dataModel);

  }          }),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[

                IconButton(icon: Icon(Icons.add,size: 24,color: Colors.white70,), onPressed: null),
                IconButton(icon: Icon(Icons.add_alert,size: 24,color: Colors.white70,), onPressed: null),
                IconButton(icon: Icon(Icons.cloud_download,size: 24,color: Colors.white70,), onPressed: null),



              ],


            )


          ],





        )
        ,



      );


    }


    Widget SubjectBody()
    {

      return Expanded(

        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: TextFormField(
            controller: contentController,
            obscureText: false,
            maxLines: null,
            style: TextStyle(
                fontFamily: 'Mono', fontSize: 20.0, color: Colors.white),
            decoration: InputDecoration.collapsed(
                hintStyle: TextStyle(color: Colors.white),
                hintText: "Note"

            ),


          ),
        ),


      );


    }


    Widget  SubjectTitle()
    {

      return

        Flexible(
          fit: FlexFit.loose,
          child: Padding(
            padding: const EdgeInsets.only(left:10),
            child: TextFormField(
              controller: headingController,
              maxLines: null,
              obscureText: false,
              style: TextStyle(
                  fontFamily: 'Mono', fontSize: 20.0, color: Colors.white),
              decoration: InputDecoration.collapsed(
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: "Title"
              ),


            ),
          ),
        );


    }





    Widget AppBody()
    {

      return Flexible(
        fit: FlexFit.tight,
        child: Container(
          width: MediaQuery.of(context).size.width,

          color: Color(0xff21211f),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SubjectTitle(),
              SizedBox(height: 20,),

              SubjectBody(),


            ],

          ),






        ),
      );

    }



    return Scaffold(
      backgroundColor: Color(0xff21211f),
      bottomNavigationBar: BottomWidget(),
      body: SafeArea(
        child: Container(
          color: Color(0xff21211f),
          width: MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomAppBar(),
              SizedBox(height: 25,),
              AppBody(),


            ],



          ),





        ),
      ),



    );
  }


















}

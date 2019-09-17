import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:keep_in_blocks/Prefs/prefs.dart';

import 'package:keep_in_blocks/Utils/custom_progress_dialog.dart';
import 'package:keep_in_blocks/Utils/save_content.dart';
import 'package:keep_in_blocks/services/rest_service.dart';
import 'package:keep_in_blocks/view/home_page.dart';

class UniqueIdGen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => _UniqueIdGen();

}

class _UniqueIdGen extends State<UniqueIdGen>
{
  final imageList=['resources/progress_one.png','resources/progress_two.png','resources/progress_three.png'];

  TextEditingController _editingController = new TextEditingController();
  String _userkey="";
  bool _isAccountCreated=false;
  SaveInPrefs prefs;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _editingController.addListener((){

      _userkey = _editingController.text;


    });


 }
  @override
  Widget build(BuildContext context) {
  //Custom ProgressBar

//    setState(() async{
// prefs= SaveInPrefs();
//    await SaveInPrefs.createInstance().whenComplete(()=>
//
//    _isAccountCreated = prefs.isRegisterd()
//
//     );
//
//
//    });

    //function to display progress Bar
    displayProgressDialog(BuildContext context) {
      Navigator.of(context).push(new PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return new ProgressDialog();
          }));
    }


    final myCraousal = Carousel(
      autoplayDuration:Duration(seconds:10),
      dotBgColor: Colors.transparent,
      dotColor: Colors.yellowAccent,
      dotIncreasedColor: Colors.yellowAccent,
      images: [
        AssetImage('resources/progress_one.png'),
        AssetImage('resources/progress_two.png'),
        AssetImage('resources/progress_three.png'),
      ],





    );

void DoRegistration() async{

  if(_userkey!=" ")
    {

      RestService.postUniqueId(_userkey).then((onValue){

        if(!onValue.hasError) {
          SaveContent.SaveUniqueKey(_userkey);
          prefs.setOnetimeReg(true);
                     }

          });



    }

}

    void DoSignIn()
    async{

      if(_userkey!=" ")
      {


        RestService.SignIn(_userkey).then((onValue){


           if(!onValue.hasError)
             {
                SaveContent.SaveUniqueKey(_userkey);
               Navigator.push(context, MaterialPageRoute(
                 builder: (context) => HomePage(),));

             }



        });


  //      displayProgressDialog(context) ;

        }

    }

    Widget CustomProgressDialog()
    {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.transparent
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),

            width: MediaQuery.of(context).size.width / 1.25,
            height: 250,

            child: myCraousal,

          ),
        ),

        );

    }

   Widget submitButton()
   {
     return Container(

     height: 60,
       width: 60,
         decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(30.0),
           shape:BoxShape.circle ,
           color: Colors.white30
         ),


         child: Material(

           // borderRadius: BorderRadius.circular(30.0),
           color: Colors.transparent,
           child: MaterialButton(
             minWidth: 10,
           //  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
             onPressed: () async {


               showDialog(
                   context: context,
                   builder: (BuildContext context) {
                     return Center(child: Visibility(
                         visible: true,
                         child: CircularProgressIndicator()),);
                   });
                await DoSignIn();
             },
             child:Icon(Icons.arrow_forward,color: Colors.white,size: 30,),

             ),
           ),
         );




   }


    //text Field
   Widget uniqueIdField()
    {

      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(

          obscureText: true,
      //    textInputAction: TextInputAction.done,
          controller: _editingController,
          style: TextStyle(
              fontFamily: 'Mono', fontSize: 20.0, color: Colors.grey),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Your Key",
            hintStyle: TextStyle(color: Colors.white30),
            border:
            OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.white
                )),
            prefixIcon: const Icon(
              Icons.vpn_key,
              color: Colors.white30,
            ),

          ),
        ),
      );

    }


    //Implementing bodyView for login or registration
    Widget BodyView()
    {
      return Container(

          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("resources/block_background.png"), fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              uniqueIdField(),
              SizedBox(height: 40,),
              submitButton(),




            ],

          )
      );






    }




    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xff21211f),

      body: SafeArea(
          child:BodyView(),
      ),


    );
  }




}




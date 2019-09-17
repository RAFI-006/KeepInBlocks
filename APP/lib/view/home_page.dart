import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keep_in_blocks/Utils/save_content.dart';
import 'package:keep_in_blocks/model/data_list_model.dart';
import 'package:keep_in_blocks/services/rest_service.dart';
import 'add_items.dart';
import 'custom_app_bar.dart';

class HomePage extends StatefulWidget
{


  @override
  State<StatefulWidget> createState() => _HomePageState();



}

class _HomePageState extends State<HomePage>
{

  List<DataListModel> itemList= List<DataListModel>();

  @override
  void initState() {
super.initState();

  RestService.getDataFromBlocks(SaveContent.getUniqueKey()).then((onResponse)
{

  if(!onResponse.hasError)
    {


      setState(() {

        itemList= onResponse.model;



      });
    }

}

  );

  }

  void  _addData(DataListModel dataModel) {
    setState(() {
      itemList.add(dataModel);

    });
  }

  Widget BottomWidget()
  {
    return Container(
      height: 50,
      color:  Color(0xff3a3b35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Flexible(flex: 1, child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: GestureDetector(

              child: Container(
                  width: 150,
                  child: Text("Take a Note..",style: TextStyle(color: Colors.white30,fontSize: 15),)),

                 onTap:_openAddEntryDialog
            ),


          )

          )

          ,Flexible(flex:1,child:Row(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              IconButton(icon: Icon(Icons.edit,color: Colors.white70,), onPressed: null)
              ,IconButton(icon: Icon(Icons.keyboard_voice,color: Colors.white70,), onPressed: null)
              ,IconButton(icon: Icon(Icons.attach_file,color: Colors.white70,), onPressed: null)



            ],

          )),


        ],


      ),


    );

  }


  Future _openAddEntryDialog() async {
    DataListModel data = await Navigator.of(context).push(new MaterialPageRoute<DataListModel>(
        builder: (BuildContext context) {
          return new AddItems();
        },
        fullscreenDialog: true
    ));
    if (data != null && data.note!=null && data.heading!=null) {
      _addData(data);
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Widget ListItems(String heading,String content)
    {

      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Color(0xff3a3b35),

              borderRadius: BorderRadius.circular(10)


          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(heading ,style: TextStyle(color: Colors.white,fontSize: 18),),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(content ,style: TextStyle(color: Colors.white,fontSize: 15),),
              ),



            ],




          ),

        ),
      );
    }



    Widget AppBody()
    {
      return Container(

        color: Color(0xff21211f),

        child: ListView.builder(

            itemCount: itemList.length,
             reverse: true,
            itemBuilder: (BuildContext context,int index)
            {
               if(itemList[index].note!=null && itemList[index].heading!=null )
              return ListItems(itemList[index].heading,itemList[index].note);
               else
              return ListItems("null","null");



            }

        ),
      );
    }


    return SafeArea(
      child: Scaffold(

        drawer: Drawer(),
        appBar: CustomAppBar(context),

        bottomNavigationBar:BottomWidget(),

        body: AppBody()
      ),
    );
  }


}


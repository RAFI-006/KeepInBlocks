import 'package:keep_in_blocks/model/data_list_model.dart';
import 'package:keep_in_blocks/model/generic_response.dart';
import 'package:http/http.dart' as http;

class RestService
{
 static String baseUrl="http://192.168.1.136:45455";

 //Post Unique Id and deploy contract for individual user instance
 static Future<GenericResponse> postUniqueId(String uniqueId)
 async {

   var genericResponse =new GenericResponse();
   var url = baseUrl+"/api/IndividualContractAssets/"+ uniqueId;
    final http.Response response = await http.post(url);


   try {
     genericResponse = GenericResponse.fromJson(response.body);

     return genericResponse;
   }
   on Exception catch(e)
   {


   }



 }

 //Add data in block chain
 static Future<GenericResponse> PostDataInBlocks(DataListModel dataModel,String uniqueId)
 async{
   var genericResponse=new GenericResponse();
   var url = baseUrl+ "/api/KeepInBlocks?UniqueId="+uniqueId;

   final http.Response response = await http.post(url,
       headers: {
         "Accept": "application/json",
         "Content-Type": "application/json-patch+json"
       },
       body: dataModel.toJson());

try
    {
        genericResponse= GenericResponse.fromJson(response.body);


    }
    on Exception catch(e)
   {}


   return genericResponse;
 }

// api to get data from blocks
 static Future<Response> getDataFromBlocks(String uniqueid)
 async{

   var url = baseUrl+"/api/KeepInBlocks/GetDataFromBlocks?UniqueId="+uniqueid;
   var genericResponse =new Response();
   try
       {
            var response = await http.get(url);
           genericResponse= Response.fromJson(response.body);
       }

   on Exception catch(e)
   {}


return genericResponse;
 }


 static Future<GenericResponse> SignIn(String uniqueId)
 async{
   var url =baseUrl+"/api/IndividualContractAssets/GetInToBlocks?uniqueId="+uniqueId;
  var genericResponse=new GenericResponse();

   try
       {
         var response = await http.get(url);
         genericResponse= GenericResponse.fromJson(response.body);

       }
       on Exception catch(e)
   {

   }

   return genericResponse;
 }

  }


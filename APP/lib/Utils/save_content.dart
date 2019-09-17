
import 'package:keep_in_blocks/model/data_list_model.dart';


class SaveContent
{

  static DataListModel dataModel;
  static String UniqueKey;


  void saveData(DataListModel model)
  {
    dataModel=model;


  }
  // Save key untill unless app lifecycle is alive
 static void SaveUniqueKey(String key)
  {
    UniqueKey=key;
  }

  //get key to use further
static  String getUniqueKey()
  {
    return UniqueKey;
  }




}
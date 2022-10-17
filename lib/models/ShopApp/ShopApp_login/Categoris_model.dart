class CategorisModel
{
  bool ? status;
  CategorisDataModel ?data;
  CategorisModel.fromjson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = CategorisDataModel.fromjson(json['data']);
  }
}

class CategorisDataModel
{
  int ? current_page;
  List<DataModel>  data = [];

  CategorisDataModel.fromjson(Map<String, dynamic> json)
  {
    current_page = json['current_page'];
    json['data'].forEach((element){
      data.add(DataModel.fromjson(element));
    });
  }
}

class DataModel
{
  int ? id;
  String ?name;
  String ? image;

  DataModel.fromjson(Map<String, dynamic> json)
  {
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}
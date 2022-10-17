class favModel
{
 bool ?status ;
 String ? message;
 favModel.fromjson(Map<String , dynamic> json)
 {
   status=json['status'];
   message=json['message'];
 }
}
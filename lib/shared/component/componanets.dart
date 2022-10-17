import 'package:flutter/material.dart';


import 'package:fluttertoast/fluttertoast.dart';


import '../todocubit/cubit.dart';

Widget defaultbutton({
  double width = double.infinity,
  Color background = Colors.cyan,
  @required String? text,
  @required VoidCallback? function  ,

}) {
  return  Container(
  width: width,
  color: background ,
child: MaterialButton(onPressed: function,
child: Text("${text}", style:
TextStyle(fontSize: 20 , color: Colors.white ,),  ),

),
);
}
Widget defaultTextForm({
@required TextEditingController? textEditingController,
  @required TextInputType? type,
  bool obscureText=false,
   @required  void Function(String? m)? onsubmit,
   void Function(String ? m)? onchanged,
  void Function()? ontap,
  void Function()? suffux,
  @required String? text,
  @required IconData? prefix,
  IconData? suffix,
  @required String? Function(String? m)? validate ,

})
{
  return TextFormField(
  validator: validate,
  controller: textEditingController,
  keyboardType: type,
  obscureText: obscureText ,
  onTap: ontap,
  onChanged: onchanged,
  onFieldSubmitted:onsubmit,
  decoration: InputDecoration(
  labelText: "${text}" ,
  border: OutlineInputBorder(),
  prefixIcon: Icon(prefix),
  suffixIcon: suffix != null ? IconButton(
      onPressed:suffux ,
      icon: Icon(suffix)) : null ,

),
);
}




 void Navaigateto(context,Widget)
 {
   Navigator.push(context, MaterialPageRoute(builder: (context){
     return Widget;
   }));
 }

void Navaigatetofinsh(context,Widget)
{
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
    return Widget;
  }),
       (route) => false
  );
}

void showToast({
  @required String ? message,
  @required ToastStates? toast
})
{
  Fluttertoast.showToast(
      msg:'$message' ,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: choseColor(toast!) ,
      textColor: Colors.white,
      fontSize: 16.0
  );
}


enum ToastStates {Sucsess,Erorr,Warning}

Color choseColor(ToastStates state1)
{
  Color color;
  switch(state1)
  {
    case ToastStates.Sucsess:
      color=Colors.green;
      break;

    case ToastStates.Erorr:
      color=Colors.red;
      break;

    case ToastStates.Warning:
      color=Colors.amber;
      break;
  }
  return color;
}
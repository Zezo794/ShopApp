import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/Shop_App/ShopApp-Login_screen/Cubit_login/states_login.dart';



import '../../../../models/ShopApp/ShopApp_login/ShopApp_usermodel.dart';
import '../../../../shared/network/end_points.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class ShopCubitLogin extends Cubit<ShopLoginStates>{
  ShopCubitLogin() : super(IntialShopState());
  static ShopCubitLogin get(context)
  {
    return BlocProvider.of(context);
  }


    ShopAppUsermodel ?loginmodel ;
void userLogin({
  @required String ? email,
  @required String ? password,
})
{
  emit(ShopLoginLoadingState());
 Diohelper.postdata(
     url: Login1,
     data:
     {
       "email": '$email',
       "password": '$password'
     }
 ).then((value)  {


     loginmodel=ShopAppUsermodel.fromjson(value.data);
   // print(loginmodel.message);
   // print(loginmodel.data?.token);
   emit(ShopLoginSucsessState(loginmodel));
   print(value.data);

 }).catchError((erorr){

   print(erorr.toString());
   emit(ShopLoginerorrState(erorr.toString()));
 });
}
IconData suffix = Icons.visibility_outlined;
  bool ispasswordShown = true;
  void changePasswordIcon()
  {
    ispasswordShown=!ispasswordShown;
    suffix= ispasswordShown ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePassword());
  }
}
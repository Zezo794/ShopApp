import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/ShopApp/ShopApp_login/ShopApp_usermodel.dart';
import '../../../../shared/network/end_points.dart';
import '../../../../shared/network/remote/dio_helper.dart';
import 'cubit_state.dart';

class ShopCubitRegister extends Cubit<ShopRegisterStates>{
  ShopCubitRegister() : super(IntialRegisterShopState());
  static ShopCubitRegister get(context)
  {
    return BlocProvider.of(context);
  }


  ShopAppUsermodel ?loginmodel ;
  void userRegister({
    @required String ? name,
    @required String ? email,
    @required String ? password,
    @required String ? phone,
  })
  {
    emit(ShopRegisterLoadingState());
    Diohelper.postdata(
        url: Register,
        data:
        {
          "name": '$name',
          "email": '$email',
          "password": '$password',
          "phone": '$phone',
        }
    ).then((value) {


      loginmodel=ShopAppUsermodel.fromjson(value.data);
      // print(loginmodel.message);
      // print(loginmodel.data?.token);
      emit(ShopRegisterSucsessState(loginmodel));
      print(value.data);

    }).catchError((erorr){

      print(erorr.toString());
      emit(ShopRegistererorrState(erorr.toString()));
    });
  }
  IconData suffix = Icons.visibility_outlined;
  bool ispasswordShown = true;
  void changePasswordIcon()
  {
    ispasswordShown=!ispasswordShown;
    suffix= ispasswordShown ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePassword());
  }
}
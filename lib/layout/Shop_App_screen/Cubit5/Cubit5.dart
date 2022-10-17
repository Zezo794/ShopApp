import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ShopApp/ShopApp_login/Categoris_model.dart';
import '../../../models/ShopApp/ShopApp_login/Favourite_model.dart';
import '../../../models/ShopApp/ShopApp_login/ShopApp_usermodel.dart';
import '../../../models/ShopApp/ShopApp_login/change_favModel.dart';
import '../../../models/ShopApp/ShopApp_login/homeModel.dart';
import '../../../modules/Shop_App/Categories_screen/Categories_screen.dart';
import '../../../modules/Shop_App/Favouraite_screen/Favouraite_screen.dart';
import '../../../modules/Shop_App/Products_screen/Products_screen.dart';
import '../../../modules/Shop_App/Settings_Screen/Settings_Screen.dart';
import '../../../shared/component/constans.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';
import 'States5.dart';

class ShopHomeCubit extends Cubit<ShopHomeStates>
{
  ShopHomeCubit() : super(ShopIntialState());

  static ShopHomeCubit get(context)
  {
    return BlocProvider.of(context);
  }
  int currentindex =0 ;
  List<Widget>bottomscreens=
  [
    ProductScreen(),
    FavouraiteScreen(),
    CategoriesScreen(),
    SetengisScreen()
  ];
  void changeBottomNavIcon(index)
  {
    currentindex=index;
    emit(ChangeBottomNavIconState());
  }

  HomeModel ?homeModel ;
  Map<int?,bool?> isfavouraite ={};
  void get_data()
  {
    emit(ShopLoadingHomeState());
    Diohelper.getdata(url: Home1 , token: token ).then((value)  {
      print('token from get data ${token}');
      homeModel=HomeModel.fromjson(value.data);
      showAlltext(homeModel!.data!.banners[0].image.toString());
      homeModel!.data!.products.forEach((element) {
        isfavouraite.addAll({
          element.id:element.in_favorites
        });
      });
      //print(isfavouraite.toString());
      emit(ShopSucsessHomeState());
    }).catchError((erorr){
      print(erorr.toString());
      emit(ShopErorrHomeState(erorr.toString()));
    });
  }
  CategorisModel ?categorisModel ;
  void get_category()
  {
    Diohelper.getdata(url: Categories, token: token).then((value){
      categorisModel=CategorisModel.fromjson(value.data);
        //showAlltext(categorisModel!.data!.data[0].image.toString());
      print('token from get category ${token}');
        emit(ShopSucsessCategorisState());
    }).catchError((erorr){
      print(erorr.toString());
      emit(ShopErorrCategorisState(erorr));
    });
  }
  favModel ? fav;
  void changeFavouraite(int ? favId)
  {
    if(isfavouraite[favId]==true)
      {
        isfavouraite[favId]=false;
      }
    else
      {
        isfavouraite[favId]=true;
      }
    emit(ShopChangefavState());
    Diohelper.postdata(url: Favorite,
        data: {
          'product_id': favId
        },
      token: token,



    ).then((value) {
      fav=favModel.fromjson(value.data);
      if(fav?.status==false)
        {
          if(isfavouraite[favId]==true)
          {
            isfavouraite[favId]=false;
          }
          else
          {
            isfavouraite[favId]=true;
          }
        }
      else
        {
          get_FavoraiteModel();
        }
      emit(ShopSucsessChangefavState(fav));
    }).catchError((erorr){
      print(erorr.toString());
      if(fav?.status==false)
      {
        if(isfavouraite[favId]==true)
        {
          isfavouraite[favId]=false;
        }
        else
        {
          isfavouraite[favId]=true;
        }
      }
      emit(ShopErorrChangefavState(erorr));
    });
  }


  FavoraiteModel ?favoraiteModel ;
  void get_FavoraiteModel()
  {
    emit(ShopLoadingFavouriteState());
    Diohelper.getdata(url: Favorite, token: token).then((value){
      favoraiteModel=FavoraiteModel.fromJson(value.data);
      print('token from get favouraite ${token}');
      //showAlltext(value.data.toString());
      emit(ShopSucsessFavouriteState());
    }).catchError((erorr){
      print(erorr.toString());
      emit(ShopErorrFavouriteState(erorr));
    });
  }



  ShopAppUsermodel ? userdata;
  void get_UserData()
  {
    emit(ShopLoadingGetUserDataState());
    Diohelper.getdata(url: Profile, token: token).then((value){
      userdata=ShopAppUsermodel.fromjson(value.data);
      print('token from get userdata ${token}');
      showAlltext('a7a a7a ${userdata!.data!.name.toString()}');
      emit(ShopSucsessGetUserDataState());
    }).catchError((erorr){
      print(erorr.toString());
      emit(ShopErorrGetUserDataState(erorr));
    });
  }


  void Update_UserData({
  @required String ? name,
  @required String ? email,
    @required String ? phone
})
  {
    emit(ShopLoadingUpdateUserDataState());
    Diohelper.putdata(url: UpdatProfile, token: token , data: {
      'name':name,
      'email':email,
      'phone':phone
    }).then((value){
      userdata=ShopAppUsermodel.fromjson(value.data);
      print('token from update userdata ${token}');
      showAlltext('a7a a7a ${userdata!.data!.name.toString()}');
      emit(ShopSucsessUpdateUserDataState());
    }).catchError((erorr){
      print(erorr.toString());
      emit(ShopErorrUpdateUserDataState(erorr));
    });
  }

  // void Logout_user( String ? ttoken)
  // {
  //   emit(ShopLoadingLogOutState());
  //   Diohelper.postdata(
  //       url: Logout,
  //       data: {
  //         'fcm_token' : '$ttoken'
  //       },
  //       token: token
  //   ).then((value) {
  //     emit(ShopSucsessLogOutState());
  //   }).catchError((erorr){
  //     print(erorr.toString());
  //     emit(ShopErorrLogOutState(erorr));
  //   });
  // }



}
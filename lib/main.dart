
import 'package:bloc/bloc.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/BlocObserver.dart';
import 'package:shopapp/shared/component/componanets.dart';
import 'package:shopapp/shared/component/constans.dart';
import 'package:shopapp/shared/network/local/Cash_helper.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
import 'package:shopapp/shared/style/Thems.dart';
import 'package:shopapp/shared/todocubit/cubit.dart';
import 'package:shopapp/shared/todocubit/states.dart';

import 'layout/Shop_App_screen/Cubit5/Cubit5.dart';
import 'layout/Shop_App_screen/Shop_App_screen.dart';
import 'layout/Shop_App_screen/rebuildApp.dart';
import 'modules/Shop_App/Onboarding_screen/Onboarding_screen.dart';
import 'modules/Shop_App/ShopApp-Login_screen/ShopApp-Login_screen.dart';



Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  showToast(message: 'on background message', toast: ToastStates.Sucsess);
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  Bloc.observer = MyBlocObserver();
  Diohelper.init();
  await CashHelper.init();
  bool? isshared=   CashHelper.getbool(key: 'isDark');
  bool? onboarding=   CashHelper.getbool(key: 'onboarding');
  token=   CashHelper.getdata(key: 'token');
  UId=   CashHelper.getdata(key: 'UId');
  Widget ? widget;






  if(onboarding!=null)
    {
      if(token!=null)
        {
          widget=ShopLayout();
          CashHelper.putbool(key: 'flag', value: true);
        }
      else
        {
          widget=ShopAppLogin();
          CashHelper.putbool(key: 'flag', value: false);
        }
    }
  else
    {
      widget=Onbording_screen();
      CashHelper.putbool(key: 'flag', value: false);
    }


  runApp( RestartWidget(
      child: myApp(isshared , widget)
  ));
  print(isshared);
}

class myApp extends StatelessWidget
{
  final bool ? isshared;
  final Widget ? widget;
  myApp(this.isshared,this.widget);


  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context)
            {
              return AppCubit()..changedarkmode(
                  fromshared: isshared
              );
            }
        ),

        BlocProvider(
            create: (context)
            {
              return ShopHomeCubit()..get_data()..get_category()..get_FavoraiteModel()..get_UserData();
            }
        ),


      ],
      child: BlocConsumer<AppCubit,AppState>(
        listener: (context,state){},
        builder: (context,state)
        {
          return MaterialApp( home:widget,
            theme: ligtthem,
            darkTheme: darkthem,
            themeMode: ThemeMode.light, // AppCubit.get(context).isdark ? ThemeMode.dark :
          );
        },

      ),
    );
  }

}
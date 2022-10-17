


import 'package:flutter/material.dart';


import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../layout/Shop_App_screen/Shop_App_screen.dart';
import '../../../layout/Shop_App_screen/rebuildApp.dart';
import '../../../shared/component/componanets.dart';
import '../../../shared/component/constans.dart';
import '../../../shared/network/local/Cash_helper.dart';
import '../ShopApp_Register_screen/ShopApp_Register_screen.dart';
import 'Cubit_login/cubit_login.dart';
import 'Cubit_login/states_login.dart';

class ShopAppLogin extends StatelessWidget {

var emailTextEditingController= TextEditingController();
var passwordTextEditingController= TextEditingController();
var formkey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)
      {
        return  ShopCubitLogin();
      },
      child: BlocConsumer<ShopCubitLogin,ShopLoginStates>(
        listener: (context,state)  {

          if (state is ShopLoginSucsessState)
            {
              if(state.login?.status==true)
                {

                  token = state.login?.data?.token;

                  print('bbbbbbbbbbbbbbbbbb');
                  print(state.login?.data?.token);
                  CashHelper.savedata(key: 'token',value:'${state.login?.data?.token}').then((value)  {
                    bool flag =CashHelper.getdata(key: 'flag');
                    print('la la la ${flag}');
                      Navaigatetofinsh(context,ShopLayout());
                      if(flag)
                      RestartWidget.restartApp(context);
                      print('aaaaaaaaaaaaaaaaaaaaa');


                  });

                }
              else
                {
                  showToast(message: state.login?.message, toast: ToastStates.Erorr);
                }
             }
        },
        builder: (context,state){
          return Form(
            key: formkey,
            child: Scaffold(

              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Login' , style: Theme.of(context).textTheme.headline3?.copyWith(color: Colors.black),),
                        SizedBox(
                          height: 15,
                        ),
                        Text('login to our browse hot offers' , style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey
                        ),),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextForm(
                            textEditingController: emailTextEditingController,
                            type: TextInputType.emailAddress,
                            onsubmit: (value){

                            },
                            text: 'email adress',
                            prefix: Icons.email_outlined,
                            validate: (String ?value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'email must not be empty';
                              }
                              return null;
                            }
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextForm(
                          textEditingController: passwordTextEditingController,
                          type: TextInputType.visiblePassword,
                          onsubmit: (value){
                            if(formkey.currentState!.validate())
                            {
                              ShopCubitLogin.get(context).userLogin(email: emailTextEditingController.text, password: passwordTextEditingController.text);
                            }
                          },
                          text: 'Password',
                          prefix: Icons.lock,
                          validate: (String ?value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'password must not be empty';
                            }
                            return null;
                          },
                          obscureText: ShopCubitLogin.get(context).ispasswordShown,
                          suffux: ()
                          {
                            ShopCubitLogin.get(context).changePasswordIcon();
                          },
                          suffix: ShopCubitLogin.get(context).suffix


                        ),
                        SizedBox(
                          height: 15,
                        ),

                           if(state is ! ShopLoginLoadingState)

                            defaultbutton(
                                text: 'Login',
                                function: ()
                                {
                                  if(formkey.currentState!.validate())
                                  {
                                    ShopCubitLogin.get(context).userLogin(email: emailTextEditingController.text, password: passwordTextEditingController.text);

                                  }
                                }
                            )
                          else
                               Center(child: CircularProgressIndicator()),


                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text('Don\'t have an acount'),
                            TextButton(
                                onPressed: (){

                                  Navaigateto(context,ShopApp_Register());
                                },
                                child: Text('Register Now')
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

            ),
          );
        },

      ),
    );
  }
}

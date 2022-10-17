
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/Shop_App_screen/Shop_App_screen.dart';
import '../../../layout/Shop_App_screen/rebuildApp.dart';
import '../../../shared/component/componanets.dart';
import '../../../shared/component/constans.dart';
import '../../../shared/network/local/Cash_helper.dart';
import 'cubit_register/cubit_register.dart';
import 'cubit_register/cubit_state.dart';

class ShopApp_Register extends StatelessWidget {

var formkey = GlobalKey<FormState>();
var nameTextEditControler = TextEditingController();
var emailTextEditControler = TextEditingController();
var passwordTextEditControler = TextEditingController();
var phoneTextEditControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)
      {
        return ShopCubitRegister();
      },
      child: BlocConsumer<ShopCubitRegister,ShopRegisterStates>(
        listener: (context,state){
          if (state is ShopRegisterSucsessState)
          {

            if(state.login?.status==true)
            {
              token = state.login?.data?.token;

              print(state.login?.data?.token);
              CashHelper.savedata(key: 'token',value:'${state.login?.data?.token}').then((value)  {
                token = state.login?.data?.token;
                Navaigatetofinsh(context,ShopLayout());
                bool flag =CashHelper.getdata(key: 'flag');
                print('ana zeh2t  ${flag}');
                if(flag)
                  RestartWidget.restartApp(context);

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
                        Text('Register' , style: Theme.of(context).textTheme.headline3?.copyWith(color: Colors.black),),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Register Now to our browse hot offers' , style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey
                        ),),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextForm(
                            textEditingController: nameTextEditControler,
                            type: TextInputType.name,
                            onsubmit: (value){

                            },
                            text: 'User Name',
                            prefix: Icons.person,
                            validate: (String ?value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'User Name must not be empty';
                              }
                              return null;
                            }
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextForm(
                            textEditingController: emailTextEditControler,
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
                            textEditingController: passwordTextEditControler,
                            type: TextInputType.visiblePassword,
                            onsubmit: (value){

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
                            obscureText: ShopCubitRegister.get(context).ispasswordShown,
                            suffux: ()
                            {
                              ShopCubitRegister.get(context).changePasswordIcon();
                            },
                            suffix: ShopCubitRegister.get(context).suffix


                        ),
                        SizedBox(
                          height: 15,
                        ),

                        defaultTextForm(
                            textEditingController: phoneTextEditControler,
                            type: TextInputType.phone,
                            onsubmit: (value){

                            },
                            text: 'Phone Number',
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
                          height: 30,
                        ),

                             if(state is ! ShopRegisterLoadingState)

                               defaultbutton(
                                  text: 'Register',
                                  function: ()
                                  {
                                    if(formkey.currentState!.validate())
                                    {
                                      ShopCubitRegister.get(context).userRegister(name: nameTextEditControler.text, email: emailTextEditControler.text, password: passwordTextEditControler.text, phone: phoneTextEditControler.text);
                                    }
                                  }
                              )

                            else
                               Center(child: CircularProgressIndicator())


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

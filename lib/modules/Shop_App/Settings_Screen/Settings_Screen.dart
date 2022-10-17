
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/Shop_App_screen/Cubit5/Cubit5.dart';
import '../../../layout/Shop_App_screen/Cubit5/States5.dart';
import '../../../layout/Shop_App_screen/rebuildApp.dart';
import '../../../shared/component/componanets.dart';
import '../../../shared/component/constans.dart';
import '../../../shared/network/local/Cash_helper.dart';
import '../ShopApp-Login_screen/ShopApp-Login_screen.dart';

class SetengisScreen extends StatelessWidget {

var nameTexteditController = TextEditingController();
var emailTexteditController = TextEditingController();
var phoneTexteditController = TextEditingController();
var formkey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopHomeStates>(
      listener: (context , state){},
      builder: (context , state){
        nameTexteditController.text=ShopHomeCubit.get(context).userdata!.data!.name!;
        emailTexteditController.text=ShopHomeCubit.get(context).userdata!.data!.email!;
        phoneTexteditController.text=ShopHomeCubit.get(context).userdata!.data!.phone!;

           if(ShopHomeCubit.get(context).userdata!=null)

            return Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateUserDataState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    defaultTextForm(
                        textEditingController: nameTexteditController,
                        type: TextInputType.text,
                        onsubmit: (value){},
                        text: 'Name' ,
                        prefix: Icons.person,
                        validate: (String ? value)
                        {
                          if(value!.isEmpty)
                          {
                            return "Name must not be empty" ;
                          }
                          return null ;
                        }
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    defaultTextForm(
                        textEditingController: emailTexteditController,
                        type: TextInputType.emailAddress,
                        onsubmit: (value){},
                        text: 'Email Adress' ,
                        prefix: Icons.email,
                        validate: (String ? value)
                        {
                          if(value!.isEmpty)
                          {
                            return "Name must not be empty" ;
                          }
                          return null ;
                        }
                    ),



                    SizedBox(
                      height: 15,
                    ),

                    defaultTextForm(
                        textEditingController: phoneTexteditController,
                        type: TextInputType.phone,
                        onsubmit: (value){},
                        text: 'Phone' ,
                        prefix: Icons.phone,
                        validate: (String ? value)
                        {
                          if(value!.isEmpty)
                          {
                            return "Name must not be empty" ;
                          }
                          return null ;
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultbutton(
                        text: 'Logout',
                        function: ()
                         {
                           //ShopHomeCubit.get(context).Logout_user(token);
                            Signout(context);
                            token=   CashHelper.getdata(key: 'token');
                            ShopHomeCubit.get(context).currentindex=0;
                            //ShopHomeCubit.get(context).get_UserData();
                            CashHelper.putbool(key: 'flag', value: true);
                            print(token);

                        }
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    defaultbutton(
                        text: 'Update',
                        function: ()
                        {
                          if(formkey.currentState!.validate())
                            {
                              ShopHomeCubit.get(context).Update_UserData(
                                  name: nameTexteditController.text,
                                  email: emailTexteditController.text,
                                  phone: phoneTexteditController.text
                              );
                              print(token);
                            }
                        }
                    )
                  ],
                ),
              ),
            );
          else


            return Center(child: CircularProgressIndicator());

      },

    );
  }
}

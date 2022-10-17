import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/Shop_App_screen/Cubit5/Cubit5.dart';
import '../../../layout/Shop_App_screen/Cubit5/States5.dart';
import '../../../models/ShopApp/ShopApp_login/Categoris_model.dart';

class CategoriesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
      listener: (context,state){},
        builder:(context,state){
         return ListView.separated(
             itemBuilder: (context , index){
               return build_category_screen(ShopHomeCubit.get(context).categorisModel!.data!.data[index]);
             },
             separatorBuilder: (context , index){
               return SizedBox(
                 height: 15,
               );
             },
             itemCount: ShopHomeCubit.get(context).categorisModel!.data!.data.length
         );

        } ,

    );
  }



  Widget build_category_screen(DataModel? model)
  {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Image(image: NetworkImage('${model?.image}' ) , height: 100 , width: 100,),
          SizedBox(
            width: 15,
          ),
          Text('${model?.name}' , style:
            TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),maxLines: 2, overflow:TextOverflow.ellipsis ,),
          Spacer(),
          IconButton(
              onPressed: (){

              },
              icon: Icon(Icons.arrow_forward_ios)
          )
        ],
      ),
    );
  }
}

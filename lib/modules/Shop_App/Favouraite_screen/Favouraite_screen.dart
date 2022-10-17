
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/Shop_App_screen/Cubit5/Cubit5.dart';
import '../../../layout/Shop_App_screen/Cubit5/States5.dart';
import '../../../models/ShopApp/ShopApp_login/Favourite_model.dart';
import '../../../shared/component/componanets.dart';

class FavouraiteScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopHomeStates>(
      listener: (context,state){
        if(state is ShopSucsessChangefavState)
        {
          if(state.favouraitemodel?.status==false)
          {
            showToast(message: '${state.favouraitemodel?.message}', toast: ToastStates.Erorr, );
          }
        }
      },
      builder: (context,state){

             if(state is ! ShopLoadingFavouriteState)

              return ListView.separated(
                  physics: BouncingScrollPhysics(),

                  itemBuilder: (context, index){
                    return build_favItem(ShopHomeCubit.get(context).favoraiteModel!.data!.data![index] , context);
                  },
                  separatorBuilder: (context, index)
                  {
                    return SizedBox(
                      height: 15,
                    );
                  },
                  itemCount: ShopHomeCubit.get(context).favoraiteModel!.data!.data!.length
              );

            else
          return Center(child: CircularProgressIndicator());



      } ,

    );
  }
  Widget build_favItem(DataModel model , context)
  {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(

        color: Colors.white,
        child: Row(

          children: [
            Container(
              width: 120,
              height: 120,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(image: NetworkImage('${model.product?.image}' , ),width: 120,
                    height: 120,),
                  if(model.product?.discount!=0)
                    Container(
                        color: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text('Discount' ,style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold , color: Colors.white),)
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${model.product?.name}' ,style: TextStyle(fontSize: 14, overflow: TextOverflow.ellipsis,fontWeight: FontWeight.bold ),maxLines: 2,),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text('${model.product?.price}\$ ' ,style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold , color: Colors.blue),),
                      SizedBox(
                        width: 5,
                      ),
                      if(model.product?.discount!=0)
                        Text('${model.product?.oldPrice}' ,style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold , color: Colors.grey,decoration: TextDecoration.lineThrough),),
                      Spacer(),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: fav(model.product?.id, context) !? Colors.blue : Colors.grey,
                        child: IconButton(
                            onPressed: (){
                              ShopHomeCubit.get(context).changeFavouraite(model.product?.id);
                              print(model.product?.id);
                            },
                            icon: Icon(Icons.favorite_border_outlined, color: Colors.white,)
                        ),
                      )
                    ],
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );


  }
  bool? fav( int ?id , context)
  {
    return ShopHomeCubit.get(context).isfavouraite[id];
  }
}


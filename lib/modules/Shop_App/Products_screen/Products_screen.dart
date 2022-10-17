
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/Shop_App_screen/Cubit5/Cubit5.dart';
import '../../../layout/Shop_App_screen/Cubit5/States5.dart';
import '../../../models/ShopApp/ShopApp_login/Categoris_model.dart';
import '../../../models/ShopApp/ShopApp_login/homeModel.dart';
import '../../../shared/component/componanets.dart';

class ProductScreen extends StatelessWidget {


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

             if(ShopHomeCubit.get(context).homeModel!=null && ShopHomeCubit.get(context).categorisModel!=null)


              return build_product(ShopHomeCubit.get(context).homeModel,ShopHomeCubit.get(context).categorisModel,context);

            else
              return Center(child: CircularProgressIndicator());


      } ,

    );
  }


  Widget build_product(HomeModel ? model , CategorisModel ? categorisModel , context)
  {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model!.data!.banners.map((e) => Image(
                  image: NetworkImage('${e.image}'), width: double.infinity,fit: BoxFit.cover,) ,).toList(),
              options: CarouselOptions(
                height: 250,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3) ,
                autoPlayAnimationDuration: Duration(seconds: 1),
                scrollDirection: Axis.horizontal,
                autoPlayCurve: Curves.fastOutSlowIn,

              )
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Categories' , style:
                  TextStyle(fontSize: 24 , fontWeight: FontWeight.w800),),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        return build_categoryItem(categorisModel!.data!.data[index]);
                      },
                      separatorBuilder: (context, index)
                      {
                        return SizedBox(
                          width: 15,
                        );
                      },
                      itemCount: categorisModel!.data!.data.length
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('New Products' , style:
                TextStyle(fontSize: 24 , fontWeight: FontWeight.w800),),
              ],
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(crossAxisCount: 2 ,

              children:
                List.generate(model.data!.products.length, (index) => build_gridviewItem(model.data!.products[index],context )),
                
                shrinkWrap: true,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.68,
              physics: NeverScrollableScrollPhysics(),
            ),
          )
        ],


      ),
    );
  }
  Widget build_gridviewItem(Products ? model, context  )
  {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
             Stack(
               alignment: AlignmentDirectional.bottomStart,
               children: [
                 Image(image: NetworkImage('${model?.image}' , ),width: double.infinity,
                 height: 200,),
                 if(model?.discount!=0)
                 Container(
                   color: Colors.red,
                     padding: EdgeInsets.symmetric(horizontal: 5),
                     child: Text('Discount' ,style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold , color: Colors.white),)
                 ),
               ],
             ),

             Padding(
               padding: const EdgeInsets.all(12),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text('${model?.name}' ,style: TextStyle(fontSize: 14, overflow: TextOverflow.ellipsis,fontWeight: FontWeight.bold ),maxLines: 2,),
                   SizedBox(
                     height: 5,
                   ),
                   Row(
                     children: [
                       Text('${model?.price}\$ ' ,style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold , color: Colors.blue),),
                       SizedBox(
                         width: 5,
                       ),
                       if(model?.discount!=0)
                         Text('${model?.old_price}' ,style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold , color: Colors.grey,decoration: TextDecoration.lineThrough),),
                       Spacer(),
                       CircleAvatar(
                         radius: 20,
                         backgroundColor: fav(model?.id, context) !? Colors.blue : Colors.grey,
                         child: IconButton(
                             onPressed: (){
                               ShopHomeCubit.get(context).changeFavouraite(model?.id);
                               print(model?.id);
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
    );
  }

  Widget build_categoryItem(DataModel ? model)
  {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,

      children: [
        Image(image: NetworkImage('${model?.image}'),
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ) ,
        Container(
          width: 100,
          color: Colors.black.withOpacity(0.7),
            child: Text('${model?.name}' , style: TextStyle(color: Colors.white),textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,maxLines: 1,)
        )
      ],
    );
  }
  bool? fav( int ?id , context)
  {
    return ShopHomeCubit.get(context).isfavouraite[id];
  }
}

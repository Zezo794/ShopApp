import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/Shop_App_screen/Cubit5/Cubit5.dart';
import '../../../layout/Shop_App_screen/rebuildApp.dart';
import '../../../models/ShopApp/ShopApp_login/Searchmodel.dart';
import '../../../shared/component/componanets.dart';
import 'Cubit_search/Cubit_search.dart';
import 'Cubit_search/states_search.dart';

class SearchScreen extends StatefulWidget {

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
var SearchEditingController = TextEditingController();

var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context){
        return SearchCubit();
      },
      child: BlocConsumer<SearchCubit,SearchState>(
        listener: (context , state ){},
        builder: (context , state ){
          return Scaffold(

            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: defaultTextForm(
                      textEditingController: SearchEditingController,
                      type: TextInputType.text,
                      onsubmit: (value)
                      {
                        SearchCubit.get(context).search_product(value);
                      },
                      text: 'SearchProduct',
                      prefix: Icons.search,
                      validate: (String ? value)
                      {
                        if(value!.isEmpty )
                          {
                            return 'Search must not be empty' ;
                          }
                        return null;
                      }
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if(state is SearchLoadingState)
                  LinearProgressIndicator(),

                SizedBox(
                  height: 25,
                ),
                if(state is SearchSucessState)
                Expanded(
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),

                      itemBuilder: (context, index){
                        return build_SearchItem(SearchCubit.get(context).searchModel!.data!.data![index] , context);
                      },
                      separatorBuilder: (context, index)
                      {
                        return SizedBox(
                          height: 15,
                        );
                      },
                      itemCount: SearchCubit.get(context).searchModel!.data!.data!.length
                  ),
                ),
              ],
            )
          );
        },

      ),
    );
  }

  Widget build_SearchItem( Product2 ? model , context)
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
                  Image(image: NetworkImage('${model?.image}' , ),width: 120,
                    height: 120,),
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
                      Spacer(),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: fav(model?.id, context) !? Colors.blue : Colors.grey,
                        child: IconButton(
                            onPressed: (){
                              setState(() {
                                ShopHomeCubit.get(context).changeFavouraite(model?.id);
                              });


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
      ),
    );


  }

  bool? fav( int ?id , context)
  {
    return ShopHomeCubit.get(context).isfavouraite[id];
  }
}

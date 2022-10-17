import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/Shop_App/Search_screen/Search_screen.dart';
import '../../shared/component/componanets.dart';
import 'Cubit5/Cubit5.dart';
import 'Cubit5/States5.dart';

class ShopLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopHomeStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit= ShopHomeCubit.get(context);
        return  Scaffold(
            appBar: AppBar(
              title: Text('sala', style: Theme.of(context).textTheme.bodyText1,),
              actions: [
                IconButton(
                    onPressed: (){
                      Navaigateto(context,SearchScreen());
                    },
                    icon: Icon(Icons.search)
                )
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index)
              {
                cubit.changeBottomNavIcon(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorite'),
                BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
                BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
              ],
              currentIndex: cubit.currentindex,
            ),
            body: cubit.bottomscreens[cubit.currentindex]
        );
      },

    );
  }
}

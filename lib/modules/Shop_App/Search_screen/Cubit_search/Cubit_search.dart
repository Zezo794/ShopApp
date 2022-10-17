
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/Shop_App/Search_screen/Cubit_search/states_search.dart';

import '../../../../models/ShopApp/ShopApp_login/Searchmodel.dart';
import '../../../../shared/component/constans.dart';
import '../../../../shared/network/end_points.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchState>
{
  SearchCubit() : super(SearchIntialState());
  static SearchCubit get (context)
  {
    return BlocProvider.of(context);
  }


SearchModel ? searchModel;
  void search_product(String ? text)
  {
    emit(SearchLoadingState());
    Diohelper.postdata(
        url: Search,
        data: {
          'text': '$text'
        },
        token: token
    ).then((value) {
      searchModel= SearchModel.fromJson(value.data);
      emit(SearchSucessState());
    }).catchError((erorr){
      print(erorr.toString());
      emit(SearchErorrState(erorr.toString()));
    });
  }
}
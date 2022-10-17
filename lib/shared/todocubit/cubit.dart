

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/todocubit/states.dart';



import '../network/local/Cash_helper.dart';

class AppCubit extends Cubit<AppState>
{
  AppCubit(): super(IntialAppState());
  static AppCubit get(context)
  {
    return BlocProvider.of(context);
  }



  bool isdark = false;
  void changedarkmode({bool ?fromshared})
  {
    if(fromshared!=null) {
      isdark = fromshared;
      emit(ChangeDarkness());
    }
    else
      {
    isdark=!isdark;
    CashHelper.putbool(key: 'isDark', value: isdark).then((value) {
      emit(ChangeDarkness());
    });

    }
    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaa${fromshared}');
  }
}
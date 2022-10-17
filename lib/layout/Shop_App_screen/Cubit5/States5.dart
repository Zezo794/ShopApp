

import '../../../models/ShopApp/ShopApp_login/ShopApp_usermodel.dart';
import '../../../models/ShopApp/ShopApp_login/change_favModel.dart';

abstract class ShopHomeStates {}
class ShopIntialState extends ShopHomeStates{}
class ChangeBottomNavIconState extends ShopHomeStates{}
class ShopLoadingHomeState  extends ShopHomeStates{}
class ShopSucsessHomeState  extends ShopHomeStates{}
class ShopErorrHomeState  extends ShopHomeStates{
  final String ? erorr;

  ShopErorrHomeState(this.erorr);
}

class ShopSucsessCategorisState  extends ShopHomeStates{}
class ShopErorrCategorisState  extends ShopHomeStates{
  final String ? erorr;

  ShopErorrCategorisState(this.erorr);
}
class ShopChangefavState  extends ShopHomeStates{}
class ShopSucsessChangefavState  extends ShopHomeStates{
  final favModel ? favouraitemodel;

  ShopSucsessChangefavState(this.favouraitemodel);
}
class ShopErorrChangefavState  extends ShopHomeStates{
  final String ? erorr;

  ShopErorrChangefavState(this.erorr);
}


class ShopLoadingFavouriteState  extends ShopHomeStates{}
class ShopSucsessFavouriteState  extends ShopHomeStates{}
class ShopErorrFavouriteState  extends ShopHomeStates{
  final String ? erorr;

  ShopErorrFavouriteState(this.erorr);
}


class ShopLoadingGetUserDataState  extends ShopHomeStates{}
class ShopSucsessGetUserDataState  extends ShopHomeStates{}
class ShopErorrGetUserDataState  extends ShopHomeStates{
  final String ? erorr;

  ShopErorrGetUserDataState(this.erorr);
}




class ShopLoadingUpdateUserDataState  extends ShopHomeStates{}
class ShopSucsessUpdateUserDataState  extends ShopHomeStates{}
class ShopErorrUpdateUserDataState  extends ShopHomeStates{
  final String ? erorr;

  ShopErorrUpdateUserDataState(this.erorr);
}

// class ShopLoadingLogOutState  extends ShopHomeStates{}
// class ShopSucsessLogOutState  extends ShopHomeStates{}
// class ShopErorrLogOutState  extends ShopHomeStates{
//   final String ? erorr;
//
//   ShopErorrLogOutState(this.erorr);
// }


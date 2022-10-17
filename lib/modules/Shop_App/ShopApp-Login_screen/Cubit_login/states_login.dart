



import '../../../../models/ShopApp/ShopApp_login/ShopApp_usermodel.dart';

abstract class ShopLoginStates {}
 class IntialShopState extends ShopLoginStates{}

 class ShopLoginLoadingState extends ShopLoginStates{}
 class ShopLoginSucsessState extends ShopLoginStates{
 final ShopAppUsermodel ? login;

 ShopLoginSucsessState(this.login);
}
 class ShopLoginerorrState extends ShopLoginStates{
  final String ? erorr;

  ShopLoginerorrState(this.erorr);
}

 class ShopChangePassword extends ShopLoginStates{}
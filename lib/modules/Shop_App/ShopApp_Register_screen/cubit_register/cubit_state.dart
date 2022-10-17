import '../../../../models/ShopApp/ShopApp_login/ShopApp_usermodel.dart';

abstract class ShopRegisterStates {}
class IntialRegisterShopState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}
class ShopRegisterSucsessState extends ShopRegisterStates{
  final ShopAppUsermodel ? login;

  ShopRegisterSucsessState(this.login);
}
class ShopRegistererorrState extends ShopRegisterStates{
  final String ? erorr;

  ShopRegistererorrState(this.erorr);
}

class ShopRegisterChangePassword extends ShopRegisterStates{}
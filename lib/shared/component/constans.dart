// baseUrl:https://newsapi.org/
// method(Url):v2/top-headlines?
// query:country=us&category=business&apiKey=46bc5e0eccc941c99ca85c24563fbd86



import '../../modules/Shop_App/ShopApp-Login_screen/ShopApp-Login_screen.dart';
import '../network/local/Cash_helper.dart';
import 'componanets.dart';

void Signout(context)
{
  CashHelper.cleardata(key: 'token').then((value) {
    if(value==true)
      {
        Navaigatetofinsh(context,ShopAppLogin());
      }
       });

}



void showAlltext(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) {
    print(element.group(0));
  });
}

  String? token = '';
String? UId = '';

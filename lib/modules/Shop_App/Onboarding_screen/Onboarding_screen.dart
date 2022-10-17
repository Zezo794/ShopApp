import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/component/componanets.dart';
import '../../../shared/network/local/Cash_helper.dart';
import '../ShopApp-Login_screen/ShopApp-Login_screen.dart';


class Onboarding_model{
  final String ? image;
  final String ? title;
  final String ? body;

  Onboarding_model({
    @required this.image,
    @required this.title,
    @required this.body
});
}

class Onbording_screen extends StatefulWidget {
  @override
  State<Onbording_screen> createState() => _Onbording_screenState();
}

class _Onbording_screenState extends State<Onbording_screen> {
List<Onboarding_model> model =[
  Onboarding_model(
    image: 'asets/image/border1.PNG',
    title: 'Boarding_screen-title 1',
    body:  'Boarding_screen-bodye 1'
  ),
  Onboarding_model(
      image: 'asets/image/border2.PNG',
      title: 'Boarding_screen-title 2',
      body:  'Boarding_screen-bodye 2'
  ),
  Onboarding_model(
      image: 'asets/image/border3.PNG',
      title: 'Boarding_screen-title 3',
      body:  'Boarding_screen-bodye 3'
  )
];

var textPageController = PageController();

bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
           actions: [
             TextButton(
                 onPressed: ()
                 {
                   submit() ;
                 },
                 child: Text('Skip' ,style:
                   TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),)
             )
           ],
         ),
         body: Column(
           children: [
             Expanded(
               child: PageView.builder(
                   itemBuilder: (context,index){
                     return buildBoardingItem(model[index]);
                   },
                 itemCount: model.length,
                 controller: textPageController,
                 physics: BouncingScrollPhysics(),
                 onPageChanged: (index)
                 {
                   if(index==model.length-1)
                     {
                       setState(() {
                         isLast=true;
                       });
                     }
                   else
                     {
                       setState(() {
                         isLast=false;
                       });
                     }
                 },



               ),
             ),
           ],
         )
    );
  }

  Widget buildBoardingItem(Onboarding_model model1)
  {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Image(image: AssetImage('${model1.image}'))),
          SizedBox(
            height: 20,
          ),
          Text('${model1.title}', style:
          TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
          SizedBox(
            height: 15,
          ),
          Text('${model1.body}', style:
          TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              SmoothPageIndicator(
                  controller: textPageController ,
                  count: model.length,
                  effect:ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                    expansionFactor: 4,
                    activeDotColor: Colors.blue
                  )
              ),
              Spacer(),
              FloatingActionButton(onPressed: (){
                if(isLast)
                  {
                     submit() ;
                  }
                else
                  {
                    textPageController.nextPage(
                        duration: Duration(
                            microseconds: 750
                        ) ,
                        curve: Curves.fastLinearToSlowEaseIn
                    );
                  }

              },
                child: Icon(Icons.arrow_forward_ios),
              )
            ],
          )
        ],
      ),
    );
  }

  void submit()
  {
    CashHelper.savedata(key: 'onboarding', value: true).then((value) => {
      if(value==true)
        {
          Navaigatetofinsh(context, ShopAppLogin())
        }
    });


  }
}

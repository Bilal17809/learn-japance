
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:learn_japan/presentation/Starte_learning/learn_japance.dart';
import 'package:learn_japan/presentation/home_screen/screen/home_screen.dart';

class Category_screen extends StatelessWidget {
  const Category_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: bgcolor,
        leading: IconButton(onPressed: (){
          Get.to(()=>HomeScreen());
        }, icon: Icon(Icons.arrow_back_outlined)),
          title: ""
              .richText
              .withTextSpanChildren([

            "Phrase".textSpan.bold.size(24).make(),
          ])
              .make()
              .px8()


      ),
      body: SafeArea(
        child: Column(
          children: [
            ""
                .richText
                .withTextSpanChildren([
        
              "What is a Phrase?\n".textSpan.bold.size(18).make(),
              "A phrase is a group of words that work together to express a single idea, but it does not contain both a subject and a predicate, so it cannot form a complete sentence on its own.\n".textSpan.normal.size(18).make(),
              "Types of Phrase?\n".textSpan.bold.size(18).make(),
            ])
                .make()
                .px8(),
            Expanded(child: Category()),
          ],
        ),
      ),
    );
  }
}



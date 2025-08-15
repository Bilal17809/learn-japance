
import 'package:learn_japan/presentation/Starte_learning/learn_japance.dart';

class Category_screen extends StatelessWidget {
  const Category_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: bgcolor,
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_outlined)),
          title: ""
              .richText
              .withTextSpanChildren([
            "Generated ".textSpan.normal.size(18).make(),

            "PDF ".textSpan.bold.size(18).make(),

            "file".textSpan.normal.size(18).make(),
          ])
              .make()
              .px8()


      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: kBodyHp),
        child: Category(),
      ),
    );
  }
}



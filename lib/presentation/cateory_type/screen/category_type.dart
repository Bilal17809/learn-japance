
import 'package:learn_japan/presentation/Starte_learning/learn_japance.dart';


class CategoryType extends StatelessWidget {


  const CategoryType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: bgcolor,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_outlined),
        ),
        title:
            "".richText
                .withTextSpanChildren([
                  "PDF ".textSpan.bold.size(18).make(),

                  "Tools".textSpan.normal.size(18).make(),
                ])
                .make()
                .centered(),
        actions: [IconButton(onPressed: () {

        }, icon: Icon(Icons.download))],
      ),
      body: SafeArea(

        child: ToolsScreen()
      ),
    );
  }
}

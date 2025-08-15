import 'package:learn_japan/presentation/Starte_learning/learn_japance.dart';

class Translator extends StatelessWidget {
  const Translator({super.key});

  @override
  Widget build(BuildContext context) {
    final screenw = context.screenWidth;
    final screenh = context.screenHeight;
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: diconbdcolor,
        leading: Image.asset("images/2x/four-circle.png"),
        title: "Translator".text.size(25).semiBold.make(),
      ),
      body: SafeArea(
        child: VStack([
          30.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              VxBox(
                    child:
                        HStack([
                          "English".text.semiBold.color(blackTextColor).make(),
                          Icon(Icons.arrow_drop_down, color: blackTextColor),
                        ]).centered(),
                  )
                  .color(
                    diconbdcolor,
                  ) // orange background color from your image
                  .roundedSM
                  .size(screenw * 0.30, screenh * 0.05) // small rounded corners
                  .px16 // horizontal padding
                  .py8 // vertical padding
                  .make(),
              VxBox(
                    child:
                        HStack([
                          "Japane".text.semiBold.color(blackTextColor).make(),
                          Icon(Icons.arrow_drop_down, color: blackTextColor),
                        ]).centered(),
                  )
                  .color(
                    diconbdcolor,
                  ) // orange background color from your image
                  .roundedSM
                  .size(screenw * 0.30, screenh * 0.05) // small rounded corners
                  .px16 // horizontal padding
                  .py8 // vertical padding
                  .make(),
            ],
          ),
          30.heightBox,
          Translatorcard(
            mainText: "English",
            leftIcon: Icons.volume_up,
            centerIcon: Icons.mic,
            rightIcon: Icons.camera_alt_outlined,
            onLeftPressed: () {

            },
            onCenterPressed: () {

            },
            onRightPressed: () {

            },
          ),

          30.heightBox,
          Translatorcard(
            mainText: "Japanese",
            leftIcon: Icons.volume_up,
            centerIcon: Icons.copy,
            rightIcon: Icons.history,
            onLeftPressed: () {

            },
            onCenterPressed: () {

            },
            onRightPressed: () {

            },
          ),
        ]),
      ),
    );
  }
}

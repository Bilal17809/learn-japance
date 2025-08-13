import 'package:learn_japan/presentation/Starte_learning/learn_japance.dart';

class StartLearning extends StatelessWidget {
  const StartLearning({super.key});

  @override
  Widget build(BuildContext context) {
    final screenw =
        context.screenWidth; // same as MediaQuery.of(context).size.width
    final screenh =
        context.screenHeight; // same as MediaQuery.of(context).size.width

    return Scaffold(
      body: VStack([
        45.heightBox,
        HStack([
          "Japanese".text.semiBold.size(27).make(),
          (screenw * 0.45).widthBox,
          Icon(Icons.settings, size: 30, color: iconcolor).onTap(() {
            // Your onPressed code
          }),
        ]).box.px24.make(),
        2.heightBox,
        Container(
          width: screenw * 0.85,
          child: MyProgressBar(
            progress: 0.75,
            backgroundColor:bgofpressind, // light grey
            progressColor: iconcolor, // blue
          ),

        ).box.px24.make(),
        2.heightBox,
        HStack([
          "Today's goal:".text.make(),
          "10 XP".text.semiBold.make(),
        ]).box.px24.alignTopLeft.make(),
        14.heightBox,
        "Start learning".text.size(25).make().box.px24.alignTopLeft.make(),
        5.heightBox,
        VxBox(
              child: VStack([
                HStack([
                  Image.asset("images/3x/correct.png", width: screenh * 0.035),
                  13.widthBox,
                  "Hiragana".text.semiBold.size(24).make(),
                ]).box.px16.make().pOnly(top: 13),
                "あ".text.semiBold.center.size(100).make().centered(),
                "CONTINUE".text.white
                    .size(15)
                    .make()
                    .centered()
                    .box
                    .rounded
                    .size(screenw * 0.6, screenh * 0.075)
                    .color(Buttoncolor)
                    .p16 // padding inside button
                    .make()
                    .centered()
                    .onTap(() {
                      // your action
                    }),
              ]), // your Column content
            )
            .color(kWhiteFA)
            .size(context.screenWidth * 0.9, context.screenHeight * 0.37)
            .make()
            .card
            .px24
            .make(),
        HStack([
          buildMenuItem(Icons.menu_book, "Lesson").box.px8.make(),
          buildMenuItem(Icons.edit, "Practice").box.px8.make(),
          buildMenuItem(Icons.mic, "Speaking").box.px8.make(),
          buildMenuItem(Icons.help_outline, "Quizzes").box.px8.make(),
        ], alignment: MainAxisAlignment.spaceAround).px8().centered().py8(),
        "Today Progress".text.size(15).make().px24(),
        5.heightBox,
        Container(
          width: screenw * 0.85,
          child: MyProgressBar(
            progress: 0.75,
            backgroundColor:bgofpressind, // light grey
            progressColor: Buttoncolor, // blue
          ),

        ).box.px24.make(),
        5.heightBox,
        HStack([
          LossonWOrdSentenco(10,"Lessons").box.px24.make(),
          LossonWOrdSentenco(30,"Words").box.px24.make(),
          LossonWOrdSentenco(5,"Sentences").box.px24.make(),
        ],),
5.heightBox,
        HStack([
          "Streak".text.size(25).semiBold.make().px24(),
         (screenw*0.22).widthBox,
          Image.asset("images/3x/star.png", width: screenh * 0.025),
          3.widthBox,
          "5 achievenments".text.size(15).semiBold.make()

        ])
        // Function to build each menu item
      ]),
    );
  }
}


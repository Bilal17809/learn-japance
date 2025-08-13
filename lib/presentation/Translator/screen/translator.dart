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
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "English".text.size(15).make().px(20),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.highlight_remove),
                  ),
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.volume_up, color: blackTextColor, size: 28).box.make().pOnly(left: 10),
                  Icon(Icons.mic, color: blackTextColor, size: 28),
                  Icon(Icons.camera_alt_outlined, color: blackTextColor, size: 28).box.make().pOnly(right: 10),
                ],
              ).box.size(screenw*1, screenh*0.06).color(diconbdcolor).make()

            ],
          ).box
              .color(boxbgcolor)
              .size(screenw * 0.8, screenh * 0.25)
              .make()
              .card
              .make()
              .centered(),
          30.heightBox,
          Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Japance".text.size(15).make().px(20),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.highlight_remove),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.volume_up, color: blackTextColor, size: 28).box.make().pOnly(left: 10),
                      Icon(Icons.copy, color: Vx.black, size: 28),
                      Icon(Icons.access_time, color: Vx.black, size: 28).box.make().pOnly(right: 10),
                    ],
                  ).box.size(screenw*1, screenh*0.06).color(diconbdcolor).make()

                ],
              ).box
              .color(boxbgcolor)
              .size(screenw * 0.8, screenh * 0.25)
              .make()
              .card
              .make()
              .centered(),
        ]),
      ),
    );
  }
}

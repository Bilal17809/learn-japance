
import 'package:learn_japan/presentation/Starte_learning/learn_japance.dart';

class Greeting extends StatelessWidget {
  const Greeting({super.key});

  @override
  Widget build(BuildContext context) {
    final screenw=MediaQuery.of(context).size.width;
    final screenh=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: bgcolor,
        leading:  Image.asset("images/2x/four-circle.png",),
        title: "LEARN JAPANESE".text.size(18).semiBold.make(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              5.heightBox,
              "Greeting".text// Aligns text to start
                  .semiBold
                  .size(25)
                  .make().px8(),
              10.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  "Salam".text.size(20).make().px8(),
                  Row(
                    mainAxisSize: MainAxisSize.min, // shrink to fit content
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite),
                        padding: EdgeInsets.zero, // remove inner padding
                        constraints: const BoxConstraints(), // remove default min size
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.volume_up_outlined),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  )
                ]
              ).box.size(screenw*1, screenh*0.09).rounded.color(diconbdcolor).make(),

              5.heightBox,
              "サラーム".text.align(TextAlign.end).size(20).make().pOnly(right: 15,top: 20).box.rounded.size(screenw*1, screenh*0.09).color(iconbdcolor).make(),
              15.heightBox,
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    "How are you".text.size(20).make().px8(),
                    Row(
                      mainAxisSize: MainAxisSize.min, // shrink to fit content
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite),
                          padding: EdgeInsets.zero, // remove inner padding
                          constraints: const BoxConstraints(), // remove default min size
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.volume_up_outlined),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    )
                  ]
              ).box.size(screenw*1, screenh*0.09).rounded.color(diconbdcolor).make(),
              5.heightBox,
              "元気ですか".text.align(TextAlign.end).size(20).make().pOnly(right: 15,top: 20).box.rounded.size(screenw*1, screenh*0.09).color(iconbdcolor).make(),
              15.heightBox,
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    "Good Morning".text.size(20).make().px8(),
                    Row(
                      mainAxisSize: MainAxisSize.min, // shrink to fit content
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite),
                          padding: EdgeInsets.zero, // remove inner padding
                          constraints: const BoxConstraints(), // remove default min size
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.volume_up_outlined),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    )
                  ]
              ).box.size(screenw*1, screenh*0.09).color(diconbdcolor).rounded.make(),
              5.heightBox,
              "おはよう".text.align(TextAlign.end).size(20).make().pOnly(right: 15,top: 20).box.rounded.size(screenw*1, screenh*0.09).color(iconbdcolor).make(),
            ],
          ),
        ),
      ),
    );
  }
}

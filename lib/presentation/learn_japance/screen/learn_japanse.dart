
import 'package:learn_japan/presentation/Starte_learning/learn_japance.dart';

class LearnJapanse extends StatelessWidget {
  const LearnJapanse({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: bgcolor,
        leading:  Image.asset("images/2x/four-circle.png",),
        title: "LEARN JAPANESE".text.size(18).semiBold.make(),

      ),
      body: SafeArea(
        child: Column(
          children: [
            30.heightBox,
            Image.asset(
              "images/3x/Group 1.png",
              // width: 250,
              height: 180,
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: kBodyHp),
                child: Learnjapance(),
              ),
            ),

          ],
        ),
      ),
    );
  }
}


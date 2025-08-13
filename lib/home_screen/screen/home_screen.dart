import 'package:learn_japan/home_screen/exprot/exprot.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenw = MediaQuery.of(context).size.width;
    final screenh = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: backgroundcolor,
        title: Row(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.apps)),
            "LEARN JAPANESE".text.size(18).semiBold.make(),
          ],
        ),
      ),
      body: Column(
        children: [
          Image.asset(
            "images/3x/men.png",
            width: screenw * 0.7,
            height: screenw * 0.7,
          ),
           20.heightBox,
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: bodyHT),
              child: GridView.builder(
                itemCount: menuItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return Container(
                    decoration: GridViewdocation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: textdocation,
                          child: SizedBox(
                            height: 28,
                            width: 28,
                            child: item.image, // Use your asset image here
                          ),
                        ),
                        const SizedBox(height: 8),
                        item.label.text
                            .align(TextAlign.center)
                            .semiBold
                            .size(14)
                            .make(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          // SizedBox(height: 15,),
          Container(
            width: screenw * 1,
            height: screenh * 0.1,
            color: addcolor,
            child: Center(child: "ADD/".text.semiBold.center.make()),
          ),
          30.heightBox,
        ],
      ),
    );
  }
}

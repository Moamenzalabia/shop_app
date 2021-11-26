import 'package:flutter/material.dart';
import 'package:newshop_app/models/boarding_model.dart';
import 'package:newshop_app/modules/login/login_screen.dart';
import 'package:newshop_app/shared/components/app_navigator.dart';
import 'package:newshop_app/shared/network/local/cache_helper.dart';
import 'package:newshop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  var boardController = PageController();
  bool isLast = false;
  List<BoardingModel> boardingItems = [
    BoardingModel(
      image: 'assets/images/onboard_1.jpeg',
      title: 'On Board 1 Title',
      message: 'On Board 1 message',
    ),
    BoardingModel(
      image: 'assets/images/onboard_1.jpeg',
      title: 'On Board 2 Title',
      message: 'On Board 2 message',
    ),
    BoardingModel(
      image: 'assets/images/onboard_1.jpeg',
      title: 'On Board 3 Title',
      message: 'On Board 3 message',
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: submitLoginScreen,
            child: Text('SKIP'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boardingItems.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildOnBoardingItem(boardingItems[index]),
                itemCount: boardingItems.length,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                  count: boardingItems.length,
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submitLoginScreen();
                    } else {
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void submitLoginScreen() {
    CacheHelper().saveData(key: 'onBoarding', value: true).then((value) {
        if(value){
          AppNavigator.navigateAndFinish(nextScreen: LoginScreen(), context: context);
        }
    });
  }
}

Widget buildOnBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage(model.image),
        ),
        Text(
          model.title,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          model.message,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 30),
      ],
    );

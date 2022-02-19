import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hire_lawyer/Login/LoginFinal.dart';
import 'package:hire_lawyer/Login/remember_controller.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var OnBoardingController = RememberController();
  int currentPage = 0;
  List<Widget> pages = [
    OnbaordingContent(
      title: "Bienvenue ",
      desc:
          'Votre guide pour trouver les meilleurs avocats en Tunisie dans tous les domaines juridique',
      image: 'assets/images/judge.png',
    ),
    OnbaordingContent(
      title: 'êtes-vous fatigué de chercher un avocat qualifié ?',
      desc: 'Hire lawyer est la meilleur solution \n pour vous 7/7 24/24',
      image: 'assets/images/answer.png',
    ),
    OnbaordingContent(
      title: " ",
      desc:
          'A partir de maintenant discuter avec votre avocat personelle en ligne ',
      image: 'assets/images/texting.png',
    ),
  ];
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemCount: pages.length,
              scrollDirection: Axis.horizontal, // the axis
              controller: _controller,
              itemBuilder: (context, int index) {
                return pages[index];
              }),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(pages.length, (int index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    height: size.height * 0.01,
                    width: (index == currentPage) ? 25 : 10,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (index == currentPage)
                            ? Colors.blue
                            : Colors.blue.withOpacity(0.5)),
                  );
                }),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                        onTap: () async {
                          Navigator.pushNamed(context, 'home');
                          OnBoardingController.check();
                        },
                        child: Text(
                          'Ignorer',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        height: 50,
                        width: (currentPage == pages.length - 1) ? 150 : 100,
                        child: DirectionMethode(
                            controller: _controller,
                            currentPage: currentPage,
                            pages: pages,
                            press: (currentPage == pages.length - 1)
                                ? () async {
                                    OnBoardingController.check();

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()));
                                  }
                                : () async {
                                    OnBoardingController.check();
                                    _controller.nextPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOutQuint);
                                  }),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class DirectionMethode extends StatelessWidget {
  final Function press;
  const DirectionMethode({
    Key key,
    @required PageController controller,
    @required this.currentPage,
    @required this.pages,
    this.press,
  })  : _controller = controller,
        super(key: key);

  final PageController _controller;
  final int currentPage;
  final List<Widget> pages;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: press,
      child: (currentPage == pages.length - 1)
          ? Text('Commencer')
          : Text('Suivant'),
      color: Colors.blueAccent.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}

class OnbaordingContent extends StatelessWidget {
  final String title;
  final String image;
  final String desc;
  const OnbaordingContent({
    Key key,
    this.title,
    this.image,
    this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.orange, fontSize: size.height * 0.05)),
            ),
            Image.asset(
              image,
              height: size.height * 0.4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                desc,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontFamily: 'NewsCycle-Bold'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

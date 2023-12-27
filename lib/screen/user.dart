import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  Future<void> _launchUrl(String url) async {
    Uri _url = Uri.parse(url);

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 95),
            child: SvgPicture.asset(
              "assets/images/creators.svg",
              width: screenWidth,
            ),
          ),
          Column(
            children: [
              SvgPicture.asset(
                'assets/images/netrunners.svg',
                width: screenWidth,
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        _launchUrl("https://www.instagram.com/netrunners_dev/");
                      },
                      child: Container(
                        width: 70,
                        height: 70,
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/ig_icon.svg',
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _launchUrl("https://twitter.com/netrunners_dev");
                      },
                      child: Container(
                        width: 70,
                        height: 70,
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/x_icon.svg',
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _launchUrl("https://github.com/netrunners-dev");
                      },
                      child: Container(
                        width: 70,
                        height: 70,
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/github_icon.svg',
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _launchUrl("mailto:netrunners.work@gmail.com");
                      },
                      child: Container(
                        width: 70,
                        height: 70,
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/mail_icon.svg',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 35),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "This app is developed by:\n",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: "Pixel",
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  children: const [
                    TextSpan(
                      text: 'Net',
                      style: TextStyle(
                        color: Color.fromARGB(255, 239, 63, 64),
                      ),
                    ),
                    TextSpan(text: 'runners, 2023.-2024.'),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

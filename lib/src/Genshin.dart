import 'package:flutter/material.dart';
import 'package:Genshinimpact/src/ScaleAnimation.dart';
import 'package:Genshinimpact/src/Utils/ArrowDirection.dart';
import 'package:Genshinimpact/src/Widgets/ArrowButton.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

List<Map<String, dynamic>> legends = [
  {
    "nickname": "Kamisato Ayaka",
    "type": "Frostlake Princess",
    "punchLine": " Master of Inazuma Kamisato Art Tachi Jutsu — Kamisato Ayaka, present! Delighted to make your acquaintance.",
    "abilities": [
      {
        "type": "Elemental Skill",
        "name": "Kamisato art: Hyouka",
        "icon": "assets/images/AyakaElementalSkill.png",
      },
      {
        "type": "Passive Talents",
        "name": "Amatsumi Kunitsumi",
        "icon": "assets/images/AyakaPassiveTalent.png",
      },
      {
        "type": "Elemental Brust",
        "name": "Kamisato art: Soumetsu",
        "icon": "assets/images/AyakaElementalBrust.png",
      }
    ]
  },
  {
    "nickname": "Raiden Shogun",
    "type": "Plane of Euthymia",
    "punchLine": "Inactivity serves no purpose whatsoever. Hmph.",
    "abilities": [
      {
        "type": "Elemental Skill",
        "name": "Transcendence: Baleful Omen",
        "icon": "assets/images/ShogunElementalSkill.png",
      },
      {
        "type": "Passive Talents",
        "name": "Enlightened One",
        "icon": "assets/images/PassiveTalentShogun.png",
      },
      {
        "type": "Elemental Brust",
        "name": "Secret Art: Musou Shinsetsu",
        "icon": "assets/images/ShogunElementalBrust.png",
      }
    ]
  },
  {
    "nickname": "Yae Miko",
    "type": "Astute Amusment",
    "punchLine": "I am the Guuji of the Grand Narukami Shrine. The purpose of my visit is to monitor your every move.",
    "abilities": [
      {
        "type": "Elemental Skill",
        "name": "Yakan Evacation: Sesshou Sakura",
        "icon": "assets/images/YaeElementalSkill.png",
      },
      {
        "type": "Passive Talents",
        "name": "Enlightened Blessing",
        "icon": "assets/images/PassiveTalentYae.png",
      },
      {
        "type": "Elemental Brust",
        "name": "Great Secret Art: Tenko Kenshin",
        "icon": "assets/images/YaeElementalBrust.png",
      }
    ]
  },
];

class Genshin extends HookWidget {
  const Genshin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ctrl = usePageController(initialPage: 0);
    final _currentPageIndex = useState(0);
    final _isScrolling = useState(false);

    void _handleIsScrolling() {
      if (_ctrl.page?.toInt() != _ctrl.page) {
        // if _isScrolling is already true, don't do anything
        if (_isScrolling.value) return;
        _isScrolling.value = true;
      } else {
        // if _isScrolling is already false, don't do anything
        if (!_isScrolling.value) return;
        _isScrolling.value = false;
      }
    }

    useEffect(() {
      // FIXME: There must be a better way to detect
      // the start and end of a scroll.
      _ctrl.addListener(() {
        _handleIsScrolling();
      });

      return _ctrl.dispose;
    }, [_ctrl]);

    List<Widget> _list = <Widget>[
      const Page(
        path: 'assets/images/BannerAyaka.png',
      ),
      const Page(
        path: 'assets/images/BannerShogun.png',
      ),
      const Page(
        path: 'assets/images/YaeBanner.png',
      ),
    ];

    Widget _buildAbility(String path, String name, String type) {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: const Color(0xff222a3d),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(path),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      type,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(.8),
                        fontSize: 11.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    void onArrowTap(ArrowDirection direction) {
      if (direction == ArrowDirection.up) {
        if (_currentPageIndex.value != 0) {
          _ctrl.animateToPage(
            _currentPageIndex.value - 1,
            duration: const Duration(milliseconds: 650),
            curve: Curves.ease,
          );
        }
      } else {
        if (_currentPageIndex.value != _list.length - 1) {
          _ctrl.animateToPage(
            _currentPageIndex.value + 1,
            duration: const Duration(milliseconds: 650),
            curve: Curves.ease,
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2d374d),
        elevation: 0.0,
        toolbarHeight: 0.0, // status bar color
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Color(0xff454d5e), Color(0xff2d374d)],
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: PageView(
                children: _list,
                scrollDirection: Axis.vertical,
                controller: _ctrl,
                onPageChanged: (int index) {
                  _currentPageIndex.value = index;
                },
              ),
            ),
            Positioned(
              top: 18,
              left: 0,
              right: 0,
              child: ScaleAnimation(
                show: !_isScrolling.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 120,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ...legends[_currentPageIndex.value]['abilities']
                              .map((p) {
                            return _buildAbility(
                                p['icon'], p['name'], p['type']);
                          }).toList(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 14,
                      ),
                      child: Text(
                        '"${legends[_currentPageIndex.value]['punchLine']}"',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              right: 25,
              child: SizedBox(
                height: 132,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentPageIndex.value != 0)
                      ArrowButton(
                        direction: ArrowDirection.up,
                        onTap: onArrowTap,
                        image: Image.asset('assets/images/arrow-up.png'),
                      ),
                    Container(),
                    if (_currentPageIndex.value != _list.length - 1)
                      ArrowButton(
                        onTap: onArrowTap,
                        direction: ArrowDirection.down,
                        image: Image.asset('assets/images/arrow-down.png'),
                      ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 90,
              left: 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    legends[_currentPageIndex.value]['nickname'],
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    legends[_currentPageIndex.value]['type'],
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Page extends StatelessWidget {
  const Page({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * .5,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage(path),
          ),
        ),
      ),
    );
  }
}
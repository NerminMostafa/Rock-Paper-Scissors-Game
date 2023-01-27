import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/enums/game_enum.dart';
import 'package:game/enums/res_enum.dart';
import 'package:game/components/home_screen_text.dart';

class HomeScreen extends StatefulWidget {
  String value;
  HomeScreen({Key? key, required this.value}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState(value);
}

class _HomeScreenState extends State<HomeScreen> {

  String value;
  int cpu = 0;
  int player = 0;
  _HomeScreenState(this.value);

  GameEnum? userChoice;
  GameEnum? computerChoice;
  ResultEnum? finalResult;

  List cpuSelections = [
    GameEnum.rock,
    GameEnum.paper,
    GameEnum.scissor,
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      userChoice == null
          ? Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://i.pinimg.com/564x/35/37/10/353710a253ff533d2e4b1cc8c945ec3b.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column( mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50,bottom: 10),
              child: Text('HELLO, ${value.toUpperCase()}',
                style: (const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                )),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(top:20),
              child: Text(
                'Pick your weapon',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  userChoice = GameEnum.rock;
                });
                makeComputerSelect();
                calculations();
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Image.asset(
                  'assets/images/rock.png',
                  height: 115,
                ),
              ),
            ),
            HomeScreenText('Rock'),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  userChoice = GameEnum.paper;
                });
                makeComputerSelect();
                calculations();
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Image.asset(
                  'assets/images/paper.png',
                  height: 115,
                ),
              ),
            ),
            HomeScreenText('Paper'),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  userChoice = GameEnum.scissor;
                });
                makeComputerSelect();
                calculations();
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Image.asset(
                  'assets/images/scissor.png',
                  height: 115,
                ),
              ),
            ),
            HomeScreenText('Scissors'),
            Padding(padding: const EdgeInsets.only(right: 25,left: 25,top: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text('YOU',
                        style: TextStyle(color: Colors.white),),
                      HomeScreenText(player.toString()),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('CPU',
                      style: TextStyle(color: Colors.white),),
                      HomeScreenText(cpu.toString())
                    ],
                  )
                ],
              ) ,
            ),
          ]
        ),
      ):
      Center(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage('https://i.pinimg.com/564x/35/37/10/353710a253ff533d2e4b1cc8c945ec3b.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Padding(
                 padding: const EdgeInsets.only(top: 150),
                 child: Text(finalResult!.name.toUpperCase(),
                 style: const TextStyle(
                   fontSize: 40,
                   color: Colors.white,
                   fontWeight: FontWeight.bold,
                 ),),
               ),
                Padding(
                  padding: const EdgeInsets.only(top: 100,bottom: 50),
                  child: Row( mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 50,),
                        child: Column(
                          children: [
                            const Text(
                              'YOU',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20
                              ),
                            ),
                            Image.asset(
                              'assets/images/${userChoice!.name}.png',
                              height: 150,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          const Text(
                            'CPU',
                            style: TextStyle(color: Colors.white,
                            fontSize: 20),
                          ),
                          Image.asset(
                            'assets/images/${computerChoice!.name}.png',
                            height: 150,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 100,left: 100,top: 50,bottom: 25),
                  child: ElevatedButton(onPressed: (){
                    setState(() {
                      userChoice = null;
                    });
                  },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      fixedSize: const Size(150, 30),
                      primary: const Color(0xff601154),
                    ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                        Text('Play Again '),
                        Icon(CupertinoIcons.arrow_2_circlepath),
                      ],),
                  ),
                ),
                Padding(padding: const EdgeInsets.only(right: 25,left: 25,top: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text('YOU',
                            style: TextStyle(color: Colors.white),),
                          HomeScreenText(player.toString()),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('CPU',
                            style: TextStyle(color: Colors.white),),
                          HomeScreenText(cpu.toString())
                        ],
                      )
                    ],
                  ) ,
                ),
              ],
            ),
          )
      )
    );
  }

  calculations() {
    // if user select rock
    if (userChoice == GameEnum.rock && computerChoice == GameEnum.paper) {
      setState(() {
        finalResult = ResultEnum.lose;
        cpu ++;
      });
    }
    if (userChoice == GameEnum.rock && computerChoice == GameEnum.rock) {
      setState(() {
        finalResult = ResultEnum.draw;
      });
    }
    if (userChoice == GameEnum.rock && computerChoice == GameEnum.scissor) {
      setState(() {
        finalResult = ResultEnum.win;
        player++;
      });
    }

    // if user select paper

    if (userChoice == GameEnum.paper && computerChoice == GameEnum.paper) {
      setState(() {
        finalResult = ResultEnum.draw;
      });
    }
    if (userChoice == GameEnum.paper && computerChoice == GameEnum.scissor) {
      setState(() {
        finalResult = ResultEnum.lose;
        cpu++;
      });
    }
    if (userChoice == GameEnum.paper && computerChoice == GameEnum.rock) {
      setState(() {
        finalResult = ResultEnum.win;
        player++;
      });
    }

    // if user select scissor
    if (userChoice == GameEnum.scissor && computerChoice == GameEnum.paper) {
      setState(() {
        finalResult = ResultEnum.win;
        player++;
      });
    }
    if (userChoice == GameEnum.scissor && computerChoice == GameEnum.rock) {
      setState(() {
        finalResult = ResultEnum.lose;
        cpu++;
      });
    }
    if (userChoice == GameEnum.scissor && computerChoice == GameEnum.scissor) {
      setState(() {
        finalResult = ResultEnum.draw;
      });
    }
  }

  makeComputerSelect() {
    setState(() {
      Random random = Random();
      int selected = random.nextInt(3);
      computerChoice = cpuSelections[selected];
    });
  }

}


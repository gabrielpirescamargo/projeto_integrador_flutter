import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/next_maintenance_banner.dart';
import '../widgets/custom_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Menu'),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              NextMaintenanceBanner(
                airplaneName: 'Airplane 123',
                airportCode: 'GRU',
                gate: 'A4',
                date: '2023-09-01',
                time: '10:30 AM',
              ),
              Padding(
                padding: new EdgeInsets.all(24.0),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DefaultTextStyle(
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff030303)),
                        child: Text('Options'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomButton(
                        icon: CupertinoIcons.airplane,
                        color: const Color(0xffDAE7F6),
                        color2: const Color(0xff2D63B5),
                        //  color: const Color(0xffDAE7F6),
                        title: 'Manutencao',
                        onPressed: () {
                          Navigator.pushNamed(context, '/maintenance');
                        },
                      ),
                      SizedBox(width: 20),
                      CustomButton(
                        icon: CupertinoIcons.doc_text_viewfinder,
                        color: const Color(0xffFCD2DF),
                        color2: const Color(0xffEE1E5F),
                        title: 'Scanner',
                        onPressed: () {
                          Navigator.pushNamed(context, '/scanner');
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomButton(
                        icon: CupertinoIcons.cube_box_fill,
                        color: const Color(0xffD0B9B9),
                        color2: const Color(0xff762424),
                        title: 'Estoque',
                        onPressed: () {
                          Navigator.pushNamed(context, '/estoque');
                        },
                      ),
                      SizedBox(width: 20),
                      CustomButton(
                        icon: CupertinoIcons.person_fill,
                        color: const Color(0xffC0C0C0),
                        color2: const Color(0xff737E81),
                        title: 'Perfil',
                        onPressed: () {
                          Navigator.pushNamed(context, '/perfil');
                        },
                      ),
                    ],
                  ),
                ]),
              )
            ],
          ),
        ));
  }
}

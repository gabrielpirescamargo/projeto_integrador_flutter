import 'package:flutter/cupertino.dart';

class NextMaintenanceBanner extends StatelessWidget {
  final String airplaneName;
  final String airportCode;
  final String gate;
  final String date;
  final String time;

  const NextMaintenanceBanner({
    required this.airplaneName,
    required this.airportCode,
    required this.gate,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width - 50;

    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/maintenanceDetails',
            arguments: {
              'name': airplaneName,
              'status': time,
              'gate': gate,
              'date': date,
              'id': 'AJR-2834',
              'airport': airportCode,
            },
          );
        },
        child: Container(
          width: screenWidth,
          height: 165,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Color(0xff2f2762)),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextStyle(
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xB3ffffff)),
                      child: Text("Proxima manutencao"),
                    ),
                    DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.w600,
                      ),
                      child: Text(airplaneName),
                    ),
                    DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                      child: Text(airportCode),
                    ),
                    DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                      child: Text(gate),
                    ),
                    DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                      child: Text(date),
                    ),
                    DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                      child: Text(time),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 100,
                child: Image.asset(
                  "assets/path50.png",
                  width: 30,
                  height: 30,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 70,
                child: Image.asset(
                  "assets/path51.png",
                  width: 30,
                  height: 30,
                ),
              ),
              Positioned(
                bottom: 25,
                right: 20,
                child: Image.asset(
                  "assets/path143.png",
                  width: 60,
                  height: 60,
                ),
              ),
              Positioned(
                bottom: 50,
                right: 80,
                child: Image.asset(
                  "assets/path142.png",
                  width: 50,
                  height: 50,
                ),
              ),
              Positioned(
                bottom: 95,
                right: 50,
                child: Image.asset(
                  "assets/path104.png",
                  width: 30,
                  height: 30,
                ),
              ),
              Positioned(
                bottom: 35,
                right: 75,
                child: Image.asset(
                  "assets/path103.png",
                  width: 21,
                  height: 21,
                ),
              ),
            ],
          ),
        ));
  }
}

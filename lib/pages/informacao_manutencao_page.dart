import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Importe o pacote Material para usar os botões
import 'package:dio/dio.dart'; // Import the Dio package for network requests

class MaintenanceDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? maintenanceData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (maintenanceData == null) {
      return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(middle: Text('Not found')),
        child: Center(
          child: Text('Maintenance details not available'),
        ),
      );
    }

    final String name = maintenanceData['name'] ?? 'Unknown';
    final String status = maintenanceData['status'] ?? 'Unknown';
    final String gate = maintenanceData['gate'] ?? 'Unknown';
    final String date = maintenanceData['date'] ?? 'Unknown';
    final String id = maintenanceData['id'] ?? 'Unknown';
    final String instrucoes = maintenanceData['instrucoes'] ?? 'Unknown';
    final String airport = maintenanceData['airport'] ?? 'Unknown';

    void updateStatus({
      required String newStatus,
      required String name,
      required String gate,
      required String date,
      required String id,
      required String instrucoes,
      required String airport,
    }) async {
      final url =
          "http://localhost:3000/maintenanceList/$id"; // Substitua pela URL real
      final dio = Dio();

      try {
        final response = await dio.put(
          url,
          data: {
            "status": newStatus,
            "name": name,
            "gate": gate,
            "date": date,
            "id": id,
            "instrucoes": instrucoes,
            "airport": airport,
          },
        );

        if (response.statusCode == 200) {
          Navigator.popUntil(context, ModalRoute.withName('/home'));

          // A requisição foi bem-sucedida; você pode adicionar tratamento de sucesso aqui.
        } else {
          // Se a requisição não foi bem-sucedida, você pode adicionar tratamento de erro aqui.
          print("Erro na requisição: ${response.statusCode}");
        }
      } catch (e) {
        // Tratamento genérico de erros, como problemas de rede.
        print("Erro: $e");
      }
    }

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('$name')),
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height - 200,
                      padding: EdgeInsets.all(38.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultTextStyle(
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xffffffff)),
                            child: Text(name),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          DefaultTextStyle(
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: const Color(0xffffffff)),
                            child: Text(status),
                          ),
                          DefaultTextStyle(
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: const Color(0xffffffff)),
                            child: Text(gate),
                          ),
                          DefaultTextStyle(
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: const Color(0xffffffff)),
                            child: Text(date),
                          ),
                          DefaultTextStyle(
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: const Color(0xffffffff)),
                            child: Text(id),
                          ),
                          DefaultTextStyle(
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: const Color(0xffffffff)),
                            child: Text(airport),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Color(0xff2f2762)),
                    ),
                  ),
                  Positioned(
                    top: 170,
                    left: 0,
                    child: Container(
                      child: DefaultTextStyle(
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: CupertinoColors.black),
                          child: Text(instrucoes)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Color(0xfff7fafc)),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    ),
                  ),
                  Positioned(
                    top: 30,
                    right: 30,
                    child: Image.asset(
                      "assets/path145.png",
                      width: 80,
                      height: 81,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 100,
                    child: Image.asset(
                      "assets/path144.png",
                      width: 30,
                      height: 30,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 20,
                    child: Image.asset(
                      "assets/path146.png",
                      width: 30,
                      height: 30,
                    ),
                  ),
                  Positioned(
                    top: 90,
                    right: 20,
                    child: Image.asset(
                      "assets/path105.png",
                      width: 30,
                      height: 30,
                    ),
                  ),
                ],
              ),
              Container(
                constraints:
                    BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green, // Color for "Concluído"
                      ),
                      onPressed: () {
                        updateStatus(
                          newStatus: 'Concluído',
                          name: name,
                          gate: gate,
                          date: date,
                          id: id,
                          instrucoes: instrucoes,
                          airport: airport,
                        );
                      },
                      child: Text('Concluído'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange, // Color for "Em andamento"
                      ),
                      onPressed: () {
                        updateStatus(
                          newStatus: 'Em andamento',
                          name: name,
                          gate: gate,
                          date: date,
                          id: id,
                          instrucoes: instrucoes,
                          airport: airport,
                        );
                      },
                      child: Text('Em andamento'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // Color for "A fazer"
                      ),
                      onPressed: () {
                        updateStatus(
                          newStatus: 'Á fazer',
                          name: name,
                          gate: gate,
                          date: date,
                          id: id,
                          instrucoes: instrucoes,
                          airport: airport,
                        );
                      },
                      child: Text('Á fazer'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // Color for "Cancelado"
                      ),
                      onPressed: () {
                        updateStatus(
                          newStatus: 'Cancelado',
                          name: name,
                          gate: gate,
                          date: date,
                          id: id,
                          instrucoes: instrucoes,
                          airport: airport,
                        );
                      },
                      child: Text('Cancelado'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

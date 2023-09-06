import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Maintenance {
  final String name;
  final String status;
  final String gate;
  final String date;
  final String id;
  final String airport;

  Maintenance(
      this.name, this.status, this.gate, this.date, this.id, this.airport);
}

class MaintenancePage extends StatefulWidget {
  @override
  _MaintenancePageState createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  List<Maintenance> maintenanceList = [];

  @override
  void initState() {
    super.initState();
    fetchMaintenanceData(); // Chame a função para buscar os dados da API ao iniciar a página
  }

  Future<void> fetchMaintenanceData() async {
    final response = await http.get(Uri.parse(
        'http://localhost:3000/maintenanceList')); // Faça a solicitação HTTP para a API

    if (response.statusCode == 200) {
      // Verifique se a solicitação foi bem-sucedida
      final List<dynamic> data = json.decode(response.body);
      final List<Maintenance> fetchedList = data
          .map((item) => Maintenance(item['name'], item['status'], item['gate'],
              item['date'], item['id'], item['airport']))
          .toList();

      setState(() {
        maintenanceList = fetchedList;
      });
    } else {
      throw Exception('Falha ao carregar os dados da manutenção');
    }
  }

  Icon _getStatusIcon(String status) {
    switch (status) {
      case 'A fazer':
        return Icon(CupertinoIcons.today,
            color: CupertinoColors.darkBackgroundGray);
      case 'Em andamento':
        return Icon(CupertinoIcons.timer_fill,
            color: CupertinoColors.activeOrange);
      case 'Cancelado':
        return Icon(CupertinoIcons.clear_thick_circled,
            color: CupertinoColors.systemRed);
      case 'Concluído':
        return Icon(CupertinoIcons.check_mark_circled_solid,
            color: CupertinoColors.activeGreen);
      default:
        return Icon(CupertinoIcons.question_circle_fill);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar:
          const CupertinoNavigationBar(middle: Text('Maintenance List')),
      child: SafeArea(
        child: ListView.separated(
          itemCount: maintenanceList.length,
          itemBuilder: (context, index) {
            final maintenance = maintenanceList[index];
            print(maintenance);
            return CupertinoListTile(
              title: Text(maintenance.name),
              subtitle: Text('Status: ${maintenance.status}'),
              trailing: _getStatusIcon(maintenance.status),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/maintenanceDetails',
                  arguments: {
                    'name': maintenance.name,
                    'status': maintenance.status,
                    'gate': maintenance.gate,
                    'date': maintenance.date,
                    'id': maintenance.id,
                    'airport': maintenance.airport,
                  },
                );
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
    );
  }
}

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

  List<String> statusOptions = [
    'A fazer',
    'Em andamento',
    'Concluído',
    'Cancelado'
  ];
  String selectedStatus = 'A fazer';

  List<String> airportOptions = ['Viracopos', 'Congonhas', 'Guarulhos'];
  String selectedAirport = 'Viracopos';

  List<String> gateOptions = ['A', 'B', 'C', 'D', 'E', 'F'];
  String selectedGate = 'A';

  TextEditingController dateController = TextEditingController();

  TextEditingController statusController = TextEditingController();
  TextEditingController airportController = TextEditingController();
  TextEditingController gateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMaintenanceData();
  }

  Future<void> fetchMaintenanceData() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/maintenanceList'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Maintenance> fetchedList = data
          .map((item) => Maintenance(
                item['name'] ?? '',
                item['status'] ?? '',
                item['gate'] ?? '',
                item['date'] ?? '',
                item['id'] ?? '',
                item['airport'] ?? '',
              ))
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

  Future<void> _addMaintenance(
    String name,
    String status,
    String gate,
    String date,
    String id,
    String airport,
  ) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/maintenanceList'),
      body: {
        'name': name,
        'status': status,
        'gate': gate,
        'date': date,
        'id': id,
        'airport': airport,
      },
    );

    if (response.statusCode == 200) {
      fetchMaintenanceData(); // Atualize a lista de manutenções após a adição bem-sucedida
    } else {
      throw Exception('Falha ao adicionar a manutenção');
    }
  }

  _showAddMaintenanceDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();

    dateController.text =
        DateTime.now().toLocal().toString(); // Define a data inicial

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Adicionar Manutenção'),
          content: Column(
            children: <Widget>[
              CupertinoTextField(
                controller: nameController,
                placeholder: 'Nome',
              ),
              CupertinoTextField(
                readOnly: true,
                controller: statusController, // Usar o controlador atualizado
                placeholder: 'Status',
                onTap: () {
                  showStatusSelector(context);
                },
              ),
              CupertinoTextField(
                readOnly: true,
                controller: airportController, // Usar o controlador atualizado
                placeholder: 'Aeroporto',
                onTap: () {
                  showAirportSelector(context);
                },
              ),
              CupertinoTextField(
                readOnly: true,
                controller: gateController, // Usar o controlador atualizado
                placeholder: 'Portão',
                onTap: () {
                  showGateSelector(context);
                },
              ),
              CupertinoTextField(
                controller: dateController,
                placeholder: 'Data',
                readOnly: true,
                onTap: () {
                  showDatePicker(context);
                },
              ),
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text('Adicionar'),
              onPressed: () {
                _addMaintenance(
                  nameController.text,
                  selectedStatus,
                  selectedGate,
                  dateController.text,
                  '', // ID será gerado pelo servidor ou banco de dados
                  selectedAirport,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showStatusSelector(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('Select Status'),
          actions: statusOptions.map((status) {
            return CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, status);
                setState(() {
                  statusController.text = status; // Atualiza o controlador
                });
              },
              child: Text(status),
            );
          }).toList(),
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
            isDefaultAction: true,
          ),
        );
      },
    );
  }

// Repita o mesmo padrão para showAirportSelector e showGateSelector

  void showAirportSelector(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('Select Airport'),
          actions: airportOptions.map((airport) {
            return CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, airport);
              },
              child: Text(airport),
            );
          }).toList(),
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
            isDefaultAction: true,
          ),
        );
      },
    ).then((selectedValue) {
      if (selectedValue != null) {
        setState(() {
          selectedAirport = selectedValue;
        });
      }
    });
  }

  void showGateSelector(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('Select Gate'),
          actions: gateOptions.map((gate) {
            return CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, gate);
              },
              child: Text(gate),
            );
          }).toList(),
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
            isDefaultAction: true,
          ),
        );
      },
    ).then((selectedValue) {
      if (selectedValue != null) {
        setState(() {
          selectedGate = selectedValue;
        });
      }
    });
  }

  void showDatePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() {
                dateController.text = newDateTime.toLocal().day.toString() +
                    '/' +
                    newDateTime.toLocal().month.toString() +
                    "/" +
                    newDateTime.toLocal().year.toString();
              });
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Maintenance List'),
        trailing: CupertinoButton(
          child: Icon(CupertinoIcons.add),
          onPressed: () {
            _showAddMaintenanceDialog(context);
          },
        ),
      ),
      child: SafeArea(
        child: ListView.separated(
          itemCount: maintenanceList.length,
          itemBuilder: (context, index) {
            final maintenance = maintenanceList[index];
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

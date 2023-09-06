import 'package:flutter/cupertino.dart';

class MaintenanceDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? maintenanceData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (maintenanceData == null) {
      // Trate o caso em que os dados não foram fornecidos ou são inválidos.
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
    final String airport = maintenanceData['airport'] ?? 'Unknown';
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('$name')),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Maintenance Name: $name'),
            Text('Status: $status'),
            Text('Gate: $gate'),
            Text('Date: $date'),
            Text('ID: $id'),
            Text('Airport: $airport'),
            _getStatusIcon(status),
          ],
        ),
      ),
    );
  }

  Icon _getStatusIcon(String status) {
    switch (status) {
      case 'A fazer':
        return Icon(CupertinoIcons.time, color: CupertinoColors.activeBlue);
      case 'Em andamento':
        return Icon(CupertinoIcons.timer, color: CupertinoColors.activeOrange);
      case 'Cancelado':
        return Icon(CupertinoIcons.nosign, color: CupertinoColors.systemRed);
      case 'Concluído':
        return Icon(CupertinoIcons.check_mark_circled_solid,
            color: CupertinoColors.activeGreen);
      default:
        return Icon(CupertinoIcons.question);
    }
  }
}

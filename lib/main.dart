import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class Maintenance {
  final String name;
  String status;

  Maintenance(this.name, this.status);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
        '/maintenance': (context) => MaintenancePage(),
        '/maintenanceDetails': (context) => MaintenanceDetailsPage(),
        '/scanner': (context) => ScannerPage(),
        '/estoque': (context) => EstoquePage(),
        '/perfil': (context) => PerfilPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _NextMaintenanceBanner(
            airplaneName: 'Airplane 123',
            airportCode: 'GRU',
            gate: 'A4',
            date: '2023-09-01',
            time: '10:30 AM',
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _CustomButton(
                icon: Icons.build,
                color: Colors.blue,
                title: 'Maintenance',
                onPressed: () {
                  Navigator.pushNamed(context, '/maintenance');
                },
              ),
              SizedBox(width: 20),
              _CustomButton(
                icon: Icons.qr_code,
                color: Colors.green,
                title: 'Scanner',
                onPressed: () {
                  Navigator.pushNamed(context, '/scanner');
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _CustomButton(
                icon: Icons.storage,
                color: Colors.orange,
                title: 'Estoque',
                onPressed: () {
                  Navigator.pushNamed(context, '/estoque');
                },
              ),
              SizedBox(width: 20),
              _CustomButton(
                icon: Icons.person,
                color: Colors.purple,
                title: 'Perfil',
                onPressed: () {
                  Navigator.pushNamed(context, '/perfil');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NextMaintenanceBanner extends StatelessWidget {
  final String airplaneName;
  final String airportCode;
  final String gate;
  final String date;
  final String time;

  const _NextMaintenanceBanner({
    required this.airplaneName,
    required this.airportCode,
    required this.gate,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Próxima Manutenção',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(airplaneName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(airportCode),
          Text(gate),
          Text(date),
          Text(time),
        ],
      ),
    );
  }
}

class _CustomButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final VoidCallback onPressed;

  const _CustomButton({
    required this.icon,
    required this.color,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: 'Email')),
            TextField(decoration: InputDecoration(labelText: 'Password')),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Center(
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: 'Name')),
            TextField(decoration: InputDecoration(labelText: 'Email')),
            TextField(decoration: InputDecoration(labelText: 'Password')),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

class MaintenancePage extends StatelessWidget {
  final List<Maintenance> maintenanceList = [
    Maintenance('Maintenance 1', 'A fazer'),
    Maintenance('Maintenance 2', 'Em andamento'),
    Maintenance('Maintenance 3', 'Cancelado'),
    Maintenance('Maintenance 4', 'Concluído'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Maintenance List')),
      body: ListView.builder(
        itemCount: maintenanceList.length,
        itemBuilder: (context, index) {
          final maintenance = maintenanceList[index];
          return ListTile(
            title: Text(maintenance.name),
            subtitle: Text('Status: ${maintenance.status}'),
            trailing: _getStatusIcon(maintenance.status),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/maintenanceDetails',
                arguments: maintenance,
              );
            },
          );
        },
      ),
    );
  }

  Icon _getStatusIcon(String status) {
    switch (status) {
      case 'A fazer':
        return Icon(Icons.access_time, color: Colors.blue);
      case 'Em andamento':
        return Icon(Icons.timer, color: Colors.orange);
      case 'Cancelado':
        return Icon(Icons.cancel, color: Colors.red);
      case 'Concluído':
        return Icon(Icons.check_circle, color: Colors.green);
      default:
        return Icon(Icons.help_outline);
    }
  }
}

class MaintenanceDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final maintenance =
        ModalRoute.of(context)!.settings.arguments as Maintenance?;

    return Scaffold(
      appBar: AppBar(title: Text('Maintenance Details')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Details for: ${maintenance?.name ?? 'Unknown'}'),
            Text('Status: ${maintenance?.status ?? 'Unknown'}'),
            _getStatusIcon(maintenance?.status ?? ''),
          ],
        ),
      ),
    );
  }

  Icon _getStatusIcon(String status) {
    switch (status) {
      case 'A fazer':
        return Icon(Icons.access_time, color: Colors.blue);
      case 'Em andamento':
        return Icon(Icons.timer, color: Colors.orange);
      case 'Cancelado':
        return Icon(Icons.cancel, color: Colors.red);
      case 'Concluído':
        return Icon(Icons.check_circle, color: Colors.green);
      default:
        return Icon(Icons.help_outline);
    }
  }
}

class ScannerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scanner')),
      body: Center(
        child: Text('Scanner Page Content'),
      ),
    );
  }
}

class EstoquePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Estoque')),
      body: Center(
        child: Text('Estoque Page Content'),
      ),
    );
  }
}

class PerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      body: Center(
        child: Text('Perfil Page Content'),
      ),
    );
  }
}

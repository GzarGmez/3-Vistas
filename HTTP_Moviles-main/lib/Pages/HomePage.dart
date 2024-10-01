import 'package:app_movil/Pages/NextPage.dart';
import 'package:app_movil/Pages/ThirdPage.dart'; 
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Lista de integrantes del equipo
  final List<Map<String, String>> teamMembers = const [
    {"name": "Andres Guizar Gómez 213360", "phone": "963 171 8235", "message": "963 171 8235"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alumno'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: teamMembers.length,
              itemBuilder: (context, index) {
                final member = teamMembers[index];
                return ListTile(
                  title: Text(member['name']!),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.phone),
                        onPressed: () => _makePhoneCall(member['phone']!),
                      ),
                      IconButton(
                        icon: const Icon(Icons.message),
                        onPressed: () => _sendSMS(member['message']!),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            color: const Color.fromARGB(255, 25, 133, 147),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NextPage()),
                );
              },
              child: const Text(
                'Libros Aleatorios',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
         
          Container(
            width: double.infinity,
            color: const Color.fromARGB(255, 22, 109, 129), // Puedes cambiar el color si lo deseas
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ThirdPage()),
                );
              },
              child: const Text(
                'Usuario',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Método para hacer llamadas
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      throw 'No se pudo realizar la llamada';
    }
  }

  // Método para enviar SMS
  Future<void> _sendSMS(String phoneNumber) async {
    final Uri smsUri = Uri(scheme: 'sms', path: phoneNumber);
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      throw 'No se pudo enviar el mensaje';
    }
  }
}
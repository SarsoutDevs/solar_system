import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('النظام الشمسي'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('planets').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur de chargement'));
          }

          // Récupération des planètes
          final planets = snapshot.data!.docs;

          return ListView.builder(
            itemCount: planets.length,
            itemBuilder: (context, index) {
              var planet = planets[index];
              return ListTile(
                title: Text(planet['name']),
                subtitle: Text(
                    'الشعاع: ${planet['radius']} كم\nالمسافة من الشمس: ${planet['distanceFromSun']} كم'),
                leading: Image.network(planet['imageUrl']),
              );
            },
          );
        },
      ),
    );
  }
}

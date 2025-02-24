import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Center(
          child: Text('User Details'),
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<UserProvider>(context, listen: false).fetchUsers(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Consumer<UserProvider>(
              builder: (ctx, userProvider, _) {
                if (userProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: userProvider.users.length,
                    itemBuilder: (ctx, index) {
                      final user = userProvider.users[index];
                      return ListTile(
                        title: Text(user.name),
                        subtitle: Text(user.email),
                        trailing: Text(user.phone),
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}

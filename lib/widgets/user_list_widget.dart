import 'package:dsw_aplikacje_mobilne_projekt/database/user_db.dart';
import 'package:dsw_aplikacje_mobilne_projekt/models/user_model.dart';
import 'package:dsw_aplikacje_mobilne_projekt/widgets/user_widget.dart';
import 'package:flutter/material.dart';

class UserListWidget extends StatefulWidget {
  const UserListWidget({super.key});

  @override
  State<UserListWidget> createState() => _UserListWidgetState();
}

class _UserListWidgetState extends State<UserListWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>?>(
      future: UserDatabase.getAllUsers(),
      builder: (context, AsyncSnapshot<List<User>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        } else if (snapshot.hasData) {
          if (snapshot.data != null) {
            return ListView.builder(
              itemBuilder: (context, index) => UserWidget(
                user: snapshot.data![index],
                onTap: () {},
                onLongPress: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                            'Are you sure you want to delete this user?'),
                        actions: [
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                            onPressed: () async {
                              await UserDatabase.deleteUser(
                                  snapshot.data![index]);
                              Navigator.pop(context);
                              setState(() {});
                            },
                            child: const Text('Yes'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('No'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              itemCount: snapshot.data!.length,
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}

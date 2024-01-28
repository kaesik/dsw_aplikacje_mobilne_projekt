import 'package:dsw_aplikacje_mobilne_projekt/models/user_model.dart';
import 'package:flutter/material.dart';

class UserWidget extends StatelessWidget {
  final User user;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  const UserWidget({
    super.key,
    required this.user,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'User Name: ${user.name}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                Text('email: ${user.email}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                Text('password: ${user.password}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

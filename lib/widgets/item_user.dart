import 'package:f_home_mo/provider/user.dart';
import 'package:f_home_mo/repostitory/user_repository.dart';
import 'package:flutter/material.dart';

class ItemUser extends StatelessWidget {
  final UserModel userModel;
  const ItemUser({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
              userModel.imgUrl,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userModel.fullname,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      'Status: ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      userModel.status.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (!userModel.status)
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () async {
                    UserRepository().updateStatus(userModel);
                  },
                  child: const Text('Change Status'),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

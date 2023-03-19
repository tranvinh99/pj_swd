import 'package:f_home_mo/models/post.dart';
import 'package:f_home_mo/provider/user.dart';
import 'package:f_home_mo/screens/post_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ItemPost extends StatefulWidget {
  final PostModel postModel;

  const ItemPost({
    super.key,
    required this.postModel,
  });

  @override
  State<ItemPost> createState() => _ItemPostState();
}

class _ItemPostState extends State<ItemPost> {
  late UserModel userModel;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    List<UserModel> users = context.read<UserProvider>().list;
    for (var user in users) {
      if (user.id == widget.postModel.userPosting) {
        userModel = user;
        setState(() {
          _isLoading = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PostDetailScreen(
              postModel: widget.postModel,
              userModel: userModel,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isLoading == true)
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
                  if (_isLoading == true)
                    Text(
                      userModel.fullname,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  const SizedBox(height: 1),
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
                        widget.postModel.status.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Tên Room',
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 1),
                  const Text(
                    'Tên Building',
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    widget.postModel.title!,
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 1),
                  if (widget.postModel.img != null)
                    Text(
                      widget.postModel.img!,
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                ],
              ),
            ),
            Text(
              DateFormat("dd-MM-yyyy")
                  .format(DateTime.parse(
                    widget.postModel.createdAt!,
                  ))
                  .toString(),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

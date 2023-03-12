import 'package:f_home_mo/models/post.dart';
import 'package:f_home_mo/provider/user.dart';
import 'package:f_home_mo/repostitory/user_repository.dart';
import 'package:f_home_mo/screens/post_detail_screen.dart';
import 'package:flutter/material.dart';

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
    userModel =
        await UserRepository().getUserInfo(widget.postModel.userPosting);
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
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
        padding: const EdgeInsets.only(bottom: 10.0),
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
                  Text(
                    'Tên Room',
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    'Tên Building',
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    widget.postModel.description,
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

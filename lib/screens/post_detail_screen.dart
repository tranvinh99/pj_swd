import 'package:f_home_mo/models/post.dart';
import 'package:f_home_mo/provider/user.dart';
import 'package:f_home_mo/widgets/item_post.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostDetailScreen extends StatefulWidget {
  final PostModel postModel;
  final UserModel userModel;

  const PostDetailScreen({
    super.key,
    required this.postModel,
    required this.userModel,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết bài đăng'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    widget.userModel.imgUrl,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.userModel.fullname,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            DateFormat("dd-MM-yyyy")
                                .format(DateTime.parse(
                                  widget.postModel.createdAt,
                                ))
                                .toString(),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 1),
                      const Text(
                        'Tên Room',
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
                        widget.postModel.description,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.close),
                    SizedBox(width: 10),
                    Text('Từ chối'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: const [
                    Icon(Icons.check),
                    SizedBox(width: 10),
                    Text('Chấp thuận'),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

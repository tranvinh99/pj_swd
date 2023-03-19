import 'package:f_home_mo/models/post.dart';
import 'package:f_home_mo/provider/user.dart';
import 'package:f_home_mo/repostitory/post_repository.dart';
import 'package:f_home_mo/utils/utils.dart';
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
  bool isLoading = false;
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
                        widget.postModel.description!,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (widget.postModel.img != null)
                        Image.network(widget.postModel.img!),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (widget.postModel.status == 'pending')
            isLoading == false
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await PostRepository()
                              .rejectPost(widget.postModel.id!);
                          Navigator.of(context).pop();
                          showSnackBar(context, 'Từ chối bài viết thành công');
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
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
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await PostRepository()
                              .approvePost(widget.postModel.id!);
                          Navigator.of(context).pop();
                          showSnackBar(
                              context, 'Chấp nhận bài viết thành công');
                        },
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
                : const Center(
                    child: CircularProgressIndicator(),
                  )
        ],
      ),
    );
  }
}

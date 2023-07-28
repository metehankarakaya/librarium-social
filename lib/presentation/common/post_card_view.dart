import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:librarium/model/post.dart';

import '../dashboard/dashboard_view_model.dart';

class PostCard extends StatefulWidget {
  final DashboardViewModel viewModel;
  final Post post;
  final VoidCallback goOtherProfile;

  const PostCard({
    Key? key,
    required this.viewModel,
    required this.post,
    required this.goOtherProfile,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formatCreatedDate();
  }

  String formattedCreatedDate = "";
  formatCreatedDate() {
    setState(() {
      DateTime createdDate = DateTime.parse("${widget.post.createdDate}");
      formattedCreatedDate = DateFormat("d MMMM hh.mm a").format(createdDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: GestureDetector(
                onTap: () => widget.viewModel.goOtherProfile(otherUserId: widget.post.user?.id ?? ""),
                child: CircleAvatar(
                  radius: 25,
                    backgroundImage: MemoryImage(widget.post.user!.avatar!)
                ),
              ),
              title: Text(
                "${widget.post.user!.username}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "${widget.post.user!.firstName} ${widget.post.user!.lastName}",
              ),
              trailing: IconButton(
                onPressed: () {

                },
                splashRadius: 20,
                icon: const Icon(Icons.more_horiz),
              ),
            ),
            const Divider(),
            Column(
              children: [
                if (widget.post.content != null && widget.post.content!.isNotEmpty) ... [
                  ListTile(
                    title: Text(
                      "${widget.post.content}",
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
                if (widget.post.image != null) ... [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Image.memory(widget.post.image!),
                  )
                ],
                ListTile(
                  subtitle: Text(formattedCreatedDate, textAlign: TextAlign.end,),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

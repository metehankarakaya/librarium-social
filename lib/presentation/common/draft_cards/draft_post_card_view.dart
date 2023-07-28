import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:librarium/model/post.dart';
import 'package:librarium/presentation/draft/draft_view_model.dart';

class DraftPostCard extends StatefulWidget {
  final DraftViewModel viewModel;
  final Post post;

  const DraftPostCard({
    Key? key,
    required this.viewModel,
    required this.post,
  }) : super(key: key);

  @override
  State<DraftPostCard> createState() => _DraftPostCardState();
}

class _DraftPostCardState extends State<DraftPostCard> {

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
      formattedCreatedDate = DateFormat("d MMMM hh.mm").format(createdDate);
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
                tooltip: "More Settings", //delete, share
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
                  subtitle: Text("Date saved in drafts: $formattedCreatedDate", textAlign: TextAlign.end,),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

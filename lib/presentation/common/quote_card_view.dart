import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:librarium/model/quote.dart';
import 'package:librarium/presentation/resources/string_manager.dart';

import '../dashboard/dashboard_view_model.dart';

class QuoteCard extends StatefulWidget {
  final DashboardViewModel viewModel;
  final Quote quote;
  final VoidCallback onLike;
  final VoidCallback onDislike;
  final VoidCallback goOtherProfile;

  const QuoteCard({
    Key? key,
    required this.viewModel,
    required this.quote,
    required this.onLike,
    required this.onDislike,
    required this.goOtherProfile,
  }) : super(key: key);

  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formatCreatedDate();
  }

  String formattedCreatedDate = "";
  formatCreatedDate() {
    setState(() {
      DateTime createdDate = DateTime.parse("${widget.quote.createdDate}");
      formattedCreatedDate = DateFormat("d MMMM").format(createdDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: () => widget.viewModel.goOtherProfile(otherUserId: widget.quote.user?.id ?? ""),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: MemoryImage(widget.quote.user!.avatar!)
                      ),
                    ),
                    title: Text(
                      "${widget.quote.user!.username}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "${widget.quote.user!.firstName} ${widget.quote.user!.lastName}",
                    ),
                    trailing: IconButton(
                      onPressed: () {

                      },
                      splashRadius: 20,
                      icon: const Icon(Icons.more_horiz),
                    ),
                  ),
                )
              ],
            ),
            const Divider(),
            ListTile(
              title: Text(
                "${widget.quote.content}",
                textAlign: TextAlign.center,
                maxLines: 5,
                style: const TextStyle(overflow: TextOverflow.ellipsis),
              ),
            ),
            ListTile(
              title: Text(
                "${widget.quote.book?.title} - ${widget.quote.book?.author?.firstName} ${widget.quote.book?.author?.lastName}",
                textAlign: TextAlign.start,
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${AppString.page} ${widget.quote.pageNumber}",
                  ),
                  Text(formattedCreatedDate),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

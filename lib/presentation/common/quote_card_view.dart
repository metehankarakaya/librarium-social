import 'package:flutter/material.dart';
import 'package:librarium/model/quote.dart';
import 'package:librarium/presentation/home/home_view_model.dart';
import 'package:librarium/presentation/resources/string_manager.dart';

class QuoteCard extends StatelessWidget {
  final HomeViewModel viewModel;
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
                      onTap: () => viewModel.goOtherProfile(otherUserId: quote.user?.id ?? ""),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: MemoryImage(quote.user!.avatar!)
                      ),
                    ),
                    title: Text(
                      "${quote.user!.username}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "${quote.user!.firstName} ${quote.user!.lastName}",
                    ),
                    trailing: IconButton(
                      onPressed: () {

                      },
                      splashRadius: 20,
                      icon: const Icon(Icons.more_vert),
                    ),
                  ),
                )
              ],
            ),
            const Divider(),
            ListTile(
              title: Text(
                "${quote.content}",
                textAlign: TextAlign.center,
                maxLines: 5,
                style: const TextStyle(overflow: TextOverflow.ellipsis),
              ),
            ),
            ListTile(
              title: Text(
                "${quote.book?.title} - ${quote.book?.author?.firstName} ${quote.book?.author?.lastName}",
                textAlign: TextAlign.start,
              ),
              subtitle: Text(
                "${AppString.page} ${quote.pageNumber}",
                textAlign: TextAlign.start,
              ),
            )
          ],
        ),
      ),
    );
  }
}

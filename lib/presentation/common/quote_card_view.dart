import 'package:flutter/material.dart';
import 'package:librarium/model/quote.dart';
import 'package:librarium/presentation/home/home_view_model.dart';
import 'package:librarium/presentation/resources/asset_manager.dart';

class QuoteCard extends StatelessWidget {
  final HomeViewModel viewModel;
  final Quote quote;
  final VoidCallback onLike;
  final VoidCallback onDislike;

  const QuoteCard({
    Key? key,
    required this.viewModel,
    required this.quote,
    required this.onLike,
    required this.onDislike,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: MemoryImage(quote.user!.avatar!)
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text("@${quote.user!.username}", textAlign: TextAlign.center,),
                    subtitle: Text(
                      "${quote.user!.firstName} ${quote.user!.lastName}",
                      textAlign: TextAlign.center,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => viewModel.dislikeQuote(quoteId: "${quote.id}"),
                  splashRadius: 20,
                  icon: Icon(
                    Icons.thumb_down,
                    color: viewModel.likeBoolean ? Colors.red : Colors.red.shade200,
                  ),
                ),
                IconButton(
                  onPressed: () => viewModel.likeQuote(quoteId: "${quote.id}"),
                  splashRadius: 20,
                  icon: Icon(
                    Icons.thumb_up,
                    color: viewModel.likeBoolean ? Colors.blue : Colors.blue.shade200,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

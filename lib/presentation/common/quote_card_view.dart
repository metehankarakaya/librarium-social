import 'package:flutter/material.dart';
import 'package:librarium/model/quote.dart';
import 'package:librarium/presentation/home/home_view_model.dart';

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(

                ),
                Expanded(
                  child: ListTile(
                    title: const Text("Binboğalar efsanesi", textAlign: TextAlign.center,),
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

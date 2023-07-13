import 'package:flutter/material.dart';
import 'package:librarium/presentation/explore/book_search/book_search_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../resources/color_manager.dart';
import '../../resources/string_manager.dart';

class BookSearchView extends StatefulWidget {
  const BookSearchView({Key? key}) : super(key: key);

  @override
  State<BookSearchView> createState() => _BookSearchViewState();
}

class _BookSearchViewState extends State<BookSearchView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ViewModelBuilder<BookSearchViewModel>.reactive(
      viewModelBuilder: () {
        BookSearchViewModel viewModel = BookSearchViewModel(context);
        viewModel.start();
        return viewModel;
      },
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: AppColor.bgColor,
        body: Column(
          children: [
            TextFormField(
              onChanged: (val) {},
              decoration: const InputDecoration(
                hintText: AppString.searchBook,
                prefixIcon: Icon(Icons.search),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 8.0, bottom: 4.0),
                child: Text(
                  AppString.randomBooks,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 24,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overScroll) {
                  overScroll.disallowIndicator();
                  return true;
                },
                child: SizedBox(
                  width: size.width,
                  height: size.height/5,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: viewModel.randomBooks.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 8.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.memory(viewModel.randomBooks[index].coverImage!, fit: BoxFit.cover,),
                          )
                        ),
                      );
                    },
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}

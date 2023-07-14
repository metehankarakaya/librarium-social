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
              onFieldSubmitted: (keyword) {
                if (keyword.length >= 3 && keyword.length <= 20) {
                  viewModel.findBooksByKeyword(keyword);
                }
              },
              decoration: InputDecoration(
                hintText: AppString.searchBook,
                prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: () => viewModel.showSearchBookRules(),
                    splashRadius: 20,
                    icon: Icon(Icons.info_outline, color: AppColor.blue900,),
                  )
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text("Results: ${viewModel.foundBooks.length}",),
                    ),
                  ),
                  Expanded(
                    child: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll) {
                        overScroll.disallowIndicator();
                        return true;
                      },
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: viewModel.foundBooks.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black45,
                                    offset: Offset(0, 2),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                child: ClipOval(
                                  child: Image(
                                    height: 50.0,
                                    width: 50.0,
                                    image: MemoryImage(viewModel.foundBooks[index].coverImage!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            onTap: () => viewModel.findBookDetails(bookId: viewModel.foundBooks[index].id ?? ""),
                            title: Text(
                              "${viewModel.foundBooks[index].title}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "${viewModel.foundBooks[index].author?.firstName} ${viewModel.foundBooks[index].author?.lastName}"
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.only(top: 4.0, left: 8.0, bottom: 4.0),
                  child: Text(
                    AppString.randomUsers,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 24,
                      decoration: TextDecoration.underline,
                    ),
                  )
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
                        onTap: () => viewModel.findBookDetails(bookId: viewModel.randomBooks[index].id ?? ""),
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

import 'package:flutter/material.dart';
import 'package:librarium/presentation/common/draft_cards/draft_post_card_view.dart';
import 'package:librarium/presentation/common/draft_cards/quote_draft_card_view.dart';
import 'package:librarium/presentation/draft/draft_view_model.dart';
import 'package:librarium/presentation/resources/color_manager.dart';
import 'package:librarium/presentation/resources/string_manager.dart';
import 'package:stacked/stacked.dart';

class DraftView extends StatefulWidget {
  const DraftView({Key? key}) : super(key: key);

  @override
  State<DraftView> createState() => _DraftViewState();
}

class _DraftViewState extends State<DraftView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ViewModelBuilder<DraftViewModel>.reactive(
      viewModelBuilder: () {
        DraftViewModel viewModel = DraftViewModel(context);
        viewModel.start();
        return viewModel;
      },
      builder: (context, viewModel, child) => DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppColor.bgColor,
          body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowIndicator();
              return true;
            },
            child: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    sliver: SliverAppBar(
                      snap: true,
                      pinned: true,
                      floating: true,
                      leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        splashRadius: 20,
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      title: viewModel.draft.capacity != null ? Text("${AppString.draft} (${viewModel.draftSize}/${viewModel.draft.capacity})") : const Text(AppString.draft),
                      centerTitle: true,
                      forceElevated: innerBoxIsScrolled,
                      bottom: TabBar(
                        indicatorColor: AppColor.transparent,
                        labelColor: AppColor.white,
                        unselectedLabelColor: AppColor.indigo400,
                        tabs: const [
                          Tab(text: AppString.post,),
                          Tab(text: AppString.quote,),
                        ],
                      ),
                    ),
                  )
                ];
              },
              body: TabBarView(
                children: [
                  Builder(
                    builder: (context) {
                      return CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          SliverOverlapInjector(
                            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: viewModel.draft.posts?.length,
                              (context, index) {
                                if (viewModel.draft.posts?[index] != null) {
                                  return DraftPostCard(
                                    viewModel: viewModel,
                                    post: viewModel.reversedPostList[index],
                                  );
                                }
                              }
                            ),
                          )
                        ],
                      );
                    }
                  ),
                  Builder(
                    builder: (context) {
                      return CustomScrollView(
                        slivers: [
                          SliverOverlapInjector(
                            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: viewModel.draft.quotes?.length,
                              (context, index) {
                                if (viewModel.draft.quotes?[index] != null) {
                                  return DraftQuoteCard(
                                    viewModel: viewModel,
                                    quote: viewModel.reversedQuoteList[index],
                                    onLike:  () {},
                                    onDislike:  () {},
                                    goOtherProfile: () => viewModel.goOtherProfile(),
                                  );
                                }
                              }
                            ),
                          )
                        ],
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
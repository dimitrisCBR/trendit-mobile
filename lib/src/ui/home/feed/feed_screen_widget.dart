import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trendit/src/domain/api/api_exception.dart';
import 'package:trendit/src/domain/model/trends_response.dart';
import 'package:trendit/src/domain/trendit_repository.dart';
import 'package:trendit/src/ui/common/trendit_banner_widget.dart';
import 'package:trendit/src/ui/common/trendit_error_widget.dart';
import 'package:trendit/src/ui/common/trendit_loading_indicator.dart';
import 'package:trendit/src/ui/home/feed/items/feed_item_widget.dart';

class TrendsFeedWidget extends StatefulWidget {
  final String title = "Trendit";
  final String subtitle = "what is happening right now";

  const TrendsFeedWidget({super.key});

  @override
  _TrendsFeedWidgetState createState() => _TrendsFeedWidgetState();
}

class _TrendsFeedWidgetState extends State<TrendsFeedWidget> {
  late TrendsViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = TrendsViewModel();
    viewModel.fetchData();
  }

  Future<void> _refreshList() async {
    viewModel.fetchData();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
        body: StreamBuilder<Trends?>(
            stream: viewModel.itemsStream,
            builder: (context, snapshot) {
              return RefreshIndicator(
                edgeOffset: statusBarHeight,
                onRefresh: _refreshList,
                child: _generateListItemsFromSnap(snapshot),
              );
            }));
  }

  _generateListItemsFromSnap(AsyncSnapshot<Trends?> snapshot) {
    if (snapshot.hasData) {
      Trends trends = snapshot.data as Trends;
      return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          if (index == 0) {
            return TrenditBannerWidget(widget.title, widget.subtitle);
          } else if (index == 1) {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: FeedExpansionTileWidget(trends.googleTrend));
          } else if (index == 2) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: FeedExpansionTileWidget(trends.twitterTrend),
            );
          } else if (index == 3) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: FeedExpansionTileWidget(trends.youtubeTrend),
            );
          }
          return null;
        },
      );
    } else if (snapshot.hasError) {
      return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return TrenditBannerWidget(widget.title, widget.subtitle);
          } else if (index == 1) {
            String message;
            Object? e = snapshot.error;
            if (e is APIException) {
              message = e.message;
            } else {
              message = e.toString();
            }
            return Padding(
                padding: const EdgeInsetsDirectional.only(top: 100),
                child: TrenditErrorWidget(
                    errorMessage: message,
                    callback: () {
                      _refreshList();
                    }));
          }
          return null;
        },
      );
    } else {
      return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return TrenditBannerWidget(widget.title, widget.subtitle);
          } else if (index == 1) {
            return const Padding(
              padding: EdgeInsets.only(top: 200.0),
              child: TrenditLoadingIndicator(50.0),
            );
          }
          return null;
        },
      );
    }
  }
}

class TrendsViewModel {
  final _itemsController = StreamController<Trends?>();

  Stream<Trends?> get itemsStream => _itemsController.stream;
  final _repo = TrenditRepository();

  TrendsViewModel();

  void fetchData() async {
    try {
      _itemsController.add(null);
      final trends = await _repo.fetchTrends();
      // Update the stream with the fetched data
      _itemsController.add(trends);
    } catch (error) {
      _itemsController.addError(error);
    }
  }

  void dispose() {
    _itemsController.close();
  }
}

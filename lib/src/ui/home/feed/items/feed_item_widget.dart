import 'package:flutter/material.dart';
import 'package:trendit/src/domain/model/trends_response.dart';
import 'package:trendit/src/ui/home/feed/items/google_item.dart';
import 'package:trendit/src/ui/home/feed/items/twitter_item.dart';
import 'package:trendit/src/ui/home/feed/items/youtube_item.dart';
import 'package:trendit/src/util/utils.dart';

class FeedExpansionTileWidget extends StatefulWidget {
  final TrendStore store;

  const FeedExpansionTileWidget(this.store, {super.key});

  @override
  _FeedExpansionTileWidgetState createState() => _FeedExpansionTileWidgetState();
}

class _FeedExpansionTileWidgetState extends State<FeedExpansionTileWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Card(
        child: ExpansionTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              widget.store.getTrendCardTitle(),
              style: const TextStyle(
                fontSize: 24.0,
              ),
            ),
          ),
          trailing: Icon(
            _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          ),
          onExpansionChanged: (value) {
            setState(() {
              _isExpanded = value;
            });
          },
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.store.trends?.length ?? 0,
              separatorBuilder: (context, index) => const Divider(
                // color: Colors.blue, // Customize the color of the divider
                thickness: 2.0, // Customize the thickness of the divider
                indent: 16.0, // Customize the indent of the divider
                endIndent: 16.0, // Customize the end indent of the divider
              ),
              itemBuilder: (context, index) {
                dynamic trendItem = widget.store.trends![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: _createTrendRowWidget(trendItem),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _createTrendRowWidget(dynamic item) {
    if (item is GoogleTrend) {
      return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            launchURL(item.linkUrl);
          },
          child: GoogleItemWidget(googleTrend: item));
    } else if (item is TwitterTrend) {
      return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            launchURL(item.url);
          },
          child: TwitterItem(twitterTrend: item));
    } else if (item is YoutubeTrend) {
      return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            launchURL('http://www.youtube.com/watch?v=${item.videoId}');
          },
          child: YoutubeVideoWidget(item));
    } else {
      throw Exception("Unknown object: $item");
    }
  }
}

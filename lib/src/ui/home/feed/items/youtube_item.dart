import 'package:flutter/material.dart';
import 'package:trendit/src/domain/model/trends_response.dart';
import 'package:trendit/src/util/text_utils.dart';
import 'package:intl/intl.dart';

class YoutubeVideoWidget extends StatelessWidget {
  final YoutubeTrend youtubeTrend;

  YoutubeVideoWidget(this.youtubeTrend, {super.key});

  final NumberFormat _compactNf = NumberFormat.compact();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          youtubeTrend.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(height: 8.0),
        Image.network(
          youtubeTrend.thumbnailUrl,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 8.0),
        Text(
          youtubeTrend.channelTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
            '${getFormattedTraffic(youtubeTrend.viewCount, "views")}, '
            '${getFormattedTraffic(youtubeTrend.likeCount, "likes")}, '
            '${getFormattedTraffic(youtubeTrend.commentCount, "comments")}',
            style: const TextStyle(fontSize: 14.0)),
        const SizedBox(height: 8.0),
      ],
    );
  }

  String getFormattedTraffic(int volume, String trafficType) {
    if (volume > 1000000) {
      return "${_compactNf.format(volume)} $trafficType ${emojiFire.code}";
    } else if (volume > 500000) {
      return "${_compactNf.format(volume)} $trafficType ${emojiChart.code}";
    } else {
      return "${_compactNf.format(volume)} $trafficType ";
    }
  }

}

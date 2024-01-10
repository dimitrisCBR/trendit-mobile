import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trendit/src/domain/model/trends_response.dart';
import 'package:trendit/src/util/text_utils.dart';

class GoogleItemWidget extends StatelessWidget {
  final GoogleTrend googleTrend;

  GoogleItemWidget({
    required this.googleTrend,
  });

  final NumberFormat _compactNf = NumberFormat.compact();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
              child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      googleTrend.thumbnailUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) {
                          return child;
                        } else {
                          return Container(
                            color: Theme.of(context).colorScheme.secondaryContainer,
                          );
                        }
                      },
                    ),
                  ))),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  googleTrend.title,
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  getFormattedTraffic(googleTrend.volume, "searches"),
                  maxLines: 1,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.0),
                Text(
                  googleTrend.snippet,
                  maxLines: 2,
                  style: TextStyle(fontSize: 14.0),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String getFormattedTraffic(int volume, String trafficType) {
    if (volume > 50000) {
      return "${_compactNf.format(volume)} $trafficType ${emojiFire.code}";
    } else if (volume >= 20000) {
      return "${_compactNf.format(volume)} $trafficType ${emojiChart.code}";
    } else {
      return "${_compactNf.format(volume)} $trafficType";
    }
  }
}

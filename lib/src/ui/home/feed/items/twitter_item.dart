import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trendit/src/domain/model/trends_response.dart';
import 'package:trendit/src/ui/common/chip_row_widget.dart';
import 'package:trendit/src/util/text_utils.dart';

class TwitterItem extends StatelessWidget {
  final TwitterTrend twitterTrend;

  TwitterItem({super.key, required this.twitterTrend});

  final NumberFormat _compactNf = NumberFormat.compact();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              twitterTrend.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Text(
              twitterTrend.volume > 0
                  ? "${getFormattedTraffic(twitterTrend.volume, "tweets")}"
                  : "",
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        Row(
          children: [
            _showIconArrowIfPossible(),
          ],
        ),
      ],
    );
  }

  _showIconArrowIfPossible() {
    if (twitterTrend.sentimentMap.isEmpty) {
      return const SizedBox(width: 20);
    } else {
      int total = twitterTrend.sentimentMap.values.reduce((a, b) => a + b);

      List<String> chips = twitterTrend.sentimentMap.entries.map((entry) {
        double percentage = (entry.value / total) * 100;
        return '${entry.key} ${percentage.toStringAsFixed(0)}';
      }).toList();

      return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ChipRowWidget(chipText: chips),
        ),
      );
    }
  }

  getFormattedTraffic(int volume, String trafficType) {
    if (volume > 50000) {
      return "${_compactNf.format(volume)} $trafficType ${emojiFire.code}";
    } else if (volume >= 20000) {
      return "${_compactNf.format(volume)} $trafficType ${emojiChart.code}";
    } else {
      return "${_compactNf.format(volume)} $trafficType";
    }
  }
}

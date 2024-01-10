enum TrendKey { google, twitter, youtube }

extension TrendKeyExtension on TrendKey {
  String get value {
    switch (this) {
      case TrendKey.google:
        return "google";
      case TrendKey.twitter:
        return "twitter";
      case TrendKey.youtube:
        return "youtube";
      default:
        return "";
    }
  }
}

class GoogleTrend {
  final String title;
  final String snippet;
  final String linkUrl;
  final int volume;
  final String thumbnailUrl;
  final String source;

  GoogleTrend(this.title, this.snippet, this.linkUrl, this.volume, this.thumbnailUrl, this.source);

  GoogleTrend.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        snippet = json["snippet"],
        linkUrl = json["linkUrl"],
        volume = json["volume"],
        thumbnailUrl = json["thumbnailUrl"],
        source = json["source"];
}

class TwitterTrend {
  final int trendId;
  final String name;
  final String url;
  final int volume;
  final Map<String, int> sentimentMap;

  TwitterTrend(this.trendId, this.name, this.url, this.volume, this.sentimentMap);

  TwitterTrend.fromJson(Map<String, dynamic> json)
      : trendId = json["trend_id"],
        name = json["name"],
        url = json["url"],
        volume = json["volume"],
        sentimentMap =  Map<String, int>.from(json["sentimentMap"].map((key, value) => MapEntry(key, value as int)));
}

class YoutubeTrend {
  final int trendId;
  final String videoId;
  final String publishedAt;
  final String channelId;
  final String channelTitle;
  final String tags;
  final String title;
  final String description;
  final String thumbnailUrl;
  final int viewCount;
  final int likeCount;
  final int dislikeCount;
  final int commentCount;

  YoutubeTrend(
      this.trendId,
      this.videoId,
      this.publishedAt,
      this.channelId,
      this.channelTitle,
      this.tags,
      this.title,
      this.description,
      this.thumbnailUrl,
      this.viewCount,
      this.likeCount,
      this.dislikeCount,
      this.commentCount);

  YoutubeTrend.fromJson(Map<String, dynamic> json)
      : trendId = json["trend_id"],
        videoId = json["video_id"],
        publishedAt = json["published_at"],
        channelId = json["channel_id"],
        channelTitle = json["channel_title"],
        tags = json["tags"],
        title = json["title"],
        description = json["description"],
        thumbnailUrl = json["thumbnail_url"],
        viewCount = json["view_count"],
        likeCount = json["like_count"],
        dislikeCount = json["dislike_count"],
        commentCount = json["comment_count"];
}

class Trends {
  final TrendStore<GoogleTrend> googleTrend;
  final TrendStore<TwitterTrend> twitterTrend;
  final TrendStore<YoutubeTrend> youtubeTrend;

  Trends(this.googleTrend, this.twitterTrend, this.youtubeTrend);

  get size => 3;

  TrendStore getStoreByIndex(int index) {
    switch (index) {
      case 0:
        return googleTrend;
      case 1:
        return twitterTrend;
      case 2:
        return youtubeTrend;
      default:
        throw Exception("Unsupported index: $index");
    }
  }
}

class TrendStore<T> {
  final TrendKey key;
  final List<T>? trends;

  TrendStore(this.key, this.trends);

  String getTrendCardTitle() {
    if (key == TrendKey.google) {
      return "Keyword trends";
    } else if (key == TrendKey.twitter) {
      return "Twitter trends";
    } else if (key == TrendKey.youtube) {
      return "Youtube trends";
    } else {
      return "Trends";
    }
  }
}

import 'package:trendit/src/domain/api/api_service.dart';
import 'package:trendit/src/domain/model/trends_response.dart';


class TrenditRepository {

  Future<Trends> fetchTrends() async {
    return APIService.instance.fetchTrends();
  }
}

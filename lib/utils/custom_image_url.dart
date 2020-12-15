import 'package:padimall_app/utils/global.dart' as global;

String imageUrlFormatter(String imageUrl) {
  var completeUrl = global.API_URL_PREFIX + '/' + imageUrl;
  return completeUrl;
}
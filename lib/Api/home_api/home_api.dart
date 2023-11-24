import 'package:http/http.dart' as http;
import 'package:music_app/Api/home_api/home_page_model.dart';

class HomeApi {
  static String homeApi = 'https://saavn.me/modules?language=hindi,gujarati';
  static Future<HomePageModel> feachAllData() async {
    final response = await http.get(Uri.parse(homeApi));
    if (response.statusCode == 200) {
      return homePageModelFromJson(response.body);
    } else {
      throw Exception('Some Error');
    }
  }
}

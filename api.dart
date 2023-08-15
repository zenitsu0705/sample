
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // Import the http_parser package

String uploadUrl = "http://192.168.43.232:5000/api";
String downloadUrl = "http://192.168.43.232:5000/result";

// String uploadUrl = "http://192.168.43.232:5000/predict"; // Change to match your Flask route
// String downloadUrl = "http://192.168.43.232:5000/result"; // Change to match your Flask route


Future<Map<String, dynamic>> getData(String url) async {
  http.Response response = await http.get(Uri.parse(url)); // Use Uri.parse()
  return jsonDecode(response.body);
}

// Future<Map<String, dynamic>> getData(String url) async {
//   http.Response response = await http.get(Uri.parse(url));
//   Map<String, dynamic> responseData = json.decode(response.body);
//   return responseData;
// }


Future<void> uploadImage(File imageFile, String url) async {
  Uri uri = Uri.parse(url); // Use Uri.parse()
  List<int> imageBytes = imageFile.readAsBytesSync();
  int base64ImageLength = base64Encode(imageBytes).length;
  MediaType contentType = MediaType('application', 'octet-stream');

  var request = http.MultipartRequest('POST', uri);
  request.files.add(http.MultipartFile.fromBytes(
    'image',
    imageBytes,
    filename: imageFile.path,
    contentType: contentType,
  ));
  var response = await request.send();
  if (response.statusCode == 200) {
    // print('Image uploaded successfully!');
  } else {
    print('Image upload failed!');
  }
}



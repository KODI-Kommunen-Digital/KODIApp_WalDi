import 'dart:io';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PDFService {
  Future<File> downloadPDF(String pdfURL) async {
    final response = await http.get(Uri.parse(pdfURL));
    if (response.statusCode == 200) {
      final directory = await getApplicationDocumentsDirectory();
      final pdfPath = '${directory.path}/downloaded_pdf.pdf';
      final file = File(pdfPath);
      await file.writeAsBytes(response.bodyBytes);
      final prefs = await Preferences.openBox();
      prefs.setKeyValue(Preferences.pdfPath, file.path);
      return file;
    } else {
      throw Exception('Failed to download PDF');
    }
  }
}

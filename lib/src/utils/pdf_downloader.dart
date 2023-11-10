import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PDFService {
  Future<File> downloadPDF(String pdfURL, String? pdfName) async {
    String pdf = extractPdfName(pdfName);
    final response = await http.get(Uri.parse(pdfURL));
    if (response.statusCode == 200) {
      final directory = await getApplicationDocumentsDirectory();
      final pdfPath = '${directory.path}/$pdf';
      final file = File(pdfPath);
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } else {
      throw Exception('Failed to download PDF');
    }
  }

  static String extractPdfName(pdfPath){
    int pdfNameSplit = pdfPath!.lastIndexOf('/');
    String pdf = pdfPath.substring(pdfNameSplit + 1);
    return pdf;
  }

  Future<bool> doesFileExist(String? pdfName) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$pdfName');
    return file.exists();
  }
}

import 'package:heidi/src/data/repository/list_repository.dart';

class CitizenServiceModel {
  final String imageUrl;
  final String imageLink;
  final String type;
  final int? categoryId;
  final int? arguments;

  CitizenServiceModel(
      {required this.imageUrl,
      required this.imageLink,
      this.type = "categoryService",
      this.categoryId,
      this.arguments});

  Future<bool> hasContent() async {
    final result = await ListRepository.loadList(
      categoryId: categoryId,
      type: type,
      pageNo: 1,
    );
    return !result?[0].isEmpty;
  }
}

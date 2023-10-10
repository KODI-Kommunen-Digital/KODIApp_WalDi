import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_faq.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/presentation/main/account/faq/cubit/faq_state.dart';

class FaqCubit extends Cubit<FaqState> {
  FaqCubit() : super(const FaqState.loading());

  Future<List<FaqModel>> fetchFaqData() async {
    final apiResponse = await Api.moreInfo();
    if (apiResponse.success) {
      final List<dynamic> dataList = apiResponse.data;
      final List<FaqModel> faqData = dataList.map((item) {
        return FaqModel(
          id: item['id'],
          title: item['title'],
          link: item['link'],
          isPdf: item['isPdf'],
        );
      }).toList();
      emit(const FaqStateLoaded());
      return faqData;
    } else {
      return [];
    }
  }
}

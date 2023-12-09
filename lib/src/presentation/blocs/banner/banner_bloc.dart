import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repository/banner_repo.dart';
import '../../../data/model/banner_respone.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final BannerRepository bannerRepository;

  BannerBloc({required this.bannerRepository}) : super(BannerInitial()) {
    on<BannerEvent>((events, emit) async{
      if (events is GetBannerListEvent) {
        emit (BannerLoading());
        final data = await bannerRepository.getBannerList();
        emit (BannerSucces(bannerList : data));
      }
    });
  }
}

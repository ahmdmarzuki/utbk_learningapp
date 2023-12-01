import 'package:final_porject_edspert/src/data/repository/banner_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_porject_edspert/src/data/model/banner/banner_respone.dart';
import 'package:meta/meta.dart';

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

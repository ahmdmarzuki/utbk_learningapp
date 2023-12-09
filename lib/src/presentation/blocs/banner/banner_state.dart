part of 'banner_bloc.dart';

@immutable
sealed class BannerState {}

final class BannerInitial extends BannerState {}
final class BannerLoading extends BannerState {}
final class BannerSucces extends BannerState {
  final List<BannerData> bannerList;

  BannerSucces({required this.bannerList});
}
final class BannerFailed extends BannerState {
  final String errorMassage;

  BannerFailed({required this.errorMassage});
}

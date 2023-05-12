part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial({
    @Default(false) bool isLoading,
    @Default("") String errorMessage,
    @Default("") String currentPosition,
    @Default(0.0) double distance
}) = _Initial;
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rsud/hive/logs_checkin/log_check_in.dart';
import 'package:rsud/utils/location/locationUtils.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {

  HomeCubit() : super(const HomeState.initial()) {
    hiveInit();
  }

  void hiveInit() async {
    Hive.registerAdapter(LogCheckInAdapter());
    await Hive.openBox<LogCheckIn>(LogCheckIn.name);
  }

  void checkIn(BuildContext context) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    final position = await LocationUtil.getCurrentLocation(context);

    position.fold((error) => {
      emit(state.copyWith(isLoading: false, errorMessage: error))
    }, (position) => _onCheckIn(position)
    );
  }

  void _onCheckIn(Position position) async{
    final address = await LocationUtil.getAddressLocation(position);
    final distance = LocationUtil.getDistanceLocation(position, -7.6832048, 110.8499091);

    emit(state.copyWith(isLoading: false, currentPosition: address, distance: distance));

    final logCheckInBox = Hive.box<LogCheckIn>(LogCheckIn.name);
    var logCheckIn = LogCheckIn();

    logCheckIn.position = address;
    logCheckIn.distance = distance;
    logCheckIn.isCheckIn = distance <= 101.0;
    logCheckIn.checkInAt = DateFormat("dd MMMM yyyy HH:mm").format(DateTime.now());
    logCheckInBox.add(logCheckIn);
  }
}

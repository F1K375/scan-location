import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:rsud/bloc/home/home_cubit.dart';
import 'package:rsud/components/alertDialog/message_dialog.dart';
import 'package:rsud/components/loading/ViewParentWithLoading.dart';
import 'package:rsud/router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => HomeCubit(),
          child: BlocConsumer<HomeCubit, HomeState>(
            listenWhen: (prev, current) => prev != current,
            listener: (context, state) {
              if (!state.isLoading) {
                final isSuccess = state.distance <= 101.0;
                showDialog(
                    context: context,
                    builder: (_) => MessageDialog(
                          title: state.errorMessage.isEmpty && isSuccess
                              ? "Berhasil"
                              : "Gagal",
                          description: state.errorMessage.isNotEmpty
                              ? state.errorMessage
                              : isSuccess
                                  ? "Berhasil melakukan checkin"
                                  : "Gagal melakukan checkin, anda sedang berada di luar jangkauan",
                          action: () => {},
                          isSingleButton: true,
                        ));
              }
            },
            buildWhen: (prev, current) => prev.isLoading != current.isLoading,
            builder: (context, state) {
              return ViewParenWithLoading(
                isLoading: state.isLoading,
                child: const HomeBody(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (prev, current) =>
          (prev.currentPosition != current.currentPosition ||
              prev.distance != current.distance),
      builder: (builderContext, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "RSUD\nSukoharjo",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<HomeCubit>().checkIn(builderContext);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0))),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                          const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                        child: Text("Check in"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                      "Posisi anda saat ini :\n ${state.currentPosition.isNotEmpty ? state.currentPosition : "-"}",
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Text("Jarak dari RSUD : ${state.distance} m"),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "(Jarak minimal untuk check in 100m)",
                        style: TextStyle(
                            fontSize: 12, fontStyle: FontStyle.italic),
                      )
                    ],
                  )
                ],
              ),
              TextButton(
                  onPressed: () => Get.toNamed(AppRoute.history),
                  child: const Text("Riwayat")),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        );
      },
    );
  }
}

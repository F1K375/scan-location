import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rsud/hive/logs_checkin/log_check_in.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Check-in"),
      ),
      body: SingleChildScrollView(
        child: ValueListenableBuilder<Box<LogCheckIn>>(
            valueListenable: Hive.box<LogCheckIn>(LogCheckIn.name).listenable(),
            builder: (_, box, widget) {
              final logs = box.values.toList();
              final listRow = List.generate(
                  logs.length,
                  (index) => TableRow(children: [
                        _tableRow("${index + 1}."),
                        _tableRow(logs[index].checkInAt),
                        _tableRow(logs[index].position),
                        _tableRow("${logs[index].distance}m"),
                        _tableRow(logs[index].isCheckIn ? "Berhasil" : "Gagal")
                      ])).toList();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  border: TableBorder.symmetric(inside: const BorderSide(width: 1)),
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(3),
                    3: FlexColumnWidth(2),
                    4: FlexColumnWidth(2),
                  },
                  children: [
                    TableRow(children: [
                      _tableRow("No."),
                      _tableRow("Tanggal"),
                      _tableRow("Posisi"),
                      _tableRow("Jarak"),
                      _tableRow("Status"),
                    ]),
                    ...listRow
                  ],
                ),
              );
            }),
      ),
    );
  }

  Padding _tableRow(String text) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(child: Text(text)),
    );
  }
}

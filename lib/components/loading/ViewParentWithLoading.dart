import 'package:flutter/material.dart';
import 'package:rsud/components/loading/loading_screen_widget.dart';

class ViewParenWithLoading extends StatelessWidget {
  final Widget loading;
  final bool isLoading;
  final Widget child;

  const ViewParenWithLoading(
      {required this.isLoading,
      required this.child,
      this.loading = const LoadingScreenWidget(),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [child, isLoading ? loading : const SizedBox()],
    );
  }
}

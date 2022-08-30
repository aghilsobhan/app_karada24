import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class WidgetLoadingPage extends StatelessWidget {
  const WidgetLoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.waveDots(color: Palette.primaryColorD, size: 20,
      ),
    );
  }
}

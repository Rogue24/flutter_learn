import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:jp_flutter_demo/viewModel/counter_viewModel.dart';
import 'package:jp_flutter_demo/viewModel/moguBanner_viewModel.dart';
import 'package:jp_flutter_demo/viewModel/form_viewModel.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (ctx) => JPCounterViewModel()),
  ChangeNotifierProvider(create: (ctx) => JPMoguBannerViewModel.create(title: "zhoujianping")),
  ChangeNotifierProvider(create: (ctx) => JPFormViewModel()),
];
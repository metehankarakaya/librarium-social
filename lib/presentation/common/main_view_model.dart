import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

abstract class MainViewModel extends BaseViewModel {

  BuildContext context;

  MainViewModel(this.context);

  void start();

}

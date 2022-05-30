import 'package:flutter/services.dart';

void setPageTitle(String title) {
  SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(label: title));
}

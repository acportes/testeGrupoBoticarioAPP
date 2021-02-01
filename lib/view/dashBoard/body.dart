
import 'package:flutter/material.dart';
import 'package:microblogging_boticario/model/app_model.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppModel app = Provider.of<AppModel>(context);
    return app.page;
  }
}
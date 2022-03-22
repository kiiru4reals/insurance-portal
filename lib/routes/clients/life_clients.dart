import 'package:flutter/material.dart';
import 'package:insurance_portal/constants/color.dart';
import 'package:insurance_portal/providers/life_insurer_provider.dart';
import 'package:insurance_portal/widgets/no_clients.dart';
import 'package:insurance_portal/widgets/show_life_clients.dart';
import 'package:provider/provider.dart';

class LifeClients extends StatefulWidget {
  static const routeName = "/LifeClients";

  @override
  _LifeClientsState createState() => _LifeClientsState();
}

class _LifeClientsState extends State<LifeClients> {
  @override
  Widget build(BuildContext context) {
    final lcAttributes = Provider.of<LifeInsurersProvider>(context);
    lcAttributes.fetchLifeInsurer();
    return lcAttributes.getlifeinsurer.isEmpty
        ? Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorConsts.bgColor,
        title: Text("No Life insurance clients"),
      ),
      body: NoClients(),
    )
        : Scaffold(
      appBar: AppBar(
        title: Text(
            'Total Life insurance clients: (${lcAttributes.getlifeinsurer
                .length})'),
      ),
      body: ListView.builder(
          itemCount: lcAttributes.getlifeinsurer.length,
          itemBuilder: (BuildContext ctx, int index) {
            return ChangeNotifierProvider.value(
              value: lcAttributes.getlifeinsurer[index],
              child: ShowLifeClients(
                lifeId:
                lcAttributes.getlifeinsurer.toString()[index],
              ),
            );
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:insurance_portal/constants/color.dart';
import 'package:insurance_portal/providers/life_provider.dart';
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
    final lcAttributes = Provider.of<InsuredLivesProvider>(context);
    lcAttributes.fetchLifeInsured();
    return lcAttributes.getLives.isEmpty
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
            'Total Life insurance clients: (${lcAttributes.getLives
                .length})'),
      ),
      body: ListView.builder(
          itemCount: lcAttributes.getLives.length,
          itemBuilder: (BuildContext ctx, int index) {
            return ChangeNotifierProvider.value(
              value: lcAttributes.getLives[index],
              child: ShowLifeClients(
                lifeId:
                lcAttributes.getLives.toString()[index],
              ),
            );
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:insurance_portal/constants/color.dart';
import 'package:insurance_portal/providers/life_insurer_provider.dart';
import 'package:insurance_portal/widgets/no_underwriters.dart';
import 'package:insurance_portal/widgets/show_life_insurers.dart';
import 'package:provider/provider.dart';

class LifeUnderwriters extends StatefulWidget {
  static const routeName = "/LifeUnderwriters";

  @override
  _LifeUnderwritersState createState() => _LifeUnderwritersState();
}

class _LifeUnderwritersState extends State<LifeUnderwriters> {
  @override
  Widget build(BuildContext context) {
    final luAttributes = Provider.of<LifeInsurersProvider>(context);
    luAttributes.fetchLifeInsurer();
    return luAttributes.getlifeinsurer.isEmpty
        ? Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorConsts.bgColor,
        title: Text("No underwriters"),
      ),
      body: NoUnderWriters(),
    )
        : Scaffold(
      appBar: AppBar(
        title: Text(
            'Total life insurance packages: (${luAttributes.getlifeinsurer.length})'),
      ),
      body: ListView.builder(
          itemCount: luAttributes.getlifeinsurer.length,
          itemBuilder: (BuildContext ctx, int index) {
            return ChangeNotifierProvider.value(
              value: luAttributes.getlifeinsurer[index],
              child: ShowLifeInsurers(
                lifeinsurerId:
                luAttributes.getlifeinsurer.toString()[index],
              ),
            );
          }),
    );
  }
}
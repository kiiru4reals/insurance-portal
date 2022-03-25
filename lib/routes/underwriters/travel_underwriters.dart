import 'package:flutter/material.dart';
import 'package:insurance_portal/constants/color.dart';
import 'package:insurance_portal/providers/travel_insurer_provider.dart';
import 'package:insurance_portal/widgets/no_underwriters.dart';
import 'package:insurance_portal/widgets/show_travel_insurers.dart';
import 'package:provider/provider.dart';
class TravelUnderwriters extends StatefulWidget {
  static const routeName = "/TravelUnderwriters";

  @override
  _TravelUnderwritersState createState() => _TravelUnderwritersState();
}

class _TravelUnderwritersState extends State<TravelUnderwriters> {
  @override
  Widget build(BuildContext context) {
    final tiAttributes = Provider.of<TravelInsurersProvider>(context);
    tiAttributes.fetchTravelInsurer();
    return tiAttributes.gettravelinsurer.isEmpty
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
        centerTitle: true,
        title: Text(
            'Total travel insurance packages: (${tiAttributes.gettravelinsurer.length})'),
      ),
      body: ListView.builder(
          itemCount: tiAttributes.gettravelinsurer.length,
          itemBuilder: (BuildContext ctx, int index) {
            return ChangeNotifierProvider.value(
              value: tiAttributes.gettravelinsurer[index],
              child: ShowTravelInsurers(
                travelinsurerId:
                tiAttributes.gettravelinsurer.toString()[index],
              ),
            );
          }),
    );
  }
}

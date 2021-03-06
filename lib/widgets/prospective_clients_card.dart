import 'package:flutter/material.dart';
import 'package:insurance_portal/constants/color.dart';
import 'package:insurance_portal/models/MyFiles.dart';
import 'package:insurance_portal/responsive.dart';
import 'package:insurance_portal/routes/clients/life_clients.dart';
import 'package:insurance_portal/routes/clients/vehicle_clients.dart';
import 'package:insurance_portal/routes/vehicle_prospective.dart';

import 'file_info_card.dart';

class ProspectiveClients extends StatelessWidget {
  const ProspectiveClients({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Clients",
              style: Theme.of(context).textTheme.subtitle1,
            ),

          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      // itemCount: demoMyFiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Ink.image(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1604238390774-b07b152150b3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                ),
                // colorFilter: ColorFilters.greyscale,
                child: InkWell(
                  hoverColor: Colors.transparent,
                  onTap: () => Navigator.pushNamed(context, VehicleClients.routeName),
                ),
                height: 240,
                fit: BoxFit.cover,
              ),
              Text(
                'Vehicle insurance',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
        Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Ink.image(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1604448724898-c1e456c979f4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
                ),
                // colorFilter: ColorFilters.greyscale,
                child: InkWell(
                  hoverColor: Colors.transparent,
                  onTap: () => Navigator.pushNamed(context, VehicleProspective.routeName),
                ),
                height: 240,
                fit: BoxFit.cover,
              ),
              Text(
                'Travel Insurance',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
        Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Ink.image(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1530026405186-ed1f139313f8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                ),
                // colorFilter: ColorFilters.greyscale,
                child: InkWell(
                  hoverColor: Colors.transparent,
                  onTap: () => Navigator.pushNamed(context, LifeClients.routeName),
                ),
                height: 240,
                fit: BoxFit.cover,
              ),
              Text(
                'Life insurance',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ],
      // itemBuilder: (context, index) => FileInfoCard(info: demoMyFiles[index]),
    );
  }
}

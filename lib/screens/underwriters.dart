import 'package:flutter/material.dart';
import 'package:insurance_portal/constants/color.dart';
import 'package:insurance_portal/models/vehicle_prospective_models.dart';
import 'package:insurance_portal/responsive.dart';
import 'package:insurance_portal/routes/flip_vehicle_client.dart';
import 'package:insurance_portal/side_menu.dart';
import 'package:insurance_portal/widgets/scrollable_widget.dart';

class UnderWriters extends StatefulWidget {
  // static const routeName = "/VehicleProspective";

  @override
  _UnderWritersState createState() => _UnderWritersState();
}

class _UnderWritersState extends State<UnderWriters> {
  late List<Clients> users;
  int? sortColumnIndex;
  bool isAscending = false;

  @override
  void initState() {
    super.initState();

    this.users = List.of(allUsers);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: ColorConsts.bgColor,
      title: Text("Underwriters"),
      actions: [
        ElevatedButton.icon(
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.symmetric(
              horizontal: defaultPadding * 1.5,
              vertical: defaultPadding /
                  (Responsive.isMobile(context) ? 2 : 1),
            ),
          ),
          onPressed: () => Navigator.of(context).pushNamed(FlipVehicleClient.routeName),
          icon: Icon(Icons.person_add),
          label: Text("Add New Underwriter"),
        ),
      ],
    ),
    drawer: SideMenu(),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ScrollableWidget(child: buildDataTable()),
    ),
  );

  Widget buildDataTable() {
    final columns = ['First Name', 'Last Name', 'Age'];
    return Container(
      width: MediaQuery.of(context).size.width *.96,
      child: DataTable(
        sortAscending: isAscending,
        sortColumnIndex: sortColumnIndex,
        columns: getColumns(columns),
        rows: getRows(users),
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
    label: Text(column),
    onSort: onSort,
  ))
      .toList();

  List<DataRow> getRows(List<Clients> users) => users.map((Clients user) {
    final cells = [user.firstName, user.lastName, user.age];

    return DataRow(cells: getCells(cells));
  }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      users.sort((user1, user2) =>
          compareString(ascending, user1.firstName, user2.firstName));
    } else if (columnIndex == 1) {
      users.sort((user1, user2) =>
          compareString(ascending, user1.lastName, user2.lastName));
    } else if (columnIndex == 2) {
      users.sort((user1, user2) =>
          compareString(ascending, '${user1.age}', '${user2.age}'));
    }

    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}

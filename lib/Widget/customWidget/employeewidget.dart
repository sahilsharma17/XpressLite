import 'package:flutter/material.dart';

import '../../helper/dxWidget/dx_text.dart';

class EmployeeDetails extends StatelessWidget {
  String employeeName;
  String employeeDesignation;
  AssetImage employeeImage;
   EmployeeDetails({required this.employeeName, required this.employeeDesignation, required this.employeeImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      Padding(
        padding: const EdgeInsets.all(3.0),
        child: Card(
          elevation: 2,
          child: ListTile(
            leading: CircleAvatar(
                radius: 25,
                backgroundImage: employeeImage
            ),
            title: DxTextBlack(
              employeeName,
              mSize: 18,
              mBold: true,
            ),

            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DxText(employeeDesignation,),
                SizedBox(height: 3,),
                DxText("898999888"),
              ],
            ),
            trailing:Icon(Icons.call, color: Colors.green,)
          ),
        ),
      ),

    );

  }
}

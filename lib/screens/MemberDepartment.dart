import 'package:flutter/material.dart';
import 'package:dcapp/globals.dart' as global;

class DeptDirect extends StatefulWidget {
  @override
  _DeptDirectState createState() => _DeptDirectState();
}

class _DeptDirectState extends State<DeptDirect> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: 
       DataTable(
         
         columns: <DataColumn>[
           DataColumn(
             label: Text('Department'),
             numeric: false,
             ),
              DataColumn(
             label: Text('Head'),
             numeric: false,
             ),
             DataColumn(
             label: Text('Contact'),
             numeric: false,
             ),
         ], 
         
         rows: global.deptTable.map((dept)=>
         DataRow(
           cells: [
             DataCell(Text(dept.department)),
               DataCell(Text(dept.departmentHead)),
                 DataCell(Text(dept.departmentHeadContact))
           ])
         ).toList()
         
         )

     
    );
  }

  

 
}
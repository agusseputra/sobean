import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sobean/Service/api.dart';
import 'package:sobean/UI/widget/gridproduct.dart';

class ProdukTerkini extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiService.getPanen(1,''),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData ? gridProduct(snapshot.data,context): Center(child: CircularProgressIndicator());
        },
      );
  }
}
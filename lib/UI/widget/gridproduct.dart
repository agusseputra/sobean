import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget gridProduct(data, BuildContext context) {
    return Container  (
    width : MediaQuery.of(context).size.width,
    height : MediaQuery.of(context).size.height,
      child : GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        scrollDirection : Axis.vertical,
        itemCount: data?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            splashColor: Colors.indigo,
            borderRadius: BorderRadius.circular(10.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // ClipRRect(
                  //   borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  //   child: Image.network(
                  //     data[index].foto,
                  //     height: 40.0,
                  //     width: double.infinity,
                  //     fit: BoxFit.cover,
                  //     // width: double.infinity,
                  //   ),
                  // ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            data[index].namaGrade.toString(),
                            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.line_weight_rounded,size: 10,),
                              Text(data[index].jumlahPerkiraanPanen+" "+data[index].satuan, style: TextStyle(fontSize: 10),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.location_history, size: 10),
                              Text(data[index].namaDesa, style: TextStyle(fontSize: 10),),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        //     onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => Updateuser(
        //           user: listUser[index]
        //             )));
        //     },
          );
        },
      ),
  );
  
  }
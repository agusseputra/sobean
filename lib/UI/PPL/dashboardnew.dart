import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sobean/Model/gradeKomoditas.dart';
import 'package:sobean/Model/panen.dart';
import 'package:sobean/Service/api.dart';
import 'package:sobean/UI/widget/bottombar.dart';
class DashboardThreePage extends StatefulWidget {
  static var routeName="dashboard";
  @override
  _DashboardThreePageState createState() => _DashboardThreePageState();
}

class _DashboardThreePageState extends State<DashboardThreePage> {  
  final TextStyle whiteText = TextStyle(color: Colors.white);
  late String name='';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextStyle dropdownMenuItem = TextStyle(color: Colors.black, fontSize: 18);
  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);
  static const _pageSize = 6;
  final PagingController<int, Panen> _pagingController = PagingController(firstPageKey: 0);
  late TextEditingController   _s;
  late String _publish="N";
  late int idKomoditas=0;
  var f = NumberFormat("###.0#", "en_US");
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString("name")!;
    });
  }
  @override
  void initState() {
    _s=TextEditingController();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, _s.text,idKomoditas);
    });    
    super.initState();
    getPref();
  }
  Future<void> _fetchPage(int pageKey, _s,idKomoditas) async {
    try {
      final newItems = await ApiService.getPanen(pageKey, _s,idKomoditas);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(context),
      bottomNavigationBar: buildBottomBar(0,1,2, context)
    );
  }

  Widget _buildBody(BuildContext context) {
    var mainmenu=FutureBuilder<List<GradeKomoditas>>(
          future: ApiService.getGradeKomoditas(),
          builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  List<GradeKomoditas> listKomoditas = snapshot.data!;
                    return Container(
                      width : MediaQuery.of(context).size.width,
                      height: 40,
                      child :ListView.builder(
                      shrinkWrap : true,
                      scrollDirection : Axis.horizontal,
                      itemCount : listKomoditas.length,
                      itemBuilder : (BuildContext context, int index) => Column(
                        children : <Widget> [
                          InkWell(
                              onTap: (){
                                setState(() { 
                                    idKomoditas = listKomoditas[index].idGradeKomoditas; 
                                    _pagingController.refresh();
                                  }); 
                              },
                              child: Container(padding: EdgeInsets.all(8.0),
                              child : Text(
                                listKomoditas[index].namaGrade,
                                textAlign : TextAlign.center,
                                style : TextStyle(
                                    color:  idKomoditas==listKomoditas[index].idGradeKomoditas?Colors.green:Colors.black,
                                    fontSize : 14
                                ),
                            ),),
                          )
                      ],)
                  ));
                }
                },

        );
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(0, 50.0, 0, 32.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
              color: Colors.green,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Text(
                    "Dashboard",
                    style: whiteText.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  leading: IconButton(
                      icon: Icon(Icons.menu, color: Colors.white,),
                      onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                    ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: Text('Hai, '+name, textAlign: TextAlign.center,style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                  )),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40.0)
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Temukan Produk Unggulan",
                      border: InputBorder.none,
                      icon: IconButton(onPressed: (){
                        
                      }, icon: Icon(Icons.search)),
                    ),
                    controller: _s,
                    onSubmitted: (_s){
                        _pagingController.refresh();
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Kelompok Tani",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ),
          Card(
            elevation: 4.0,
            color: Colors.white,
            margin: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    leading: Container(
                      alignment: Alignment.bottomCenter,
                      width: 45.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            height: 20,
                            width: 8.0,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(width: 4.0),
                          Container(
                            height: 25,
                            width: 8.0,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(width: 4.0),
                          Container(
                            height: 40,
                            width: 8.0,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 4.0),
                          Container(
                            height: 30,
                            width: 8.0,
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ),
                    ),
                    title: Text("Bulan ini"),
                    subtitle: Text("120 Produk"),
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  child: ListTile(
                    leading: Container(
                      alignment: Alignment.bottomCenter,
                      width: 45.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            height: 20,
                            width: 8.0,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(width: 4.0),
                          Container(
                            height: 25,
                            width: 8.0,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(width: 4.0),
                          Container(
                            height: 40,
                            width: 8.0,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 4.0),
                          Container(
                            height: 30,
                            width: 8.0,
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ),
                    ),
                    title: Text("Petani"),
                    subtitle: Text("7 baru"),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Row(
          //     children: <Widget>[
          //       Expanded(
          //         child: _buildTile(
          //           color: Colors.blue,
          //           icon: Icons.favorite,
          //           title: "Discharged",
          //           data: "864",
          //         ),
          //       ),
          //       const SizedBox(width: 16.0),
          //       Expanded(
          //         child: _buildTile(
          //           color: Colors.pink,
          //           icon: Icons.portrait,
          //           title: "Dropped",
          //           data: "857",
          //         ),
          //       ),
          //       const SizedBox(width: 16.0),
          //       Expanded(
          //         child: _buildTile(
          //           color: Colors.blue,
          //           icon: Icons.favorite,
          //           title: "Arrived",
          //           data: "698",
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Perkiraan Panen Terkini",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: mainmenu),
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: RefreshIndicator(
              onRefresh: ()=>Future.sync(
                ()=>_pagingController.refresh()
              ),
              child: PagedGridView<int, Panen>(
              pagingController: _pagingController,
              showNewPageProgressIndicatorAsGridChild: false,
              showNewPageErrorIndicatorAsGridChild: false,
              showNoMoreItemsIndicatorAsGridChild: false,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 100 / 150,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
              ),
              builderDelegate: PagedChildBuilderDelegate<Panen>(
                itemBuilder: (context, item, index) => Container(
                  child: InkWell(
            splashColor: Colors.indigo,
            borderRadius: BorderRadius.circular(10.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.network(
                      item.foto,
                      height: 40.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      // width: double.infinity,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            item.namaGrade.toString(),
                            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.line_weight_rounded,size: 10,),
                              Text(item.jumlahPerkiraanPanen+" "+item.satuan, style: TextStyle(fontSize: 10),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.location_history, size: 10),
                              Text(item.namaDesa, style: TextStyle(fontSize: 10),),
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
          )
                    
                  
                ),
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }


  // Container _buildTile(
  //     {Color? color, IconData? icon, required String title, required String data}) {
  //   return Container(
  //     padding: const EdgeInsets.all(8.0),
  //     height: 150.0,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(4.0),
  //       color: color,
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: <Widget>[
  //         Icon(
  //           icon,
  //           color: Colors.white,
  //         ),
  //         Text(
  //           title,
  //           style: whiteText.copyWith(fontWeight: FontWeight.bold),
  //         ),
  //         Text(
  //           data,
  //           style:
  //               whiteText.copyWith(fontWeight: FontWeight.bold, fontSize: 20.0),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:sobean/Model/panen.dart';
import 'package:sobean/Service/api.dart';
import 'package:sobean/UI/PPL/InputPanen.dart';
import 'package:sobean/UI/widget/bottombar.dart';
import 'package:sobean/UI/widget/drawer.dart';

class PanenPage extends StatefulWidget {
  static var routeName="panenppl";
  @override
  _PanenPageState createState() => _PanenPageState();
}

class _PanenPageState extends State<PanenPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextStyle dropdownMenuItem = TextStyle(color: Colors.black, fontSize: 18);
  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);
  static const _pageSize = 6;
  final PagingController<int, PanenList> _pagingController = PagingController(firstPageKey: 0);
  late TextEditingController   _s;
  late String _publish="N";
  var f = NumberFormat("###.0#", "en_US");
   @override
  void initState() {
    _s=TextEditingController();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, _s.text,_publish);
    });    
    super.initState();
  }
  Future<void> _fetchPage(int pageKey, _s,_publish) async {
    try {
      final newItems = await ApiService.getPanenPPL(pageKey, _s,_publish);
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
   // The app's "state".
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfff0f0f0),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => InputPanen(id: 0,)));
        },
      ),
      bottomNavigationBar: buildBottomBar(1,1,2, context),
      drawer: drawerBar(context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 80),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 100),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: RefreshIndicator(
                  onRefresh: ()=>Future.sync(
                    ()=>_pagingController.refresh()
                  ),
                  child: PagedListView<int, PanenList>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<PanenList>(
                    itemBuilder: (context, item, index) => Container(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => InputPanen(id: item.idKomoditasDijual,)));
                        },
                        child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          border: Border.all(width: 1, color: item.publish=='Y'?Colors.white:Colors.orange)
                        ),
                        width: double.infinity,
                        height: 110,
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Column(
                            children:[ Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    margin: EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(width: 3, color: secondary),
                                      image: DecorationImage(
                                          image: NetworkImage(item.foto),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  Text( f.format(double.parse(item.jumlahPerkiraanPanen))+' '+item.satuan, style: TextStyle(fontSize: 12),textAlign: TextAlign.left)
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      item.namaGrade,
                                      style: TextStyle(
                                          color: primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.supervised_user_circle,
                                          color: secondary,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(item.nama,
                                            style: TextStyle(
                                                color: primary, fontSize: 12, letterSpacing: .3),textAlign: TextAlign.left),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.location_on,
                                          color: secondary,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(item.namaKelompok+', '+item.namaDesa,
                                            style: TextStyle(
                                                color: primary, fontSize: 12, letterSpacing: .3),textAlign: TextAlign.left),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Divider(
                            height: 7,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.date_range_rounded,
                                color: secondary,
                                size: 15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Perkiraan Panen "+item.tglPerkiraanPanen,
                                  style: TextStyle(
                                      color: secondary, fontSize: 10, letterSpacing: .3, fontStyle: FontStyle.italic)),
                            ],
                          ),
                        ]
                        ),
                    ),
                      )
                        
                      
                    ),
                  ),
                ),
              ),
              ),
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                        icon: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Hasil Panen Petani",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      PopupMenuButton(
                        icon: Icon(
                          Icons.filter_list,
                          color: Colors.white,
                        ),
                        initialValue: _publish,
                        onSelected: (String result) { 
                            setState(() { 
                              _publish = result; 
                              _pagingController.refresh();
                            }); 
                          },
                        itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                          new PopupMenuItem<String>(child: const Text('Publish'),value: 'Y'),
                          new PopupMenuItem<String>(child: const Text('Draft'),value: 'N'),
                          new PopupMenuItem<String>(child: const Text('Semua'),value: 'All'),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 70,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: TextField(
                          controller: _s,
                          onSubmitted: (_s){
                              _pagingController.refresh();
                          },
                          cursorColor: Theme.of(context).primaryColor,
                          style: dropdownMenuItem,
                          decoration: InputDecoration(
                              hintText: "Pencarian Produk",
                              hintStyle: TextStyle(
                                  color: Colors.black38, fontSize: 16),
                              prefixIcon: Material(
                                elevation: 0.0,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                child: Icon(Icons.search),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 13)),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
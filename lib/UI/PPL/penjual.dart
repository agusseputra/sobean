import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sobean/Model/penjual.dart';
import 'package:sobean/Service/api.dart';
import 'package:sobean/UI/PPL/inputPenjual.dart';
import 'package:sobean/UI/PPL/updatePenjual.dart';
import 'package:sobean/UI/widget/bottombar.dart';
import 'package:sobean/UI/widget/drawer.dart';

class PenjualPage extends StatefulWidget {
  static var routeName="penjualppl";
  @override
  _PenjualPageState createState() => _PenjualPageState();
}

class _PenjualPageState extends State<PenjualPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static const _pageSize = 6;
  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);
  late TextEditingController   _s;
  final PagingController<int, Penjual> _pagingController = PagingController(firstPageKey: 0);
  final TextStyle dropdownMenuItem = TextStyle(color: Colors.black, fontSize: 18);
  late String _publish="Y";
  @override
  void initState() {
    _s=TextEditingController();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, _s.text,_publish);
    });
    super.initState();
  }
  Future<void> _fetchPage(int pageKey,_s,_publish) async {
    try {
      final newItems = await ApiService.getPenjual(pageKey,_s,_publish);
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfff0f0f0),
      drawer: drawerBar(context),
      bottomNavigationBar: buildBottomBar(2,1,2, context),
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
                  child: PagedListView<int, Penjual>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Penjual>(
                    itemBuilder: (context, item, index) => Container(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePenjual(penjual: item,)));
                        },
                        child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          border: Border.all(width: 1, color: item.status=='Y'?Colors.white:Colors.orange)
                        ),
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Column(
                            children:[ Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[ 
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
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        item.nama,
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
                                            Icons.assignment_ind,
                                            color: secondary,
                                            size: 15,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(item.nik,
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
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.6,
                                            child: Text(item.namaKelompok,
                                                style: TextStyle(color: primary, fontSize: 12, letterSpacing: .3),textAlign: TextAlign.left, softWrap: true,),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              
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
                        "Petani",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
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
                        "Data Petani",
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
                          new PopupMenuItem<String>(child: const Text('Aktif'),value: 'Y'),
                          new PopupMenuItem<String>(child: const Text('Non Aktif'),value: 'N'),
                          new PopupMenuItem<String>(child: const Text('Semua'),value: 'All'),
                          new PopupMenuItem<String>(child: const Text('Deleted'),value: 'del'),
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
                              hintText: "Masukkan Nama Petani",
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context) => InputPenjual()));
        },
      ),
    );
  }
}
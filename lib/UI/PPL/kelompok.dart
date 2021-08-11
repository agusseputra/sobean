import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sobean/Model/kelompok.dart';
import 'package:sobean/Service/api.dart';
import 'package:sobean/UI/PPL/inputKelompok.dart';
import 'package:sobean/UI/widget/bottombar.dart';
import 'package:sobean/UI/widget/drawer.dart';

class KelompokPage extends StatefulWidget {
  static var routeName="kelompokppl";
  @override
  _KelompokPage createState() => _KelompokPage();
}

class _KelompokPage extends State<KelompokPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextStyle dropdownMenuItem = TextStyle(color: Colors.black, fontSize: 18);
  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);
  static const _pageSize =6;
  final PagingController<int, Kelompok> _pagingController = PagingController(firstPageKey: 0);
  late TextEditingController   _s;
  late String _publish="N";
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
      final newItems = await ApiService.getKelompokPPL(pageKey, _s,_publish);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
        print(pageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => InputKelompok(kelompok: Kelompok(
            idKelompokTani:0,
            idDesa:0,
            namaKelompok:'',
            status:'N',
            noKartu:'',
            idKecamatan:'',
            kodeDesa:'',
            namaDesa:'',
            jmlAnggota:''
          ),            
          )));
        },
      ),
      bottomNavigationBar: buildBottomBar(3,1,3, context),
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
                  child: PagedListView<int, Kelompok>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Kelompok>(
                    itemBuilder: (context, item, index) => Container(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => InputKelompok(kelompok: item)));
                        },
                        child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          border: Border.all(width: 1, color: item.status=='Y'?Colors.white:Colors.orange)
                        ),
                        width: double.infinity,
                        height: 90,
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Column(
                            children:[ Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      item.namaKelompok,
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
                                          Icons.location_on,
                                          color: secondary,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(item.namaDesa,
                                            style: TextStyle(
                                                color: primary, fontSize: 12, letterSpacing: .3),textAlign: TextAlign.left),
                                      ],
                                    ),
                                  ],
                                )
                            ],
                          ),
                          Divider(
                            height: 7,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.group,
                                color: secondary,
                                size: 15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(item.jmlAnggota+" Anggota Aktif ",
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
                        "Kelompok Tani",
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
                              hintText: "Masukkan Nama Kelompk",
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
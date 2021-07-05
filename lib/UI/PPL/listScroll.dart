import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sobean/Model/panen.dart';
import 'package:sobean/Service/api.dart';
import 'package:sobean/UI/PPL/InputPanen.dart';
class SchoolList extends StatefulWidget {
  _SchoolListState createState() => _SchoolListState();
}

class _SchoolListState extends State<SchoolList> {
  final TextStyle dropdownMenuItem = TextStyle(color: Colors.black, fontSize: 18);
  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);
  static const _pageSize = 6;
  final PagingController<int, Panen> _pagingController = PagingController(firstPageKey: 0);
   @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }
  Future<void> _fetchPage(int pageKey) async {
    print("page :");
    print(pageKey);
    try {
      final newItems = await ApiService.getPanen(pageKey,'');
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
      backgroundColor: Color(0xfff0f0f0),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => InputPanen()));
        },
      ),
      body: SingleChildScrollView(
        child: Container(
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
                  child: PagedListView<int, Panen>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Panen>(
                    itemBuilder: (context, item, index) => Container(
                      child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      width: double.infinity,
                      height: 90,
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Row(
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
                              Text(item.jumlahPerkiraanPanen+' '+item.satuan, style: TextStyle(fontSize: 12),textAlign: TextAlign.left)
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
                                      Icons.date_range_rounded,
                                      color: secondary,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(item.tglPerkiraanPanen,
                                        style: TextStyle(
                                            color: primary, fontSize: 12, letterSpacing: .3)),
                                  ],
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
                                    Text(item.nama+', '+item.namaKelompok,
                                        style: TextStyle(
                                            color: primary, fontSize: 12, letterSpacing: .3),textAlign: TextAlign.left),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
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
                        onPressed: () {},
                        icon: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Produk Pertanian",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.filter_list,
                          color: Colors.white,
                        ),
                      ),
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
                          // controller: TextEditingController(text: locations[0]),
                          cursorColor: Theme.of(context).primaryColor,
                          style: dropdownMenuItem,
                          decoration: InputDecoration(
                              hintText: "Search School",
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
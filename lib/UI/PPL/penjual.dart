import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sobean/Model/penjual.dart';
import 'package:sobean/Service/api.dart';
import 'package:sobean/UI/widget/appbar.dart';

class PenjualPage extends StatefulWidget {
  @override
  _PenjualPageState createState() => _PenjualPageState();
}

class _PenjualPageState extends State<PenjualPage> {
  static const _pageSize = 6;
  final PagingController<int, Penjual> _pagingController = PagingController(firstPageKey: 0);
   @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }
  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await ApiService.getPenjual(pageKey);
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: appBar(context, "Penjual PPL"),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new ListTile(
              title: new Text("Akun"),
              trailing: new Icon(Icons.supervised_user_circle),
            )
          ],
        ),
      ),
        body: Container(
        child: RefreshIndicator(
            onRefresh: ()=>Future.sync(
              ()=>_pagingController.refresh()
            ),
            child: PagedListView<int, Penjual>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Penjual>(
              itemBuilder: (context, item, index) => Container(
                child: Card(
                  child: ListTile(
                      title: Text(item.nama),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_history, size: 12),
                              Text(item.namaKelompok + ', '+ item.namaDesa, style: TextStyle(fontSize: 12),)
                            ],
                          ),
                        ],
                      ),
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(item.foto)),
                      //trailing: Icon(Icons.event_available)
                      )
                      )
                   
                
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: (){

        },
      ),
    );
  }
}
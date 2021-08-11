import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sobean/Model/panen.dart';
import 'package:sobean/Service/api.dart';
import 'package:sobean/UI/widget/slider/image_slider.dart';

class DashboardPage extends StatefulWidget {
  static var routeName="dashboardpage";
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var images = [
        {
            "image": "assets/images/slider_1.png"
        }, {
            "image": "assets/images/slider_2.png"
        }, {
            "image": "assets/images/slider_3.png"
        }, {
            "image": "assets/images/slider_4.png"
        }, {
            "image": "assets/images/slider_5.png"
        }
    ];
    var menuItems = [
        {
            "image": "assets/images/category/kategori.jpg",
            "text": "Kategori"
        }, {
            "image": "assets/images/category/bpjs.jpg",
            "text": "BPJS"
        }, {
            "image": "assets/images/category/pascabayar.jpg",
            "text": "Pascabayar"
        }, {
            "image": "assets/images/category/emas.jpg",
            "text": "Emas"
        }, {
            "image": "assets/images/category/afiliasi.jpg",
            "text": "Afiliasi"
        }, {
            "image": "assets/images/category/official_store.jpg",
            "text": "Official Store"
        }, {
            "image": "assets/images/category/fashion_pria.jpg",
            "text": "Fashion Pria"
        }, {
            "image": "assets/images/category/tv_kabel.jpg",
            "text": "TV Kabel"
        }, {
            "image": "assets/images/category/ajukan_kartu_kredit.jpg",
            "text": "Ajukan Kartu Kredit"
        }, {
            "image": "assets/images/category/lainnya.jpg",
            "text": "Lainnya"
        }
    ];
  static const _pageSize = 4;
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
      final newItems = await ApiService.getPanen(pageKey,'',0);
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
    var mainmenu = Container(
            width : MediaQuery.of(context).size.width,
            height : 80.0,
            child : ListView.builder(
                shrinkWrap : true,
                scrollDirection : Axis.horizontal,
                itemCount : menuItems.length,
                itemBuilder : (BuildContext context, int index) => Column(children : <Widget> [
                    Container(
                        height : 50,
                        width : 50,
                        margin : EdgeInsets.all(5.0),
                        decoration : BoxDecoration(
                            borderRadius : BorderRadius.all(Radius.circular(10.0)),
                            border : Border.all(color : Colors.grey)
                        ),
                        child : Center(child : Image.asset(menuItems[index]['image'].toString(),),),
                    ),
                    Expanded(child : Text(
                        menuItems[index]["text"].toString(),
                        textAlign : TextAlign.center,
                        style : TextStyle(
                            fontSize : 8.0
                        ),
                    ),)
                ],)
            ),
        );
    return Scaffold(
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ImageSlider(images : images,),
              mainmenu,
              Container(height : 5.0, color : Colors.grey[200],),
              Container(
                child: PagedListView<int, Panen>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Panen>(
                  itemBuilder: (context, item, index) => Container(
                    child: Card(
                      child: ListTile(
                          title: Text(item.namaGrade),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_history, size: 10),
                                  Text(item.nama, style: TextStyle(fontSize: 10),)
                                ],
                              ),
                              Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Icon(Icons.line_weight_outlined, size: 10),
                                      Text(item.jumlahPerkiraanPanen+" "+item.satuan, style: TextStyle(fontSize: 10),)
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Icon(Icons.date_range_outlined, size: 10),
                                      Text(item.tglPerkiraanPanen, style: TextStyle(fontSize: 10),)
                                    ],
                                  ),
                                )
                              ],
                            )
                            ],
                          ),
                          leading: CircleAvatar(
                              backgroundImage: NetworkImage(item.foto)),
                          //trailing: Icon(Icons.event_available)
                          )
                          )
                      
                    
                  ),
                ),
              )
              )
            ],
          ),
        ),
    );
  }
}
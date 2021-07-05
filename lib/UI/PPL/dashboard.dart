import 'package:flutter/material.dart';
import 'package:sobean/Model/gradeKomoditas.dart';
import 'package:sobean/Service/api.dart';
import 'package:sobean/UI/widget/gridproduct.dart';
class Dashboard extends StatefulWidget {
    @override _HomeState createState() => _HomeState();
}
class _HomeState extends State<Dashboard> {
  // static const _pageSize = 6;
  // final PagingController<int, Panen> _pagingController = PagingController(firstPageKey: 0);
    //  DateTime time = DateTime.now();
    // List<Komoditas> listKomoditas=[];
    // Future<List<Komoditas>>  getData() async{
    //   return await ApiService.getKomoditas();
    // }
    @override void initState() {
        super.initState();
    }

    var images = [
        {
            "image": "https://media-origin.kompas.tv/library/image/thumbnail/1598668696785/1598668696785.jpg"
        }, {
            "image": "https://i.pinimg.com/originals/e7/a8/37/e7a8378b102b9be3ee4a97a5e109bd6f.jpg"
        }, {
            "image": "https://assets.tokodistributor.com/tokdis-banner/fc8bd36adb6900dfd35f7880dc681cc1.png_banner"
        }, {
            "image": "https://www.kangsayur.net/wp-content/uploads/2020/07/banner-kang-sayur-3.png"
        }
    ];
   
    Widget build(BuildContext context) {
        var mainmenu=FutureBuilder<List<GradeKomoditas>>(
          future: ApiService.getGradeKomoditas(),
          builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  List<GradeKomoditas> listKomoditas = snapshot.data!;
                    return Container(
                      width : MediaQuery.of(context).size.width,
                      height: 30,
                      child :ListView.builder(
                      shrinkWrap : true,
                      scrollDirection : Axis.horizontal,
                      itemCount : listKomoditas.length,
                      itemBuilder : (BuildContext context, int index) => Column(
                        children : <Widget> [
                          InkWell(
                              onTap: (){},
                              child: Container(padding: EdgeInsets.all(8.0),
                              child : Text(
                                listKomoditas[index].namaGrade,
                                textAlign : TextAlign.center,
                                style : TextStyle(
                                    fontSize : 12
                                ),
                            ),),
                          )
                      ],)
                  ));
                }
                },

        );
      return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          Container(
            child: SliverAppBar(
              expandedHeight: 180.0,
              backgroundColor: Colors.green,
              leading: IconButton(
                icon: Icon(Icons.menu, color: Colors.white,),
                onPressed: (){},
              ),
              title: Text("Beranda"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite_border, color: Colors.white,),
                  onPressed: (){},
                ),
              ],
              floating: true,
              flexibleSpace: ListView(
                children: <Widget>[
                  SizedBox(height: 70.0,),
                  Text("Temukan Produk Unggulan", textAlign: TextAlign.center,style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                  )),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40.0)
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Jeruk Bali, Durian Bestala",
                        border: InputBorder.none,
                        icon: IconButton(onPressed: (){}, icon: Icon(Icons.search)),
                      ),
                    ),
                  ),
                ],
              ) ,
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 10.0,),),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
                child : Column(
                    crossAxisAlignment : CrossAxisAlignment.start,
                    children : <Widget> [
                        //ImageSlider(images : images,),
                        mainmenu,
                        Container(height : 5.0, color : Colors.grey[200],),
                        Container(
                            margin : EdgeInsets.only(left : 10, top : 10),
                            padding : EdgeInsets.only(left : 5),
                            decoration : BoxDecoration(border : Border(left : BorderSide(color : Colors.green, width : 3))),
                            child : Text("Panen Terkini", style : TextStyle(color : Colors.black),),
                        ),
                        Container(
                          child: FutureBuilder(
                          future: ApiService.getPanen(1,''),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) print(snapshot.error);
                            return snapshot.hasData ? gridProduct(snapshot.data,context): Center(child: CircularProgressIndicator());
                          },
                        ),
                        )
                    ],
                ),
            ),
          ),
        ],
      ),
    );
    }
}
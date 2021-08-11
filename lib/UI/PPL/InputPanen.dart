import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sobean/Model/errormsg.dart';
import 'package:sobean/Model/gradeKomoditas.dart';
import 'package:sobean/Model/panen.dart';
import 'package:sobean/Model/penjual.dart';
import 'package:sobean/Service/api.dart';

class InputPanen extends StatefulWidget {
  final int id;
  InputPanen({required this.id});
  @override
  _InputPanenState createState() => _InputPanenState();
}

class _InputPanenState extends State<InputPanen> {
  final _formKey=GlobalKey<FormState>();
  bool _validate=false;
  bool _isupdate=false;
  late ErrorMSG response;
  late bool _success=false;
  late TextEditingController   waktuTanam, tglPerkiraanPanen, jumlahPerkiraanPanen, satuan, tglPanen, jumlahRiilPanen, harga, tglHargaBerlaku;
  final format=DateFormat('yyyy-MM-dd');
  String dropdownSatuan = 'kg';
  late List<GradeKomoditas> _gradeKom=[];
  late List<Penjual> _penjual=[];
  late int idGradekomoditas=0;
  late int idAnggotaTani=0;
  late int _idKomoditasDijual=0;
  late String _status='N';
  late String _imagePath="";
  late String _imageURL="";
  final ImagePicker _picker = ImagePicker();
  void validasi() async{
    if(_formKey.currentState!.validate()){      
      _formKey.currentState!.save();
      var params =  {
          'id_komoditas_dijual':_idKomoditasDijual.toString(),
          'id_grade_komoditas':idGradekomoditas.toString(),
          'id_anggota_tani' : idAnggotaTani.toString(),
          'tgl_perkiraan_panen' :tglPerkiraanPanen.text.toString(),
          'waktu_tanam' :waktuTanam.text.toString(),
          'jumlah_perkiraan_panen':jumlahPerkiraanPanen.text.toString(),
          'satuan' :dropdownSatuan.toString(),
          'jumlah_riil_panen':jumlahRiilPanen.text.toString(),
          'tgl_panen':tglPanen.text.toString(),
          'publish':_status.toString(),
          'harga':harga.text.toString(),
          'tgl_harga_berlaku':tglHargaBerlaku.text.toString(),
        }; 
        //print(params);
      if(_isupdate){
        //print('update');
        //update
      }else{
        //simpan
        //print('simpan');
        // print(_panen);
        // _panen.idGradeKomoditas=idGradekomoditas;
        // _panen.idAnggotaTani=idAnggotaTani;
        // _panen.waktuTanam=waktuTanam.text;
        // _panen.tglPerkiraanPanen=tglPerkiraanPanen.text;
        // _panen.jumlahPerkiraanPanen=jumlahPerkiraanPanen.text;
        // _panen.satuan=satuan.text;
        // _panen.tglPanen=tglPanen.text;
        // _panen.jumlahRiilPanen=jumlahRiilPanen.text;
        // _panen.harga=harga.text;
        // _panen.tglHargaBerlaku=tglHargaBerlaku.text;
        // _panen.status=_status;
        
      }     
      response=await ApiService.savePanen(params,_idKomoditasDijual, _imagePath);
      _success=response.success;
      final snackBar = SnackBar(
            content: Text(response.message),
            );        
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      if (_success) {
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PanenPage()));
        Navigator.pushNamedAndRemoveUntil(context, "panenppl", (Route<dynamic> route) => false);
      } else {
      }
      
    }else {
      _validate = true;
    }
  }
  String? validator(String value) {
    if (value.isEmpty){
      return "jangan kosong";
    }else {
      return null;
    }
  }

  void getGrade() async {
  final respose = await ApiService.getGradeKomoditas();  
  setState(() {
        _gradeKom=respose.toList();
        });
  }
  void getPenjual() async {
  final respose = await ApiService.getPenjualList('');  
  print(respose);
  setState(() {
        _penjual=respose.toList();
        });
  }
  // void _handleRadioValueChange1(String value) {
  //   setState(() {
  //     _status = value;
  //   });
  // }
  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
    getGrade();
    getPenjual();
      waktuTanam = TextEditingController();
      tglPerkiraanPanen= TextEditingController();
      jumlahPerkiraanPanen= TextEditingController();
      satuan= TextEditingController();
      tglPanen= TextEditingController();
      jumlahRiilPanen= TextEditingController();
      harga= TextEditingController();
      tglHargaBerlaku= TextEditingController();
    if(widget.id != 0){      
       ApiService.detailPanen(widget.id).then((Panen result){
         _isupdate=true;
        _idKomoditasDijual=result.idKomoditasDijual.toInt();
        idAnggotaTani=result.idAnggotaTani.toInt();
        idGradekomoditas=result.idGradeKomoditas.toInt();
        waktuTanam = TextEditingController(text:result.waktuTanam);
        tglPerkiraanPanen= TextEditingController(text:result.tglPerkiraanPanen);
        jumlahPerkiraanPanen= TextEditingController(text:result.jumlahPerkiraanPanen);
        satuan= TextEditingController(text:result.satuan);
        tglPanen= TextEditingController(text:result.tglPanen);
        jumlahRiilPanen= TextEditingController(text:result.jumlahRiilPanen);
        harga= TextEditingController(text:result.harga);
        tglHargaBerlaku= TextEditingController(text:result.tglHargaBerlaku);
        _status=result.publish.toString();
        _imageURL=result.foto;
        setState(() {});
       });
    }
      
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: _isupdate ? Text('Ubah Data') : Text('Input Data'),
          ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            color: Colors.white,
            child: Form(
              //autovalidate: _validate,
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: DropdownButtonFormField(
                      hint: Text("Pilih Komoditas"),                      
                      value: idGradekomoditas==0?null:idGradekomoditas,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.category_rounded),
                        //hintText: 'Jeruk Bali',
                        //labelText: 'Jenis Komoditas *',
                      ),
                      items: _gradeKom.map((item) {
                        return DropdownMenuItem(
                          child: Text(item.namaGrade),
                          value: item.idGradeKomoditas.toInt(),
                        );
                      }).toList(),
                      onChanged: (value) {                      
                        setState(() {
                          idGradekomoditas=value as int;
                        });
                      },
                      validator: (u) => u == null ? "Wajib Diisi " : null,
                    ),
                  ),
                  Container(
                    //width: MediaQuery.of(context).size.width*0.6,
                    padding: const EdgeInsets.all(5),
                    child: DropdownButtonFormField(
                      hint: Text("Pilih Penjual"),
                      value: idAnggotaTani==0?null:idAnggotaTani,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.category_rounded),
                        //hintText: 'Petani',
                        //labelText: 'Nama Petani *',
                      ),
                      items: _penjual.map((item) {
                        return DropdownMenuItem(
                          child: Text(item.nama+', '+item.namaKelompok, textAlign: TextAlign.left, softWrap: true),
                          value: item.idAnggotaTani.toInt(),
                        );
                      }).toList(),
                      onChanged: (value) {                      
                        setState(() {
                          idAnggotaTani=value as int;
                        });
                      },
                      validator: (u) => u == null ? "Wajib Diisi " : null,
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.all(5),
                  //   child: DropdownSearch<Penjual>(
                  //   label: "Petani *",
                  //   showSearchBox: false,
                  //   isFilteredOnline: true,
                  //   autoValidateMode: AutovalidateMode.onUserInteraction,
                  //   validator: (u) => u == null ? "Wajib Diisi " : null,
                  //   dropdownSearchDecoration: InputDecoration(
                  //     contentPadding: EdgeInsets.all(0),
                  //       icon: Icon(Icons.supervised_user_circle_sharp),
                  //     ),
                  //   onFind: (String filter) =>ApiService.searchPenjual(filter),
                  //   dropdownBuilder: _customDropDownExample,
                  //   popupItemBuilder: (context, item, index)  {
                  //     if (item == null) {
                  //       return Container();
                  //     }
                  //     return Container(
                  //       child:  ListTile(
                  //               contentPadding: EdgeInsets.only(left: 10,right: 10),
                  //               title: Text(item.nama),
                  //               subtitle: Text(
                  //                 item.namaKelompok,
                  //               ),
                  //             ),
                  //     );
                  //   },
                  //   onChanged: (u) {                      
                  //       setState(() {
                  //         idAnggotaTani=u!.idAnggotaTani;
                  //       });
                  //     }
                  // ),
                  // ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        //widget DateTimeField terdapat pada package datetime_picker_formfield
                          DateTimeField(                      
                            controller: waktuTanam,
                            format: format,
                            onShowPicker: (context, currentValue){
                              return showDatePicker(
                                context: context,
                                firstDate: DateTime(2020),
                                initialDate: currentValue??DateTime.now(),
                                lastDate: DateTime(2045)
                              );
                            },
                            decoration: const InputDecoration(
                              icon: Icon(Icons.date_range_outlined),
                              hintText: '2021-12-31',
                              labelText: 'Waktu Tanam *',
                            ),
                            validator: (u) => u == null ? "Wajib Diisi " : null,
                          )
                      ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        //widget DateTimeField terdapat pada package datetime_picker_formfield
                          DateTimeField(                      
                            controller: tglPerkiraanPanen,
                            format: format,
                            onShowPicker: (context, currentValue){
                              return showDatePicker(
                                context: context,
                                firstDate: DateTime(2020),
                                initialDate: currentValue??DateTime.now(),
                                lastDate: DateTime(2045)
                              );
                            },
                            decoration: const InputDecoration(
                              icon: Icon(Icons.date_range_outlined),
                              hintText: '2021-12-31',
                              labelText: 'Tanggal Perkiraan Panen *',
                            ),
                            validator: (u) => u == null ? "Wajib Diisi " : null,
                          )
                      ],
                  ),
                ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: jumlahPerkiraanPanen,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.production_quantity_limits_outlined),
                              hintText: 'Jumlah Perkiraan Panen',
                              labelText: 'Jumlah Perkiraan Panen *',
                            ),
                            validator: (u) => u == null ? "Wajib Diisi " : null,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    hintText: 'Satuan',
                                    labelText: 'Satuan *',
                                  ),
                                  value: dropdownSatuan,
                                  style: const TextStyle(color: Colors.deepPurple),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownSatuan = newValue!;
                                    });
                                  },
                                  items: <String>['kg', 'buah', 'daun', 'batang']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  validator: (u) => u == null ? "Wajib Diisi " : null,
                                ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        //widget DateTimeField terdapat pada package datetime_picker_formfield
                          DateTimeField(                      
                            controller: tglPanen,
                            format: format,
                            onShowPicker: (context, currentValue){
                              return showDatePicker(
                                context: context,
                                firstDate: DateTime(2020),
                                initialDate: currentValue??DateTime.now(),
                                lastDate: DateTime(2045)
                              );
                            },
                            decoration: const InputDecoration(
                              icon: Icon(Icons.date_range_outlined),
                              hintText: '2021-12-31',
                              labelText: 'Tanggal Panen',
                            )
                          )
                      ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: jumlahRiilPanen,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.production_quantity_limits_sharp),
                        hintText: '10',
                        labelText: 'Jumlah Panen',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: harga,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.price_change_outlined),
                        hintText: '10000',
                        labelText: 'Harga Komoditas',
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        //widget DateTimeField terdapat pada package datetime_picker_formfield
                          DateTimeField(                      
                            controller: tglHargaBerlaku,
                            format: format,
                            onShowPicker: (context, currentValue){
                              return showDatePicker(
                                context: context,
                                firstDate: DateTime(2020),
                                initialDate: currentValue??DateTime.now(),
                                lastDate: DateTime(2045)
                              );
                            },
                            decoration: const InputDecoration(
                              icon: Icon(Icons.date_range_outlined),
                              hintText: '2021-12-31',
                              labelText: 'Tanggal Berlaku Harga',
                            ),
                          )
                      ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.filter_vintage_outlined),
                      Row(
                        children: <Widget>[
                          new Radio(
                            value: "Y",
                            groupValue: _status,
                            onChanged:(String? newValue) {
                                    setState(() {
                                      _status = newValue!.toString();
                                    });
                                  },
                          ),
                          new Text(
                            'Publish'
                          ),
                          new Radio(
                            value: "N",
                            groupValue: _status,
                            onChanged:(String? newValue) {
                                    setState(() {
                                      _status = newValue!.toString();
                                    });
                                  },
                          ),
                          new Text(
                            'Tidak'
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.image),
                      Flexible(
                      child: _imagePath != '' ? GestureDetector(
                            child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(File(_imagePath),
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 5,
                        ),
                      ),
                      onTap: () {
                          getImage(ImageSource.gallery);
                        }
                      ) : _imageURL != '' ? GestureDetector(
                            child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(_imageURL,
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 5,
                        ),
                      ),
                      onTap: () {
                          getImage(ImageSource.gallery);
                        }
                      ) : GestureDetector(
                        onTap: () {
                          getImage(ImageSource.gallery);
                        },
                        child: Container(
                          height: 100,
                          child: Row(
                            children: <Widget>[
                               Padding(
                                padding: EdgeInsets.only(left: 25),
                              ),
                              Text("Ambil Gambar")
                            ],
                          ),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.greenAccent, width: 1))
                          ),
                        ),
                      )
                          
                    )
                    ],
                  ),

                ),
                Divider(),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    child: RaisedButton(
                      color: Colors.green,
                      child: Text(
                        'SIMPAN',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: (){
                        validasi();
                        if(_success){
                          
                          //Navigator.pop(context,true);
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                ],
              ),
              ),
          ),
        ),  
    );
  }
  Future getImage(ImageSource media) async {
    var img = await _picker.pickImage(source: media);
    //final pickedImageFile = File(img!.path);
    setState(() {
      _imagePath=img!.path;
      print(_imagePath);
    });
  }
}
 Widget _customDropDownExample(
    BuildContext context, Penjual? item, String itemDesignation) {
    if (item == null) {
      return Container();
    }
    return Container(
      child:  ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(item.nama),
              subtitle: Text(
                item.namaKelompok,
              ),
            ),
    );
  }
// TextFormField inputtext(TextEditingController con, Icons icon, String label, int tipe, String hint, String msg) {
//     return TextFormField(
//       validator: (value) {
//         if (value!.isEmpty) {
//           return msg;
//         }
//         return null;
//       },
//       controller: con,
//       keyboardType: tipe==2? TextInputType.number:TextInputType.text,
//       decoration: InputDecoration(
//         icon: Icon(icon),
//         hintText: hint,
//         labelText: label,
//       )
//     );
//   }
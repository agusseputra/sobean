import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:sobean/Model/errormsg.dart';
import 'package:sobean/Model/kelompok.dart';
import 'package:sobean/Model/penjual.dart';
import 'package:sobean/Service/api.dart';

class UpdatePenjual extends StatefulWidget {
  final Penjual penjual;
  UpdatePenjual({required this.penjual});
  @override
  _UpdatePenjualState createState() => _UpdatePenjualState();
}

class _UpdatePenjualState extends State<UpdatePenjual> {
  final _formPenjualanKey=GlobalKey<FormState>();
  bool _validate=false;
  bool _isupdate=false;
  late ErrorMSG response;
  late bool _success=false;
  late TextEditingController   nama, nik, alamat, telp;
  late List  idKelompokTani=[];
  late List<Kelompok> _kelompok=[];
  late List _selectedItem=[];
  late String _imagePath="";
  late String _imageURL="";
  final ImagePicker _picker = ImagePicker();
  String? validator(String value) {
    if (value.isEmpty){
      return "jangan kosong";
    }else {
      return null;
    }
  }
  void getKelompok() async {
  final respose = await ApiService.getKelompokList();  
  setState(() {
        _kelompok=respose.toList();
        });
  }
  void getKelompokPetani() async {
  final respose = await ApiService.getkelompokPetani(widget.penjual.idPengguna.toString());  
      setState(() {
       // _selectedItem=respose;
        });
  }
  void validasi() async{
    //print("ss");
    if(_formPenjualanKey.currentState!.validate()){      
      _formPenjualanKey.currentState!.save();
      var params =  {
          'nama':nama.text.toString(),
          'nik':nik.text.toString(),
          'alamat' : alamat.text.toString(),
          'telp' :telp.text.toString(),
          'id_kelompok_tani' :jsonEncode(_selectedItem),
        }; 
        //print(params);
        response=await ApiService.updatePenjual(params,widget.penjual.idPenjual, _imagePath);
        _success=response.success;
        final snackBar = SnackBar(content: Text(response.message),);        
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        if (_success) {
          Navigator.pushNamedAndRemoveUntil(context, "penjualppl", (Route<dynamic> route) => false);
        }
    }else {
      _validate = true;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    //print(_selectedItem);
    nama = TextEditingController(text: widget.penjual.nama);
    nik= TextEditingController(text: widget.penjual.nik);
    alamat= TextEditingController(text: widget.penjual.alamat);
    telp= TextEditingController(text: widget.penjual.telp);
    _imageURL=widget.penjual.foto;
    getKelompokPetani();
    super.initState();
    getKelompok();
   
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
              autovalidate: _validate,
              key: _formPenjualanKey,
              child: Column(
                  children: [
                    Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: nama,
                      validator: (u) => u == "" ? "Wajib Diisi " : null,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.verified_user_sharp),
                        hintText: 'Nama Petani',
                        labelText: 'Nama Petani',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: nik,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.confirmation_number),
                        hintText: 'NIK',
                        labelText: 'NIK Petani',
                      ),
                      validator: (u) => u == "" ? "Wajib Diisi " : null,
                    ),
                  ),
                  Container(
                        padding: EdgeInsets.only(left: 40,),
                        child: Column(
                          children: <Widget>[
                            MultiSelectDialogField(
                              searchable: true,
                              buttonText: Text("Kelompok Tani"),
                              title: Text("Kelompok Tani"),
                              items: _kelompok.map((e) => MultiSelectItem(e.idKelompokTani, e.namaKelompok)).toList(),
                              initialValue: _selectedItem,
                              validator: (u) => u == null ? "Wajib Diisi " : null,                              
                              onConfirm: (values) {                            
                                  _selectedItem=values;      
                                  //print(jsonEncode(_selectedItem))  ;               
                              },
                              chipDisplay: MultiSelectChipDisplay(
                                onTap: (value) {
                                  setState(() {
                                    _selectedItem.remove(value);
                                  });
                                },
                              ),
                            ),
                            _selectedItem == null || _selectedItem.isEmpty
                                ? Container(
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "None selected",
                                      style: TextStyle(color: Colors.black54),
                                    ))
                                : Container(),
                          ],
                        ),
                      ),                   
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: telp,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.phone),
                        hintText: 'Nomor HP',
                        labelText: 'Nomor HP Petani',
                      ),
                      validator: (u) => u == "" ? "Wajib Diisi " : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: alamat,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.location_on),
                        hintText: 'Alamat',
                        labelText: 'Alamat Petani',
                      ),
                      validator: (u) => u == "" ? "Wajib Diisi " : null,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          color: Colors.red,
                          child: Text(
                            'RESET PASSWORD',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: (){
                           
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        RaisedButton(
                          color: Colors.green,
                          child: Text(
                            'SIMPAN',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: (){
                            validasi();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ],
                    ),
                  ),
                  ],
              ),
            )
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
  

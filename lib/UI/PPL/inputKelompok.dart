import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sobean/Model/desa.dart';
import 'package:sobean/Model/errormsg.dart';
import 'package:sobean/Model/kelompok.dart';
import 'package:sobean/Service/api.dart';

class InputKelompok extends StatefulWidget {
  final Kelompok kelompok;
  InputKelompok({required this.kelompok});
  @override
  _InputKelompokState createState() => _InputKelompokState();
}

class _InputKelompokState extends State<InputKelompok> {
  final _formKey=GlobalKey<FormState>();
  bool _validate=false;
  bool _isupdate=false;
  late ErrorMSG response;
  late bool _success=false;
  late List<Desa> _desa=[];
  late int idDesa=0;
  late TextEditingController   nama, kartu;
  late String _status='N';
  void validasi() async{
    if(_formKey.currentState!.validate()){      
      _formKey.currentState!.save();
      var params =  {
          'nama_kelompok':nama.text.toString(),
          'nokartu':kartu.text.toString(),
          'id_desa' : idDesa.toString(),
          'status' :_status.toString()
          };
        if(widget.kelompok.idKelompokTani!=0){
          params['id_kelompok_tani']=widget.kelompok.idKelompokTani.toString();
        } 
          print(params);
        response=await ApiService.saveKelompok(params);
        _success=response.success;
        final snackBar = SnackBar(content: Text(response.message));        
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        if (_success) {
          Navigator.pushNamedAndRemoveUntil(context, "kelompokppl", (Route<dynamic> route) => false);
        }
    }else {
      _validate = true;
    }
  }
  void getDesa() async {
  final respose = await ApiService.getDesa();  
  setState(() {
        _desa=respose.toList();
        });
  }
  //  void _handleRadioValueChange1(String value) {
  //   setState(() {
  //     _status = value;
  //   });
  // }
  @override
  void initState() {
    // TODO: implement initState
    nama = TextEditingController();
    kartu = TextEditingController();
    if(widget.kelompok.idKelompokTani!=0){
      nama = TextEditingController(text: widget.kelompok.namaKelompok.toString());
      kartu = TextEditingController(text: widget.kelompok.noKartu.toString());
      idDesa=widget.kelompok.idDesa;
      _status=widget.kelompok.status;
    }
    getDesa();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: _isupdate ? Text('Ubah Data') : Text('Input Data'),
          ),
      body: SingleChildScrollView(
        child:Container(
          padding: EdgeInsets.all(15),
          color: Colors.white,
          child: Form(
            //autovalidate: _validate,
            key: _formKey,
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: nama,
                      keyboardType: TextInputType.text,
                      validator: (u) => u == "" ? "Wajib Diisi " : null,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.perm_identity),
                        hintText: 'Nama Kelompok',
                        labelText: 'Nama Kelompok',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: kartu,
                      keyboardType: TextInputType.text,
                      validator: (u) => u == "" ? "Wajib Diisi " : null,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.assignment_ind),
                        hintText: 'No Identitas Kelompok',
                        labelText: 'No Identitas Kelompok',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: DropdownButtonFormField(
                      hint: Text("Desa"),                      
                      value: idDesa==0?null:idDesa,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.location_on),
                        //hintText: 'Jeruk Bali',
                        //labelText: 'Jenis Komoditas *',
                      ),
                      items: _desa.map((item) {
                        return DropdownMenuItem(
                          child: Text(item.namaDesa),
                          value: item.idDesa.toInt(),
                        );
                      }).toList(),
                      onChanged: (value) {                      
                        setState(() {
                          idDesa=value as int;
                        });
                      },
                      validator: (u) => u == null ? "Wajib Diisi " : null,
                    ),
                  ),
                  Padding(
                  padding: EdgeInsets.only(bottom: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.visibility),
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
                            'Aktif'
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
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
              ],
            ),
          ),
        )),
    );
  }
}
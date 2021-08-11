import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sobean/Model/desa.dart';
import 'package:sobean/Model/errormsg.dart';
import 'package:sobean/Model/gradeKomoditas.dart';
import 'package:sobean/Model/kelompok.dart';
import 'package:sobean/Model/panen.dart';
import 'package:sobean/Model/penjual.dart';
class ApiService {
    static final _host = 'https://www.siprotani.com/api';
    //static final _host = 'http://10.10.22.194/siprotani/api';
    static var _token="rmRIo5vSPs2lU3FQv5HdGtFLwACWXRw1ThXiN2BGBaiPKz0NBFZRWMDwgqaqSikDXSXPDyffIyGywGFY";
    Future<SharedPreferences> preferences = SharedPreferences.getInstance();
      //final SharedPreferences prefs = await preferences;    
    static Future<void> getPref() async {
      Future<SharedPreferences> preferences = SharedPreferences.getInstance();
      final SharedPreferences prefs = await preferences;    
      _token = prefs.getString('token') ?? "";
    }
    static Future<List<Panen>> getPanen(int page, String _s,idKomoditas) async {
      try {  
        getPref();
        final response = await http.get(Uri.parse('$_host/panen?page='+page.toString()+'&s='+_s+'&produk='+idKomoditas.toString()),
        headers: {
        'Authorization':'Bearer '+_token,
      }); 
          if (response.statusCode == 200) {
            final json = jsonDecode(response.body);
            //print(json);
            final parsed = json['data'].cast<Map<String, dynamic>>();
            return parsed.map<Panen>((json) => Panen.fromJson(json)).toList();
            //return compute(parsePanen, response.body);          
          } else {
            return [];
          }
        } catch (e) {
          return [];
        }
    }
    static Future<List<PanenList>> getPanenPPL(int page, String _s,String _selectedChoice) async {
      //print(_selectedChoice);
      try {  
        //getPref();
        final response = await http.get(Uri.parse('$_host/produklist?page='+page.toString()+'&s='+_s+'&publish='+_selectedChoice),
        headers: {
        'Authorization':'Bearer '+_token,
      }); 
          if (response.statusCode == 200) {
            final json = jsonDecode(response.body);
            final parsed = json['data'].cast<Map<String, dynamic>>();
            return parsed.map<PanenList>((json) => PanenList.fromJson(json)).toList();
            //return compute(parsePanen, response.body);          
          } else {
            return [];
          }
        } catch (e) {
          return [];
        }
    }
    static Future<List<Kelompok>> getKelompokPPL(int page, String _s,String _selectedChoice) async {      
      try {  
        //getPref();
        final response = await http.get(Uri.parse('$_host/kelompok?page='+page.toString()+'&s='+_s+'&active='+_selectedChoice),
        headers: {
        'Authorization':'Bearer '+_token,
        });  
          if (response.statusCode == 200) {
            final json = jsonDecode(response.body);
            //print(json);
            final parsed = json['data'].cast<Map<String, dynamic>>();
            return parsed.map<Kelompok>((json) => Kelompok.fromJson(json)).toList();
            //return compute(parsePanen, response.body);          
          } else {
            return [];
          }
        } catch (e) {
          return [];
        }
    }
    static Future<List<Kelompok>> getKelompokList() async {
      try {  
        //getPref();
        final response = await http.get(Uri.parse('$_host/kelompok_list'),
        headers: {
        'Authorization':'Bearer '+_token,
        }); 
          if (response.statusCode == 200) {
            final json = jsonDecode(response.body);
            final parsed = json.cast<Map<String, dynamic>>();
            return parsed.map<Kelompok>((json) => Kelompok.fromJson(json)).toList();
            //return compute(parsePanen, response.body);          
          } else {
            return [];
          }
        } catch (e) {
          return [];
        }
    }
    static Future<Panen> detailPanen(int id) async {
       try {  
        final response = await http.get(Uri.parse('$_host/panen/'+id.toString()+'/edit'),
        headers: {
          'Authorization':'Bearer '+_token,
        }); 
          if (response.statusCode == 200) {
            return Panen.fromJson(jsonDecode(response.body));    
          } else {
            throw Exception('Failed to load Panen');
          }
        } catch (e) {
         throw Exception('Failed to load Panen');
        }
    }
    static Future<Penjual> detailPenjual(int id) async {
       try {  
        final response = await http.get(Uri.parse('$_host/penjual/'+id.toString()+'/edit'),
        headers: {
          'Authorization':'Bearer '+_token,
        }); 
          if (response.statusCode == 200) {
            return Penjual.fromJson(jsonDecode(response.body));    
          } else {
            throw Exception('Failed to load Panen');
          }
        } catch (e) {
         throw Exception('Failed to load Panen');
        }
    }
    static Future<List<GradeKomoditas>> getGradeKomoditas() async {
        try {  
        final response = await http.get(Uri.parse('$_host/gradekomoditas?'),
        headers: {
          'Authorization':'Bearer '+_token,
        }); 
          if (response.statusCode == 200) {
            final json = jsonDecode(response.body);            
            final parsed = json.cast<Map<String, dynamic>>();
            return parsed.map<GradeKomoditas>((json) => GradeKomoditas.fromJson(json)).toList();
            } else {
            return [];
          }
        } catch (e) {
         return [];
        }
    }
    
    static Future<List<Penjual>> getPenjual(int page, String _s,String _selectedChoice) async {
        try {  
        final response = await http.get(Uri.parse('$_host/penjual?page='+page.toString()+'&s='+_s+'&active='+_selectedChoice),
        headers: {
          'Authorization':'Bearer '+_token,
        }); 
          if (response.statusCode == 200) {
            final json = jsonDecode(response.body);
            final parsed = json['data'].cast<Map<String, dynamic>>();
            return parsed.map<Penjual>((json) => Penjual.fromJson(json)).toList();
            } else {
            return [];
          }
        } catch (e) {
         return [];
        }
    }
    static Future<List<Penjual>> getPenjualList(_s) async {
        try {  
        final response = await http.get(Uri.parse('$_host/penjuallist?s='+_s),
        headers: {
          'Authorization':'Bearer '+_token,
        }); 
          if (response.statusCode == 200) {
            final json = jsonDecode(response.body);
            final parsed = json.cast<Map<String, dynamic>>();
            return parsed.map<Penjual>((json) => Penjual.fromJson(json)).toList();
            } else {
            return [];
          }
        } catch (e) {
         return [];
        }
    }
    static Future<List<Penjual>> searchPenjual(String s) async {
        try {  
        final response = await http.get(Uri.parse('$_host/penjual_search?s='+s.toString()),
        headers: {
          'Authorization':'Bearer '+_token,
        }); 
          if (response.statusCode == 200) {
            final json = jsonDecode(response.body);
            print(json);
            final parsed = json.cast<Map<String, dynamic>>();
            return parsed.map<Penjual>((json) => Penjual.fromJson(json)).toList();
            } else {
            return [];
          }
        } catch (e) {
         return [];
        }
    }
    static Future<List> getkelompokPetani(String id) async {
        try {  
        final response = await http.get(Uri.parse('$_host/kelompokpetani/'+id.toString()),
        headers: {
          'Authorization':'Bearer '+_token,
        }); 
          if (response.statusCode == 200) {
            final json = jsonDecode(response.body);
            return json;
            } else {
            return [];
          }
        } catch (e) {
         return [];
        }
    }
    static Future<List<Desa>> getDesa() async {
        try {  
        final response = await http.get(Uri.parse('$_host/desa?'),
        headers: {
          'Authorization':'Bearer '+_token,
        }); 
          if (response.statusCode == 200) {
            final json = jsonDecode(response.body);
            final parsed = json.cast<Map<String, dynamic>>();
            return parsed.map<Desa>((json) => Desa.fromJson(json)).toList();
            } else {
            return [];
          }
        } catch (e) {
         return [];
        }
    }
    
    static Future<ErrorMSG> saveKelompok(_post) async {
    try {
      final response = await http.post(Uri.parse('$_host/kelompok'), body: _post,
      headers: {
          'Authorization':'Bearer '+_token,
        });
      if (response.statusCode == 200) {
          return ErrorMSG.fromJson(jsonDecode(response.body));
        } else {          
          return ErrorMSG(success: false,message: 'Err, periksan kembali inputan anda',code:'');
        }
        
    } catch (e) {
      ErrorMSG responseRequest = ErrorMSG(success: false,message: 'error caught: $e',code:'');
      return responseRequest;
    }
    
  }
// static Future<ErrorMSG> saveKelompoks(_panen) async {
//     try {
//       var request = http.MultipartRequest('POST', Uri.parse('$_host/kelompok'));
//       request.fields['id_desa']=_panen['id_desa'];
//       request.fields['nama_kelompok']=_panen['nama_kelompok'];
//       request.fields['nokartu']=_panen['nokartu'];
//       request.fields['status']=_panen['status'];
//       request.headers.addAll(
//         {
//           'Authorization':'Bearer '+_token,
//         }
//       );
//       var response = await request.send();
//       //final response = await http.post(Uri.parse('$_host/panen'), body:_panen);
//       if (response.statusCode == 200) {
//           //return ErrorMSG.fromJson(jsonDecode(response.body));
//           final respStr = await response.stream.bytesToString();
//           return ErrorMSG.fromJson(jsonDecode(respStr));
//         } else {
//           //return ErrorMSG.fromJson(jsonDecode(response.body));
//           return ErrorMSG(success: false,message: 'err Request',code:'');
//         }
//     } catch (e) {
//       ErrorMSG responseRequest = ErrorMSG(success: false,message: 'error caught: $e',code:'');
//       return responseRequest;
//     }
    
//   }
    static Future<ErrorMSG> savePenjual(_panen, filepath) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$_host/penjual'));
      request.fields['nama']=_panen['nama'];
      request.fields['nik']=_panen['nik'];
      request.fields['alamat']=_panen['alamat'];
      request.fields['telp']=_panen['telp'];
      request.fields['id_kelompok_tani']=_panen['id_kelompok_tani'];
      request.fields['email']=_panen['email'];
      request.fields['password']=_panen['password'];
      if(filepath!=''){
        request.files.add(await http.MultipartFile.fromPath('image', filepath));
      }
      request.headers.addAll(
        {
          'Authorization':'Bearer '+_token,
        }
      );
      var response = await request.send();
      //final response = await http.post(Uri.parse('$_host/panen'), body:_panen);
      if (response.statusCode == 200) {
          //return ErrorMSG.fromJson(jsonDecode(response.body));
          final respStr = await response.stream.bytesToString();
          return ErrorMSG.fromJson(jsonDecode(respStr));
        } else {
          //return ErrorMSG.fromJson(jsonDecode(response.body));
          return ErrorMSG(success: false,message: 'err Request',code:'');
        }
    } catch (e) {
      ErrorMSG responseRequest = ErrorMSG(success: false,message: 'error caught: $e',code:'');
      return responseRequest;
    }
    
  }
  static Future<ErrorMSG> updatePenjual(_panen, id, filepath) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$_host/penjual/'+id.toString()));
      request.fields['nama']=_panen['nama'];
      request.fields['nik']=_panen['nik'];
      request.fields['alamat']=_panen['alamat'];
      request.fields['telp']=_panen['telp'];
      request.fields['id_kelompok_tani']=_panen['id_kelompok_tani'];
      if(filepath!=''){
        request.files.add(await http.MultipartFile.fromPath('image', filepath));
      }
      request.headers.addAll(
        {
          'Authorization':'Bearer '+_token,
        }
      );
      var response = await request.send();
      //final response = await http.post(Uri.parse('$_host/panen'), body:_panen);
      if (response.statusCode == 200) {
          //return ErrorMSG.fromJson(jsonDecode(response.body));
          final respStr = await response.stream.bytesToString();
          return ErrorMSG.fromJson(jsonDecode(respStr));
        } else {
          //return ErrorMSG.fromJson(jsonDecode(response.body));
          final respStr = await response.stream.bytesToString();
          return ErrorMSG.fromJson(jsonDecode(respStr));
          //return ErrorMSG(success: false,message: 'err Request',code:'');
        }
    } catch (e) {
      ErrorMSG responseRequest = ErrorMSG(success: false,message: 'error caught: $e',code:'');
      return responseRequest;
    }
    
  }
  static Future<ErrorMSG> savePanen(_panen, id, filepath) async {
    try {
      
      var request = http.MultipartRequest('POST', Uri.parse('$_host/panen'));
      if(id!=0){
        request.fields['id_komoditas_dijual']=_panen['id_komoditas_dijual'];
      }
      request.fields['id_grade_komoditas']=_panen['id_grade_komoditas'];
      request.fields['id_anggota_tani']=_panen['id_anggota_tani'];
      request.fields['tgl_perkiraan_panen']=_panen['tgl_perkiraan_panen'];
      request.fields['waktu_tanam']=_panen['waktu_tanam'];
      request.fields['jumlah_perkiraan_panen']=_panen['jumlah_perkiraan_panen'];
      request.fields['satuan']=_panen['satuan'];
      request.fields['jumlah_riil_panen']=_panen['jumlah_riil_panen'];
      request.fields['tgl_panen']=_panen['tgl_panen'];
      request.fields['publish']=_panen['publish'];
      request.fields['harga']=_panen['harga'];
      request.fields['tgl_harga_berlaku']=_panen['tgl_harga_berlaku'];
      //print(request);
      if(filepath!=''){
        request.files.add(await http.MultipartFile.fromPath('image', filepath));
      }
      request.headers.addAll(
        {
          'Authorization':'Bearer '+_token,
        }
      );
      var response = await request.send();
      
      //final response = await http.post(Uri.parse('$_host/panen'), body:_panen);
      if (response.statusCode == 200) {
          //return ErrorMSG.fromJson(jsonDecode(response.body));
          //return ErrorMSG(success: true,message:"success",code: "00" );
          final respStr = await response.stream.bytesToString();
          return ErrorMSG.fromJson(jsonDecode(respStr));
        } else {
          //return ErrorMSG.fromJson(jsonDecode(response.body));
          final respStr = await response.stream.bytesToString();
          return ErrorMSG.fromJson(jsonDecode(respStr));
        }
    } catch (e) {
      ErrorMSG responseRequest = ErrorMSG(success: false,message: 'error caught: $e',code:'');
      return responseRequest;
    }
    
  }
  static Future<ErrorMSG> sigIn(_post) async {
      try {  
        final response = await http.post(Uri.parse('$_host/login'),body:_post); 
          if (response.statusCode == 200) {
          var res=jsonDecode(response.body);
          //print(res);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // var idppl=res['data']['id_ppl']==null?'':res['data']['id_ppl'] ;
          // var idp=res['data']['id_penjual']==null?'':res['data']['id_penjual'];
            prefs.setString('token', res['data']['token']);
            prefs.setString('name', res['data']['name']);
            prefs.setString('email', res['data']['email']);
            prefs.setString('token', res['data']['token']);
            prefs.setInt('level', 1);
            if(res['data']['id_ppl']!=null){
              prefs.setString('id_ppl', res['data']['id_ppl'].toString());
            }
            if(res['data']['id_penjual']!=null){
              prefs.setString('id_penjual', res['data']['id_penjual'].toString());
            }            
          return ErrorMSG.fromJson(res);
          } else {
            return ErrorMSG.fromJson(jsonDecode(response.body));
          }
        } catch (e) {
          ErrorMSG responseRequest = ErrorMSG(success: false,message: 'error caught: $e',code:'');
          return responseRequest;
        }
    }
  
}
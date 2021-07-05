import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sobean/Model/errormsg.dart';
import 'package:sobean/Model/gradeKomoditas.dart';
import 'package:sobean/Model/panen.dart';
import 'package:sobean/Model/penjual.dart';
class ApiService {
    static final _host = 'http://192.168.100.128/siprotani/api';
    //static final _host = 'http://10.10.46.55/siprotani/api';
    static Future<List<Panen>> getPanen(int page, String _s) async {
      print(_s);
        try {  
        final response = await http.get(Uri.parse('$_host/panen?page='+page.toString()+'&s='+_s)); 
          if (response.statusCode == 200) {
            final json = jsonDecode(response.body);
            // print(json);
            // //ResponPanen res = ResponPanen.fromJson(json);  
            // // listPanen= List<Panen>.from(json['data'].map((x) => Panen.fromJson(x)));
            // // final parsed = json['data'].cast<Map<String, dynamic>>();
            // // List<Panen> listPanen=parsed.map<Panen>((json) => Panen.fromJson(json)).toList();
            // // print(listPanen);
            // //print('ss');
            // json.forEach((item) {
            //   //print(item);
            //   listPanen.add(item);
            // });
            // print(listPanen);
            // return listPanen;
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
    static Future<List<GradeKomoditas>> getGradeKomoditas() async {
        try {  
        final response = await http.get(Uri.parse('$_host/gradekomoditas?')); 
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
    static Future<List<Penjual>> getPenjual(int page) async {
        try {  
        final response = await http.get(Uri.parse('$_host/penjual?page='+page.toString())); 
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
    static Future<List<Penjual>> searchPenjual(String s) async {
        try {  
        final response = await http.get(Uri.parse('$_host/penjual_search?s='+s.toString())); 
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
  //   static Future<ResponsePost> savePanen() async {
  //   try {
  //     final response = await http.post(Uri.parse('$_host/panen'), body: {
  //       'id_grade_komoditas':'1',
  //       'id_anggota_tani' : '24',
  //       'tgl_perkiraan_panen' :'2020-12-3',
  //       'waktu_tanam' :'2020-12-31',
  //       'jumlah_perkiraan_panen':'2222',
  //       'satuan' :'kg',
  //       'jumlah_riil_panen':'90',
  //       'tgl_panen':'2020-12-31',
  //       'status':'Y',
  //       'harga':'222222',
  //       'tgl_harga_berlaku':'2020-12-31'
  //     });

  //     if (response.statusCode == 200) {
  //       //print(response.body);
  //       //ErrorMSG responseRequest = ErrorMSG.fromJson(jsonDecode(response.body));
  //       //return jsonDecode(response.body);
  //       if (response.statusCode == 200) {
  //         ResponsePost responseRequest = ResponsePost.fromJson(jsonDecode(response.body));
  //         return responseRequest;
  //       } else {
  //         return ResponsePost(success: false,message:response.statusCode.toString(),id: 0 );
  //       }
  //     }else{
  //        return jsonDecode(response.body);
  //     }
        
  //   } catch (e) {
  //     ResponsePost responseRequest = ResponsePost(success: false,message: e.toString(),id: 0);
  //     return responseRequest;
  //   }
    
  // }
  static Future<ErrorMSG> savePanen(_panen) async {
    try {
      final response = await http.post(Uri.parse('$_host/panen'), body:_panen);
      if (response.statusCode == 200) {
          return ErrorMSG.fromJson(jsonDecode(response.body));
          //return ErrorMSG(success: res['success'],message:res['message'],code: res['code'] );
        } else {
          return ErrorMSG.fromJson(jsonDecode(response.body));
        }
    } catch (e) {
      ErrorMSG responseRequest = ErrorMSG(success: false,message: 'err',code:'');
      return responseRequest;
    }
    
  }
  
}
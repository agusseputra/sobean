
// class ResponPanen {
//     ResponPanen({
//         required this.currentPage,
//         required this.data,
//         required this.firstPageUrl,
//         required this.from,
//         required this.lastPage,
//         required this.lastPageUrl,
//         required this.nextPageUrl,
//         required this.path,
//         required this.perPage,
//         required this.prevPageUrl,
//         required this.to,
//         required this.total,
//     });

//     int currentPage;
//     List<Panen> data;
//     String firstPageUrl;
//     int from;
//     int lastPage;
//     String lastPageUrl;
//     dynamic nextPageUrl;
//     String path;
//     int perPage;
//     dynamic prevPageUrl;
//     int to;
//     int total;

//     factory ResponPanen.fromJson(Map<String, dynamic> json) => ResponPanen(
//         currentPage: json["current_page"],
//         data: List<Panen>.from(json["data"].map((x) => Panen.fromJson(x))),
//         firstPageUrl: json["first_page_url"],
//         from: json["from"],
//         lastPage: json["last_page"],
//         lastPageUrl: json["last_page_url"],
//         nextPageUrl: json["next_page_url"],
//         path: json["path"],
//         perPage: json["per_page"],
//         prevPageUrl: json["prev_page_url"],
//         to: json["to"],
//         total: json["total"],
//     );

//     Map<String, dynamic> toJson() => {
//         "current_page": currentPage,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "first_page_url": firstPageUrl,
//         "from": from,
//         "last_page": lastPage,
//         "last_page_url": lastPageUrl,
//         "next_page_url": nextPageUrl,
//         "path": path,
//         "per_page": perPage,
//         "prev_page_url": prevPageUrl,
//         "to": to,
//         "total": total,
//     };
// }
class Panen {
    Panen({
        required this.idKomoditasDijual,
        required this.idGradeKomoditas,
        required this.idAnggotaTani,
        required this.tglPerkiraanPanen,
        required this.jumlahPerkiraanPanen,
        required this.tglPanen,
        required this.jumlahRiilPanen,
        required this.satuan,
        required this.createdAt,
        required this.updatedAt,
        required this.foto,
        required this.waktuTanam,
        required this.status,
        required this.publish,
        required this.idKomoditas,
        required this.nama,
        required this.idPengguna,
        required this.idKelompokTani,
        required this.noKartu,
        required this.namaKelompok,
        required this.namaGrade,
        required this.namaKomoditas,
        required this.harga,
        required this.tglHargaBerlaku,
        required this.namaDesa,
    });

    int idKomoditasDijual;
    int idGradeKomoditas;
    int idAnggotaTani;
    String tglPerkiraanPanen;
    String jumlahPerkiraanPanen;
    String tglPanen;
    String jumlahRiilPanen;
    String satuan;
    String createdAt;
    String updatedAt;
    dynamic foto;
    String waktuTanam;
    String status;
    String publish;
    int idKomoditas;
    String nama;
    int idPengguna;
    int idKelompokTani;
    dynamic noKartu;
    String namaKelompok;
    String namaGrade;
    String namaKomoditas;
    String harga;
    String tglHargaBerlaku;
    String namaDesa;


    factory Panen.fromJson(Map<String, dynamic> json) => Panen(
        idKomoditasDijual: json["id_komoditas_dijual"] as int,
        idGradeKomoditas: json["id_grade_komoditas"] as int,
        idAnggotaTani: json["id_anggota_tani"] as int,
        tglPerkiraanPanen: json["tgl_perkiraan_panen"]==null?'':json["tgl_perkiraan_panen"] as String,
        jumlahPerkiraanPanen: json["jumlah_perkiraan_panen"]==null?'':json["jumlah_perkiraan_panen"].toString(),
        tglPanen: json["tgl_panen"] == null ? '' : json["tgl_panen"] as String,
        jumlahRiilPanen: json["jumlah_riil_panen"]==null?'':json["jumlah_riil_panen"].toString(),
        satuan: json["satuan"]==null?'':json["satuan"] as String,
        createdAt: json["created_at"]==null ? '' : json["created_at"] as String,
        updatedAt: json["updated_at"]==null ? '' : json["updated_at"] as String,
        foto: json["foto"]==null ? 'http://www.siprotani.com/files/images/1604215496download%20(5).jpg': "http://192.168.100.128/siprotani/files/panen/"+json["foto"] as String,
        waktuTanam: json["waktu_tanam"]==null ? '' : json["waktu_tanam"] as String,
        status: json["status"]==null ? '' : json["status"] as String,
        publish: json["publish"]==null ? '' : json["publish"] as String,
        idKomoditas: json["id_komoditas"]== null ? 0 : json["id_komoditas"] as int,
        nama: json["nama"] == null ? '' : json["nama"] as String,
        idPengguna: json["id_pengguna"] == null ? 0 : json["id_pengguna"] as int,
        idKelompokTani: json["id_kelompok_tani"]==null ? 0: json["id_kelompok_tani"] as int,
        noKartu: json["no_kartu"] ==null ? '' :json["no_kartu"] as String,
        namaKelompok: json["nama_kelompok"]==null ?'':json["nama_kelompok"] as String,
        namaGrade: json["nama_grade"]==null?'':json["nama_grade"] as String,
        namaKomoditas: json["nama_komoditas"]==null?'':json["nama_komoditas"] as String,
        harga: json["harga"]==null?'':json["harga"] as String,
        tglHargaBerlaku: json["tgl_harga_berlaku"]==null?'':json["tgl_harga_berlaku"] as String,
        namaDesa: json["nama_desa"]==null?'':json["nama_desa"] as String,
    );

    // Map<String, dynamic> toJson() => {
    //     "id_komoditas_dijual": idKomoditasDijual,
    //     "id_grade_komoditas": idGradeKomoditas,
    //     // "id_anggota_tani": idAnggotaTani,
    //     // "tgl_perkiraan_panen": tglPerkiraanPanen,
    //     // "jumlah_perkiraan_panen": jumlahPerkiraanPanen,
    //     // "tgl_panen": tglPanen,
    //     // "jumlah_riil_panen": jumlahRiilPanen,
    //     // "satuan": satuan,
    //     // "created_at": createdAt,
    //     // "updated_at":updatedAt,
    //     // "foto": foto,
    //     // "waktu_tanam": waktuTanam,
    //     // "status": status,
    //     // "publish": publish,
    //     // "id_komoditas": idKomoditas,
    //     // "nama": nama,
    //     // "id_pengguna": idPengguna,
    //     // "id_kelompok_tani": idKelompokTani,
    //     // "no_kartu": noKartu,
    //     // "nama_kelompok": namaKelompok,
    //     // "nama_grade": namaGrade,
    //     // "nama_komoditas": namaKomoditas,
    //     // "harga": harga,
    //     // "tgl_harga_berlaku": tglHargaBerlaku,
    //     // "nama_desa": namaDesa,
    // };
}
class PanenList {
    PanenList({
        required this.idKomoditasDijual,
        required this.idGradeKomoditas,
        required this.idAnggotaTani,
        required this.tglPerkiraanPanen,
        required this.jumlahPerkiraanPanen,
        required this.tglPanen,
        required this.jumlahRiilPanen,
        required this.satuan,
        required this.createdAt,
        required this.updatedAt,
        required this.foto,
        required this.waktuTanam,
        required this.status,
        required this.publish,
        required this.nama,
        required this.idPengguna,
        required this.idKelompokTani,
        required this.noKartu,
        required this.namaKelompok,
        required this.namaGrade,
        required this.namaDesa,
    });

    int idKomoditasDijual;
    int idGradeKomoditas;
    int idAnggotaTani;
    String tglPerkiraanPanen;
    String jumlahPerkiraanPanen;
    String tglPanen;
    String jumlahRiilPanen;
    String satuan;
    String createdAt;
    String updatedAt;
    dynamic foto;
    String waktuTanam;
    String status;
    String publish;
    String nama;
    int idPengguna;
    int idKelompokTani;
    dynamic noKartu;
    String namaKelompok;
    String namaGrade;
    String namaDesa;


    factory PanenList.fromJson(Map<String, dynamic> json) => PanenList(
        idKomoditasDijual: json["id_komoditas_dijual"] as int,
        idGradeKomoditas: json["id_grade_komoditas"] as int,
        idAnggotaTani: json["id_anggota_tani"] as int,
        tglPerkiraanPanen: json["tgl_perkiraan_panen"]==null?'':json["tgl_perkiraan_panen"] as String,
        jumlahPerkiraanPanen: json["jumlah_perkiraan_panen"]==null?'':json["jumlah_perkiraan_panen"].toString(),
        tglPanen: json["tgl_panen"] == null ? '' : json["tgl_panen"] as String,
        jumlahRiilPanen: json["jumlah_riil_panen"]==null?'':json["jumlah_riil_panen"].toString(),
        satuan: json["satuan"]==null?'':json["satuan"] as String,
        createdAt: json["created_at"]==null ? '' : json["created_at"] as String,
        updatedAt: json["updated_at"]==null ? '' : json["updated_at"] as String,
        foto: json["foto"]==null ? 'http://www.siprotani.com/files/images/1604215496download%20(5).jpg': "http://192.168.100.128/siprotani/files/panen/"+json["foto"] as String,
        waktuTanam: json["waktu_tanam"]==null ? '' : json["waktu_tanam"] as String,
        status: json["status"]==null ? '' : json["status"] as String,
        publish: json["publish"]==null ? '' : json["publish"] as String,
        nama: json["nama"] == null ? '' : json["nama"] as String,
        idPengguna: json["id_pengguna"] == null ? 0 : json["id_pengguna"] as int,
        idKelompokTani: json["id_kelompok_tani"]==null ? 0: json["id_kelompok_tani"] as int,
        noKartu: json["no_kartu"] ==null ? '' :json["no_kartu"] as String,
        namaKelompok: json["nama_kelompok"]==null ?'':json["nama_kelompok"] as String,
        namaGrade: json["nama_grade"]==null?'':json["nama_grade"] as String,
        namaDesa: json["nama_desa"]==null?'':json["nama_desa"] as String,
    );

    // Map<String, dynamic> toJson() => {
    //     "id_komoditas_dijual": idKomoditasDijual,
    //     "id_grade_komoditas": idGradeKomoditas,
    //     // "id_anggota_tani": idAnggotaTani,
    //     // "tgl_perkiraan_panen": tglPerkiraanPanen,
    //     // "jumlah_perkiraan_panen": jumlahPerkiraanPanen,
    //     // "tgl_panen": tglPanen,
    //     // "jumlah_riil_panen": jumlahRiilPanen,
    //     // "satuan": satuan,
    //     // "created_at": createdAt,
    //     // "updated_at":updatedAt,
    //     // "foto": foto,
    //     // "waktu_tanam": waktuTanam,
    //     // "status": status,
    //     // "publish": publish,
    //     // "id_komoditas": idKomoditas,
    //     // "nama": nama,
    //     // "id_pengguna": idPengguna,
    //     // "id_kelompok_tani": idKelompokTani,
    //     // "no_kartu": noKartu,
    //     // "nama_kelompok": namaKelompok,
    //     // "nama_grade": namaGrade,
    //     // "nama_komoditas": namaKomoditas,
    //     // "harga": harga,
    //     // "tgl_harga_berlaku": tglHargaBerlaku,
    //     // "nama_desa": namaDesa,
    // };
}

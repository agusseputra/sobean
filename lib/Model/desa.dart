// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);
class Desa {
    Desa({
        required this.idDesa,
        required this.idKecamatan,
        required this.kodeDesa,
        required this.namaDesa
    });

    int idDesa;
    int idKecamatan;
    String kodeDesa;
    String namaDesa;

    factory Desa.fromJson(Map<String, dynamic> json) => Desa(
        idDesa: json["id_desa"],
        idKecamatan: json["id_kecamatan"],
        kodeDesa: json["kode_desa"]==null?'':json["kode_desa"].toString(),
        namaDesa: json["nama_desa"]==null?'':json["nama_desa"].toString()
    );

    Map<String, dynamic> toJson() => {
        "id_desa": idDesa,
        "id_kecamatan": idKecamatan,
        "kode_desa": kodeDesa,
        "nama_desa": namaDesa
    };
}

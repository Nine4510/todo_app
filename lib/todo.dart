class ToDo {
  String keterangan;
  String kegiatan;
  bool isComplete;

  ToDo(this.keterangan, this.kegiatan, this.isComplete);

  // Convert the User object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'keterangan': keterangan,
      'kegiatan': kegiatan,
      'isComplete': isComplete,
    };
  }

  // Create a User object from a JSON map
  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      json['keterangan'],
      json['kegiatan'],
      json['isComplete'],
    );
  }
}

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

  static List<ToDo> get example => [
        ToDo("Test 1", "Lorem Ipsum dolor sit amet", false),
        ToDo("Test 2", "Lorem Ipsum dolor sit amet", false),
        ToDo("Test 3", "Lorem Ipsum dolor sit amet", true),
        ToDo("Test 4", "Lorem Ipsum dolor sit amet", true),
      ];
}

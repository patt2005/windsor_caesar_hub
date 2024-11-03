class Initiativestext {
  final String name;
  final List<String> variants;
  final String imageFilePath;
  bool isAnswered = false;
  final bool isOwn;

  Initiativestext({
    required this.name,
    required this.variants,
    required this.imageFilePath,
    required this.isOwn,
  });
}

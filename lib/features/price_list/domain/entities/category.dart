/// Category entity for price list
class Category {
  final int id;
  final String name;
  final String message;
  final String startDate;
  final String endDate;
  final String pdfAssetPath; // Can be either URL or asset path
  final int pageCount;

  const Category({
    required this.id,
    required this.name,
    required this.message,
    required this.startDate,
    required this.endDate,
    required this.pdfAssetPath,
    this.pageCount = 0,
  });
}

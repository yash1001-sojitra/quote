import 'dart:convert';

class QuotesModel {
  int? count;
  int? totalCount;
  int? page;
  int? totalPages;
  String? lastItemIndex;
  List<String>? results;
  QuotesModel({
    this.count,
    this.totalCount,
    this.page,
    this.totalPages,
    this.lastItemIndex,
    this.results,
  });
  

  QuotesModel copyWith({
    int? count,
    int? totalCount,
    int? page,
    int? totalPages,
    String? lastItemIndex,
    List<String>? results,
  }) {
    return QuotesModel(
      count: count ?? this.count,
      totalCount: totalCount ?? this.totalCount,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      lastItemIndex: lastItemIndex ?? this.lastItemIndex,
      results: results ?? this.results,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(count != null){
      result.addAll({'count': count});
    }
    if(totalCount != null){
      result.addAll({'totalCount': totalCount});
    }
    if(page != null){
      result.addAll({'page': page});
    }
    if(totalPages != null){
      result.addAll({'totalPages': totalPages});
    }
    if(lastItemIndex != null){
      result.addAll({'lastItemIndex': lastItemIndex});
    }
    if(results != null){
      result.addAll({'results': results});
    }
  
    return result;
  }

  factory QuotesModel.fromMap(Map<String, dynamic> map) {
    return QuotesModel(
      count: map['count']?.toInt(),
      totalCount: map['totalCount']?.toInt(),
      page: map['page']?.toInt(),
      totalPages: map['totalPages']?.toInt(),
      lastItemIndex: map['lastItemIndex'],
      results: List<String>.from(map['results']),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuotesModel.fromJson(String source) => QuotesModel.fromMap(json.decode(source));
}

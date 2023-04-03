import 'dart:convert';

class QuotesModel {
  int? count;
  int? totalCount;
  int? page;
  int? totalPages;
  int? lastItemIndex;
  List<Results>? results;
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
    int? lastItemIndex,
    List<Results>? results,
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

    if (count != null) {
      result.addAll({'count': count});
    }
    if (totalCount != null) {
      result.addAll({'totalCount': totalCount});
    }
    if (page != null) {
      result.addAll({'page': page});
    }
    if (totalPages != null) {
      result.addAll({'totalPages': totalPages});
    }
    if (lastItemIndex != null) {
      result.addAll({'lastItemIndex': lastItemIndex});
    }
    if (results != null) {
      result.addAll({'results': results!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory QuotesModel.fromMap(Map<String, dynamic> map) {
    return QuotesModel(
      count: map['count']?.toInt(),
      totalCount: map['totalCount']?.toInt(),
      page: map['page']?.toInt(),
      totalPages: map['totalPages']?.toInt(),
      lastItemIndex: map['lastItemIndex']?.toInt(),
      results: map['results'] != null
          ? List<Results>.from(map['results']?.map((x) => Results.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuotesModel.fromJson(String source) =>
      QuotesModel.fromMap(json.decode(source));
}

class Results {
  String? Id;
  String? content;
  String? author;
  List<String>? tags;
  String? authorSlug;
  int? length;
  String? dateAdded;
  String? dateModified;
  Results({
    this.Id,
    this.content,
    this.author,
    this.tags,
    this.authorSlug,
    this.length,
    this.dateAdded,
    this.dateModified,
  });

  Results copyWith({
    String? Id,
    String? content,
    String? author,
    List<String>? tags,
    String? authorSlug,
    int? length,
    String? dateAdded,
    String? dateModified,
  }) {
    return Results(
      Id: Id ?? this.Id,
      content: content ?? this.content,
      author: author ?? this.author,
      tags: tags ?? this.tags,
      authorSlug: authorSlug ?? this.authorSlug,
      length: length ?? this.length,
      dateAdded: dateAdded ?? this.dateAdded,
      dateModified: dateModified ?? this.dateModified,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (Id != null) {
      result.addAll({'Id': Id});
    }
    if (content != null) {
      result.addAll({'content': content});
    }
    if (author != null) {
      result.addAll({'author': author});
    }
    if (tags != null) {
      result.addAll({'tags': tags});
    }
    if (authorSlug != null) {
      result.addAll({'authorSlug': authorSlug});
    }
    if (length != null) {
      result.addAll({'length': length});
    }
    if (dateAdded != null) {
      result.addAll({'dateAdded': dateAdded});
    }
    if (dateModified != null) {
      result.addAll({'dateModified': dateModified});
    }

    return result;
  }

  factory Results.fromMap(Map<String, dynamic> map) {
    return Results(
      Id: map['Id'],
      content: map['content'],
      author: map['author'],
      tags: List<String>.from(map['tags']),
      authorSlug: map['authorSlug'],
      length: map['length']?.toInt(),
      dateAdded: map['dateAdded'],
      dateModified: map['dateModified'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Results.fromJson(String source) =>
      Results.fromMap(json.decode(source));
}

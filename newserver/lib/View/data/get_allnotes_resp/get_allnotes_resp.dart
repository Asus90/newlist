import 'package:json_annotation/json_annotation.dart';

import 'package:newserver/View/data/note_model/note_model.dart';

part 'get_allnotes_resp.g.dart';

@JsonSerializable()
class GetAllnotesResp {
  @JsonKey(name: 'data')
  List<NoteModel> data;

  GetAllnotesResp({this.data = const []});

  factory GetAllnotesResp.fromJson(Map<String, dynamic> json) {
    return _$GetAllnotesRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetAllnotesRespToJson(this);
}

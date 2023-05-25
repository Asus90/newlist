// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_allnotes_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllnotesResp _$GetAllnotesRespFromJson(Map<String, dynamic> json) =>
    GetAllnotesResp(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => NoteModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GetAllnotesRespToJson(GetAllnotesResp instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

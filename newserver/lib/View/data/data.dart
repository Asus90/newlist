import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:newserver/View/data/get_allnotes_resp/get_allnotes_resp.dart';
import 'package:newserver/View/data/note_model/note_model.dart';
import 'package:newserver/View/data/Url.dart';

abstract class APiCalls {
  Future<NoteModel?> CreateNote(NoteModel value);
  Future<List<NoteModel>> getAllnotes();
  Future<NoteModel?> Updatenote(NoteModel value);
  Future<void> deleteNote(String id);
}

class NoteDB extends APiCalls {
  // == signleton
  NoteDB._internal();
  static NoteDB instence = NoteDB._internal();
  NoteDB factory() {
    return instence;
  }

  // ===endsignton

  final dio = Dio();
  final url = URl();
  ValueNotifier<List<NoteModel>> noteListNotifire = ValueNotifier([]);

  NoteDB() {
    dio.options = BaseOptions(
      baseUrl: url.baseUrl,
      responseType: ResponseType.plain,
    );
  }

  @override
  Future<NoteModel?> CreateNote(NoteModel value) async {
    try {
      final _result = await dio.post(
        url.Createnote,
        data: value.toJson(),
      );

      final _resultASjson = jsonDecode(_result.data);
      return NoteModel.fromJson(_resultASjson as Map<String, dynamic>);
    } on DioError catch (e) {
      print(e.response?.data);
      print(e);
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Future<NoteModel?> Updatenote(NoteModel value) async {}

  @override
  Future<void> deleteNote(String id) async {}

  @override
  Future<List<NoteModel>> getAllnotes() async {
    try {
      final _result = await dio.get(url.baseUrl + url.getallnote,
          options: Options(
            responseType: ResponseType.plain,
          ));

      if (_result.data != null) {
        final _resultAsjson = jsonDecode(_result.data);

        final getNoteResp = GetAllnotesResp.fromJson(_resultAsjson);

        noteListNotifire.value.clear();
        noteListNotifire.value.addAll(getNoteResp.data.reversed);

        return getNoteResp.data;
      } else {
        noteListNotifire.value.clear();
        return [];
      }
    } catch (e) {
      print('Error fetching notes: $e');
      // noteListNotifire.value.clear();
      return [];
    }
  }
}

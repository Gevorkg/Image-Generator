import 'dart:async';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:social_media/features/prompt/repos/prompt_repos.dart';

part 'prompt_event.dart';
part 'prompt_state.dart';

class PromptBloc extends Bloc<PromptEvent, PromptState> {
  PromptBloc() : super(PromptInitial()) {
    on<PromptEnteredEvent>(promptEnteredEvent);
    on<PromptInitalEvent>(promptInitalEvent);
  }

  FutureOr<void> promptEnteredEvent(
      PromptEnteredEvent event, Emitter<PromptState> emit) async {
    emit(PromptGeneratingImageLoadState());
    Uint8List? bytes = await PromptRepos.generateImage(event.prompt);
    if (bytes != null) {
      emit(PromptGeneratingImageSucessState(bytes));
    } else {
      emit(PromptGeneratingImageFailedState());
    }
  }

  FutureOr<void> promptInitalEvent(
      PromptInitalEvent event, Emitter<PromptState> emit) async {
    try {
      ByteData data = await rootBundle.load('assets/file.png');
      Uint8List bytes = data.buffer.asUint8List();

      emit(PromptGeneratingImageSucessState(bytes));
    } catch (e) {
      emit(PromptGeneratingImageFailedState());
    }
  }
}

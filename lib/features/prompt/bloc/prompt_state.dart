part of 'prompt_bloc.dart';

@immutable
sealed class PromptState {}

final class PromptInitial extends PromptState {}

final class PromptGeneratingImageLoadState extends PromptState {}

final class PromptGeneratingImageFailedState extends PromptState {}

final class PromptGeneratingImageSucessState extends PromptState {
  final Uint8List uint8List;

  PromptGeneratingImageSucessState(this.uint8List);
}

part of 'comments_cubit.dart';

@immutable
sealed class CommentsState {}

final class CommentsInitial extends CommentsState {}

final class Closestate extends CommentsState {}

final class Emojistate extends CommentsState {}

final class PostLoadingstate extends CommentsState {}

final class PostDonestate extends CommentsState {}

final class PostFailedstate extends CommentsState {}

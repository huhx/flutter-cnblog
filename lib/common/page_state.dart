import 'package:equatable/equatable.dart';

class PageState<int, T> extends Equatable {
  final int? nextKey;
  final List<T>? itemList;
  final dynamic error;

  const PageState({this.nextKey, this.itemList, this.error});

  @override
  List<Object?> get props => [nextKey, itemList, error];
}

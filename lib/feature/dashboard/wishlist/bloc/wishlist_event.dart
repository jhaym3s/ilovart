part of 'wishlist_bloc.dart';

sealed class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}



class GetWishListEvent extends WishlistEvent{}

class AddWishListEvent extends WishlistEvent{
  final List<dynamic> favorite;

  AddWishListEvent({required this.favorite});
}

class RemoveWishListEvent extends WishlistEvent{
  final List<dynamic> favorite;
  RemoveWishListEvent({required this.favorite});
}
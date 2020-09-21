import 'package:MyUnicircle/components/full_image_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:MyUnicircle/resources/user_repository.dart';
import 'package:photo_view/photo_view.dart';

class UserImage extends StatelessWidget {
  final String image;

  const UserImage({Key key, this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
        onTap: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (builder) {
                return FullImage(image: currentUser.value.image);
              });
        },
        child: CircleAvatar(
          radius: 55,
          backgroundColor: Theme.of(context).primaryColor,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[100],
            child: CachedNetworkImage(
              imageUrl: "${currentUser.value.image}",
              imageBuilder: (context, imageProvider) => Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              placeholder: (context, url) =>
                  Icon(Icons.person, color: Colors.grey, size: 60),
              errorWidget: (context, url, error) =>
                  Icon(Icons.person, color: Colors.grey, size: 60),
            ),
          ),
        ),
      )
    ]);
  }
}

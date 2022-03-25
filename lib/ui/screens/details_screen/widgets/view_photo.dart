import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

// ignore: must_be_immutable
class ViewPhoto extends StatelessWidget {
  String photoUrl;

  ViewPhoto(this.photoUrl, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: Dismissible(
        background: Container(
          color: Colors.black,
        ),
        key: const Key('key'),
        direction: DismissDirection.down,
        onDismissed: (_) => Navigator.of(context).pop(),
        child: Hero(
          tag: 'image',
          child: PhotoView(
            imageProvider: NetworkImage(photoUrl),
            loadingBuilder: (_, __) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            errorBuilder: (_, __, ___) {
              return const Center(
                child: Icon(
                  Icons.image_not_supported_outlined,
                  size: 50,
                  color: Colors.grey,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:cgwallet/common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MyImage extends StatelessWidget {
  const MyImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.borderRadius,
    this.fit = BoxFit.cover,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    final BaseCacheManager cacheManager = DefaultCacheManager();

    Future<File?> future(String url) async {
      final fileInfo = await cacheManager.getFileFromCache(url);
      if (fileInfo == null) {
        final checkUrlIsValid = await DioService.to.checkUrlIsValid(url);
        if (checkUrlIsValid) {
          final file = await cacheManager.getSingleFile(url);
          return file;
        } else {
          return null;
        }
      } else {
        return fileInfo.file;
      }
    }

    return FutureBuilder<File?>(
      future: future(imageUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoading();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return _buildError(context);
          } else {
            return _buildImage(snapshot.data!);
          }
        } else if (snapshot.hasError) {
          return _buildError(context);
        } else if (snapshot.hasData) {
          return _buildImage(snapshot.data!);
        } else {
          return _buildError(context);
        }
      },
    );
  }

  Widget _buildLoading() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
      ),
      clipBehavior: Clip.antiAlias,
      child: const Center(child: CupertinoActivityIndicator()),
    );
  }

  Widget _buildImage(File file) {
    if (borderRadius == null) {
      return Image.file(file,
        width: width,
        height: height,
        fit: fit,
      );
    } else {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          image: DecorationImage(
            image: FileImage(file),
            fit: fit,
          ),
        ),
        clipBehavior: Clip.antiAlias,
      );
    }
  }

  Widget _buildError(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(padding: const EdgeInsets.all(6), child: Center(
        child: FittedBox(child: Icon(Icons.broken_image, size: 64, color: Theme.of(context).myColors.onBackground.withOpacity(0.2)))
      )),
    );
  }
}


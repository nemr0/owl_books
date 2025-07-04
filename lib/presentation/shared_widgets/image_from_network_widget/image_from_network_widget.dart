import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/generated/assets.gen.dart';

/// A widget that displays an image with a loading skeleton and error handling.
class ImageFromNetwork extends StatelessWidget {
  const ImageFromNetwork(this.imageUrl,{super.key,  this.loading = false,this.errorText = 'No Cover Available',  this.boxFit = BoxFit.contain});
  final String? imageUrl;
  final bool loading;
  final String errorText;
  final BoxFit boxFit;
  @override
  Widget build(BuildContext context) {



    return  Skeletonizer(
      enabled: loading,
      child: Builder(
        builder: (context) {
          if (loading) {
            return const _CoverSkeleton();
          }
          return CachedNetworkImage(
            imageUrl: imageUrl ?? '',
            fit: boxFit,
            placeholder: (_, __) => const _CoverSkeleton(),
            errorWidget: (_, e, s) {
              return _CoverError(errorText);
              },
          );
        },
      ),
    );
  }
}
/// A skeleton widget that shows a shimmer effect while the image is loading.
class _CoverSkeleton extends StatelessWidget {
  const _CoverSkeleton();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: context.shimmerEffect,
      child: const Bone.square(),
    );
  }
}
/// A widget that shows an error message when the image fails to load.
class _CoverError extends StatelessWidget {
  const _CoverError(this.error);
  final String error;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Assets.shared.noCoverAvailable.provider(),
          fit: BoxFit.contain,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(error, style: context.textTheme.bodyLarge),
        ),
      ),
    );
  }
}

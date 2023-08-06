import 'package:flutter/material.dart';
import 'package:twitterclone/widgets/custom_shimmer.dart';

class CustomPostContainerShimmer extends StatelessWidget {
  const CustomPostContainerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
            left: 16.0, right: 8.0, top: 16.0, bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.08),
            radius: 24.0,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                showShimmer(context: context, height: 16.0, width: MediaQuery.of(context).size.width * 0.5),
                const SizedBox(height: 12.0),
                showShimmer(context: context, height: 16.0, width: MediaQuery.of(context).size.width * 0.7),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

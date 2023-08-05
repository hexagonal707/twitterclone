import 'package:flutter/material.dart';
import 'package:twitterclone/widgets/custom_shimmer.dart';

class CustomPostContainerShimmer extends StatelessWidget {
  const CustomPostContainerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          color: Colors.white.withOpacity(0.03),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.08),
                radius: 24,
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    showShimmer(context: context, height: 12.0, width: double.infinity),
                    const SizedBox(height: 8.0),
                    showShimmer(context: context, height: 12.0, width: double.infinity),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

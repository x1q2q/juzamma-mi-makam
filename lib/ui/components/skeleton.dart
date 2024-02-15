import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/ui_helper.dart';

enum KategoriFilter { artikel, pengumuman, jadwal }

class Skeleton {
  static Widget shimmerListSurah = Shimmer.fromColors(
      baseColor: lightgreenv2,
      highlightColor: Colors.orange.shade100,
      child: ListView.builder(
          itemCount: 8,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            return Container(
              width: double.infinity,
              height: 70,
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: ShapeDecoration(
                  color: Colors.grey[500]!,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)))),
            );
          }));
}

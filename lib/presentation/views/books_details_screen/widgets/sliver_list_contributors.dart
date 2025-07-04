import 'package:flutter/material.dart';

import '../../../../domain/entities/contributor_entity.dart';
import 'contributor_chip.dart';
import 'section_title.dart';

class SliverListContributors extends StatelessWidget {
  const SliverListContributors({super.key, required this.contributors, required this.sectionTitle});
  final List<Contributor> contributors;
  final String sectionTitle;
  @override
  Widget build(BuildContext context) {
   return SliverToBoxAdapter(
     child: Builder(builder: (context){
       if(contributors.isEmpty) return const SizedBox.shrink();
       return Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           SectionTitle(sectionTitle: sectionTitle),
           Padding(
             padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 14.0),
             child: Wrap(
               spacing: 8.0,
               runSpacing: 8.0,
               alignment: WrapAlignment.start,
               children: contributors.map((contributor)=>ContributorChip(contributor: contributor)).toList(),
             ),
           ),
         ],
       );
     }),
   );
  }
}

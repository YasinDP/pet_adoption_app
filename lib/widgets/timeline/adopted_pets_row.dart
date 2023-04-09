// import 'package:flutter/material.dart';
// import 'package:pet_adoption_app/functions.dart';
// import 'package:pet_adoption_app/highlight_data.dart';
// import 'package:pet_adoption_app/styles.dart';
// import 'package:pet_adoption_app/widgets/timeline/_timeline_section.dart';
// 

// class AdoptedPetsRow extends StatelessWidget {
//   AdoptedPetsRow({Key? key}) : super(key: key);

//   DateTime get startYr => lastYear();
//   DateTime get endYr => currentMonth();

//   late final List<DateTime> _totalMonths = getMonthsBetween(
//     startDate: startYr,
//     endDate: endYr,
//   );

//   int get startMonthPosition => 0;
//   int get endMonthPosition => _totalMonths.length - 1;

//   int get totalMonthCount => _totalMonths.length;

//   /// Normalizes a given month to a value from 0 - 1, based on start and end month.
//   double _calculateOffsetY(int index) =>
//       (index - startMonthPosition) / totalMonthCount;

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (_, constraints) {
//       // int interval = 1;
//       // if (constraints.maxHeight < 800) {
//       //   interval = 500;
//       // } else if (constraints.maxHeight < 1500) {
//       //   interval = 250;
//       // }

//       return AnimatedSwitcher(
//         duration: AppStyle().times.med,
//         child: Stack(
//           // key: ValueKey(interval),
//           children: TimelineEvent.all.asMap().entries.map((item) {
//             return AdoptedPet(
//               Pet.all.first,
//               _calculateOffsetY(
//                 item.key,
//               ),
//             );
//           }).toList(),
//         ),
//       );
//     });
//   }
// }

// class AdoptedPet extends StatefulWidget {
//   const AdoptedPet(
//     this.pet,
//     this.offset, {
//     Key? key,
//   }) : super(key: key);
//   final Pet pet;
//   final double offset;

//   @override
//   State<AdoptedPet> createState() => _AdoptedPetState();
// }

// class _AdoptedPetState extends State<AdoptedPet> {
//   @override
//   Widget build(BuildContext context) {
//     final gap = AppStyle().insets.xs;
//     return Align(
//       alignment: Alignment(0, -1 + widget.offset * 2),

//       // Use an OverflowBox wrapped in a zero-height sized box so that al
//       // This allows alignment-based positioning to be accurate even at the edges of the parent.
//       child: SizedBox(
//         height: 0,
//         child: OverflowBox(
//           alignment: Alignment.topCenter,
//           maxHeight: 100,
//           // maxWidth: 80,
//           child: FractionalTranslation(
//             translation: const Offset(0, -.5),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     itemCount: 7,
//                     physics: const AlwaysScrollableScrollPhysics(),
//                     itemBuilder: (context, index) => Container(
//                       height: 100,
//                       width: 80,
//                       margin: EdgeInsets.only(right: gap),
//                       child: TimelineSection(
//                         widget.pet,
//                         // isSelected: false,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

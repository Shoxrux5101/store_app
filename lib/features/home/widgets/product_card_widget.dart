// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../data/models/product_model.dart';
// import '../managers/product_cubit.dart';
//
// class ProductCard extends StatelessWidget {
//   final ProductModel product;
//
//   const ProductCard({
//     Key? key,
//     required this.product,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final hasDiscount = product.discount > 0;
//     final discountedPrice = hasDiscount
//         ? product.price * (1 - product.discount / 100)
//         : product.price;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           child: Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.network(
//                   product.image,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) {
//                     return Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: Colors.grey[200],
//                       ),
//                       child: const Icon(
//                         Icons.image_not_supported,
//                         color: Colors.grey,
//                         size: 40,
//                       ),
//                     );
//                   },
//                   loadingBuilder: (context, child, loadingProgress) {
//                     if (loadingProgress == null) return child;
//                     return Container(
//                       color: Colors.grey[200],
//                       child: const Center(
//                         child: CupertinoActivityIndicator(),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Positioned(
//                 top: 12,
//                 right: 12,
//                 child: GestureDetector(
//                   onTap: () {
//                     context.read<ProductCubit>().toggleLike(product.id);
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Icon(
//                       product.isLiked
//                           ? Icons.favorite
//                           : Icons.favorite_border,
//                       color: product.isLiked ? Colors.red : Colors.grey,
//                       size: 16,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 8,),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               product.title,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 4),
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     '\$${product.price.toStringAsFixed(0)}',
//                     style: const TextStyle(
//                       color: Colors.grey,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 if (hasDiscount)
//                   Text(
//                     '\$${discountedPrice.toStringAsFixed(0)}',
//                     style: const TextStyle(
//                       color: Colors.red,
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                     textAlign: TextAlign.end,
//                   ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

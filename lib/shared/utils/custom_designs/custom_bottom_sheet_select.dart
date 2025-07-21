
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';


import '../../../core/theme/customText.dart';
import '../../../core/theme/custom_colors.dart';
import 'custom_margins.dart';



final getIt = GetIt.instance;

class CustomBottomSheetSelect extends ConsumerWidget {
  CustomBottomSheetSelect({
    super.key,
    required this.items,
    required this.labelText,
    required this.isEnableOutLineBoarder,
    required this.value,
    required this.onChanged,
    this.fontFamily,
    this.title,
    this.subTitle,
    this.customWidget
  });

  final List<Widget> items;
  final String labelText;
  final ValueChanged<Widget?> onChanged;
  final bool isEnableOutLineBoarder;
  final String? value;
  final String? fontFamily;
  final String? title;
  final String? subTitle;
  final Widget? customWidget;

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
     /*     Text(
            labelText,
            style: CustomTextStyle.textStyleManrope.copyWith(
                color: CustomColors.coolGray700,
                fontSize:14.h,
                fontWeight: FontWeight.w600
              // height: 1.8

            ),
          ),
          const SizedBox(height: 5),*/
          InkWell(
            onTap: () => _showBottomSheet(context),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 65,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(0),
                color: CustomColors.coolGray100,
                border: Border(bottom: BorderSide(
                  color: CustomColors.coolGray200
                ))
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 11.5, horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customWidget??SizedBox.shrink(),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: RotatedBox(
                          quarterTurns: 3,
                          child: const Icon(Icons.arrow_back_ios_new, size: 20, color: CustomColors.coolGray500,)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: CustomColors.backgroundColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
          /*  const SizedBox(height: 20),
            Center(
              child: Container(
                height: 3,
                width: 100,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
              ),
            ),*/
            const YMargin(30),
            Row(
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null)
                        Text(
                          title!,
                          style:CustomTextStyle.textStyleManrope.copyWith(
                              color: CustomColors.coolGray700,
                              fontSize:16.h,
                              fontWeight: FontWeight.w600
                            // height: 1.8

                          ),
                        ),
                      if (subTitle != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            subTitle!,
                            style: CustomTextStyle.textStyleManrope.copyWith(
                                color: CustomColors.coolGray700,
                                fontSize:14.h,
                                fontWeight: FontWeight.w600
                              // height: 1.8

                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Color(0xFF111217), size: 20),
                ),

              ],
            ),
            const SizedBox(height: 20),
            ListView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = items[index];
                return InkWell(
                  onTap: () {
                    onChanged(item);
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      child: item,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}










/*class BottomSheetSelect extends GetView<AuthenticationController> {
   BottomSheetSelect({super.key, required this.items, required this.labelText, required this.isEnableOutLineBoarder,
    required this.value, required this.onChanged, this.fontFamily, this.title, this.subTitle  });

  final List<String> items;
  final String labelText;
  final  ValueChanged<String?> onChanged;
  final bool isEnableOutLineBoarder;
  String? value;
  String? selectedValu;
  String? fontFamily;
  String? title;
  String? subTitle;

   final FocusNode _focusNode = FocusNode();
   bool _focused = false;

  @override
  Widget build(BuildContext context) {
       return SafeArea(child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(labelText,
               style: interRegular(
                   fontWeight: FontWeight.w500,
                   fontSize: 14,
                   fontColor: Color(0xFF6A6C6E),

                 lineHeight: 1.5,)),
           SizedBox(height: 5,),
           InkWell(
             onTap: (){
               bottomItems(context);
               _focused = true;
             },
             child: AnimatedContainer(
               duration: Duration(milliseconds: 300),
               height: 45,

               width: MediaQuery.sizeOf(context).width,
               padding: EdgeInsets.symmetric(
                   horizontal: _focused ? 0.5 : 0, vertical: _focused ? 0.5 : 0),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10),
                 color: _focused
                     ? CustomColors().appPrimaryColor500 // Shadow color when focused
                     : Colors.white,
                 border: Border.all(color: _focused? CustomColors().appPrimaryColor300:  Color(0xffC4C4C4))

               ),
                 child: Padding(
                   padding: const EdgeInsets.symmetric(vertical: 11.5, horizontal: 10),
                   child: Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(value??"Select",
                      
                       textAlign: TextAlign.justify,
                         style: interRegular(

                           fontSize: 16,
                           fontWeight: FontWeight.w500
                         ),
                       ),
                       Spacer(),
                       Icon(Icons.arrow_drop_down_outlined)
                     ],
                   ),
                 ),
                 ),
           ),
         ],
       ));
  }


   Future bottomItems(BuildContext context) {
     return Get.bottomSheet(

         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 16),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisSize: MainAxisSize.min,
             children: [
               SizedBox(
                 height: 20,
               ),
               Center(
                 child: InkWell(
                   onTap: () => Get.back(),
                   child: Container(
                     height: 3,
                     width: 100,
                     decoration: const BoxDecoration(
                         color: Colors.grey,
                         borderRadius: BorderRadius.all(Radius.circular(2))),
                   ),
                 ),
               ),
               SizedBox(
                 height: 20,
               ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: ()=>Get.back(),
                      child: Icon(Icons.close, color: Color(0xFF111217), size: 20,)),
                SizedBox(width: 16,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    title !=null? Text(title??"",
                      style: interRegular(
                          fontColor: Color(0xFF111217),
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      ),):SizedBox.shrink(),
                    SizedBox(height: 5,),
                    subTitle!=null? Text(subTitle??"",
                        style: interRegular(
                            fontColor: Color(0xFF666F89),
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                        )):SizedBox.shrink(),
                  ],),
                ),

              ],),
               SizedBox(
                 height: 20,
               ),
               ListView.builder(
                   itemCount: items.length ,
                   shrinkWrap: true,

                   itemBuilder: ( context ,index){
                     return InkWell(
                       onTap: (){
                         onChanged(items[index]);
                         // controller.valueSelected.value = items[index];
                         Get.back();
                       },
                       child:  Container(
                         margin: EdgeInsets.only(top: 10),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),

                           boxShadow: [
                             BoxShadow(
                               color: Colors.grey.withOpacity(0.2),
                               spreadRadius: 1,
                               blurRadius: 2,
                             ),

                           ],
                           color:Colors.white ,

                         ),
                         child: Padding(
                           padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                           child: Text(items[index],
                             style: interRegular(
                                 fontFamily: fontFamily??"Urbanist",
                                 fontSize: 16,
                                 fontWeight: FontWeight.w500,
                                 fontColor: CustomColors().textPrimaryColor
                             ),),
                         ),
                       ),
                     );
                   }),
              *//* Expanded(
                 child: ,
               ),*//*

               SizedBox(
                 height: 10,
               ),

             ],
           ),
         ),
         backgroundColor:CustomColors().backgroundColor,
         elevation: 0,
         isScrollControlled: true,
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.only(
               topLeft: Radius.circular(20), topRight: Radius.circular(20)),
         ));
   }
}*/

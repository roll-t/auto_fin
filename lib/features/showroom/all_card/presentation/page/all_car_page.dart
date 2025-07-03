import 'package:auto_fin/core/config/const/app_icons.dart';
import 'package:auto_fin/core/config/theme/app_colors.dart';
import 'package:auto_fin/core/config/theme/app_theme_colors.dart';
import 'package:auto_fin/core/ui/widgets/inputs/custom_text_field.dart';
import 'package:auto_fin/core/ui/widgets/standard_layout_widget.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_span_widget.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_fin/core/utils/utils.dart';
import 'package:auto_fin/features/showroom/all_card/presentation/controller/all_car_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCarPage extends GetView<AllCarController> {
  static String routeName = "/AllCarPage";
  const AllCarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const StandardLayoutWidget(
      padding: EdgeInsets.only(top: 20),
      titleAppBar: "Toàn bộ xe",

      ///---> [Build-body]
      bodyBuilder: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SearchCardWidget(),
                SizedBox(height: 12),
                FilterBarWidget(),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          ListCarWidget()
        ],
      ),
    );
  }
}

class ListCarWidget extends StatelessWidget {
  const ListCarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(1, 1),
                  blurRadius: 4,
                  spreadRadius: 2,
                  color: AppColors.darkest1.withValues(
                    alpha: .1,
                  ),
                ),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(
                    text: "Tên xe mới",
                    fontWeight: FontWeight.bold,
                  ),
                  Utils.iconSvg(
                    svgUrl: AppIcons.icArrowRight,
                    size: 20,
                  )
                ],
              ),
              const SizedBox(height: 6.0),
              const TextSpanWidget(
                textColor1: AppColors.neutralColor2,
                textColor2: AppColors.darker1,
                fontWeight2: FontWeight.w500,
                text1: 'Trạng thái: ',
                text2: 'Đang ở Auto',
                size: 12,
              ),
              const SizedBox(height: 6.0),
              const TextSpanWidget(
                textColor1: AppColors.neutralColor2,
                textColor2: AppColors.darker1,
                fontWeight2: FontWeight.w500,
                text1: 'Ngày Nhập: ',
                text2: '11/02/2002',
                size: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterBarWidget extends StatelessWidget {
  const FilterBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2,
                  color: AppColors.white,
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const TextWidget(
                      text: "Tất cả",
                      color: AppColors.white,
                    ),
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Utils.iconSvg(svgUrl: AppIcons.icArrowDropDown),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const TextWidget(
                    text: "Mới nhất",
                    color: AppColors.white,
                  ),
                  const SizedBox(width: 10),
                  Utils.iconSvg(
                    svgUrl: AppIcons.icFilter,
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SearchCardWidget extends StatelessWidget {
  const SearchCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      prefixIcon: Padding(
        padding: const EdgeInsetsGeometry.all(10),
        child: Utils.iconSvg(
          svgUrl: AppIcons.icSearch,
        ),
      ),
      backgroundColor: AppColors.white,
      hintText: "Nhập tên xe tìm kiếm....",
      borderRadius: 10,
      borderColor: AppThemeColors.lightest,
      borderWidth: 1,
    );
  }
}

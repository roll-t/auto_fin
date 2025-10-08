import 'package:auto_find/core/config/const/app_text_styles.dart';
import 'package:auto_find/core/config/theme/app_colors.dart';
import 'package:auto_find/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_find/core/ui/widgets/wrap_body_widget.dart';
import 'package:auto_find/main/pawn_shop/data/model/row_table_data_model.dart';
import 'package:flutter/material.dart';

class InfoTable extends StatelessWidget {
  final List<RowTableDataModel> rows;

  const InfoTable({super.key, required this.rows});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WrapBodyWidget(
          header: _buildHeaderRow(),
          child: Column(
            children: rows.map((e) => _buildDataRow(e)).toList(),
          ),
        ),
      ],
    );
  }

  /// ==== Header ====
  Widget _buildHeaderRow() {
    return const Row(
      children: [
        Expanded(child: SizedBox.shrink()),
        Expanded(
          child: TextWidget(
            text: "Số HP đang vay",
            textStyle: AppTextStyle.medium14,
          ),
        ),
        Expanded(
          child: TextWidget(
            text: "Tổng số",
            textAlign: TextAlign.center,
            textStyle: AppTextStyle.medium14,
          ),
        ),
      ],
    );
  }

  /// ==== Mỗi dòng dữ liệu ====
  Widget _buildDataRow(RowTableDataModel data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: TextWidget(
              text: data.type,
              textAlign: TextAlign.start,
              textStyle: AppTextStyle.regular14,
            ),
          ),
          Expanded(
            child: TextWidget(
              text: data.count.toString(),
              textAlign: TextAlign.center,
              textStyle: AppTextStyle.semiBold14,
              color: AppColors.accent,
            ),
          ),
          Expanded(
            child: TextWidget(
              text: data.total.toString(),
              textAlign: TextAlign.center,
              textStyle: AppTextStyle.regular14,
            ),
          ),
        ],
      ),
    );
  }
}

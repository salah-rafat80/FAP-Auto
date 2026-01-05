import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fap/core/utils/size_config.dart';
import 'package:fap/injection_container.dart';
import 'package:fap/features/price_list/presentation/cubit/price_list_cubit.dart';
import 'package:fap/features/price_list/presentation/cubit/price_list_state.dart';
import 'package:fap/features/price_list/presentation/widgets/monthly_report_card.dart';
import 'package:fap/features/price_list/presentation/widgets/price_list_title.dart';
import 'package:fap/features/price_list/presentation/widgets/price_list_error_view.dart';
import 'package:fap/features/price_list/presentation/widgets/price_list_bottom_notice.dart';

class PriceListScreen extends StatelessWidget {
  const PriceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return BlocProvider(
      create: (context) => sl<PriceListCubit>(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 15),
                const PriceListTitle(),
                // List of monthly reports
                Expanded(
                  child: BlocBuilder<PriceListCubit, PriceListState>(
                    builder: (context, state) {
                      if (state is PriceListLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is PriceListError) {
                        return PriceListErrorView(
                          message: state.message,
                          onRetry: () =>
                              context.read<PriceListCubit>().loadCategories(),
                        );
                      } else if (state is PriceListLoaded) {
                        return ListView.separated(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.w(4),
                            vertical: SizeConfig.h(1),
                          ),
                          itemCount: state.categories.length,
                          separatorBuilder: (_, __) =>
                              SizedBox(height: SizeConfig.h(2)),
                          itemBuilder: (context, index) {
                            final category = state.categories[index];
                            return MonthlyReportCard(category: category);
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                const PriceListBottomNotice(),
                SizedBox(height:
                SizeConfig.h(2)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtime/Controllers/blocs/client/companiesListBloc.dart/companieslist_bloc.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/utils/custom_snackbar.dart';
import 'package:techtime/Models/client/category.dart';

import 'components/companies_list_view.dart';

class CategoryCompaniesScreen extends StatefulWidget {
  final Category? category;

  const CategoryCompaniesScreen({Key? key, this.category}) : super(key: key);

  @override
  _CategoryCompaniesScreenState createState() =>
      _CategoryCompaniesScreenState();
}

class _CategoryCompaniesScreenState extends State<CategoryCompaniesScreen> {
  @override
  void initState() {
    BlocProvider.of<CompanieslistBloc>(context)
        .add(GetCompaniesList(widget.category!.categoryId!));
    super.initState();
  }

  final Snackbar _snackbar = Snackbar();
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      appBar: buildAppBar(context),
      body: BlocConsumer<CompanieslistBloc, CompanieslistState>(
        listener: (context, state) {
          if (state is CompanieslistError) {
            _snackbar.showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is CompanieslistFinished) {
            if (state.companies.isNotEmpty) {
              return CompaniesListView(companies: state.companies);
            } else {
              return Center(
                child: SvgPicture.asset(
                  comingSoonIcon,
                  height: 150,
                  color: _theme.accentColor,
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
            // return ShimmerEffect(
            //   child: Column(
            //     children: [
            //       SizedBox(
            //         height: MediaQuery.of(context).size.height,
            //         child: ListView.separated(
            //             itemCount: 10,
            //             shrinkWrap: true,
            //             scrollDirection: Axis.vertical,
            //             physics: BouncingScrollPhysics(),
            //             separatorBuilder: (_, i) => VerticalGap(),
            //             itemBuilder: (ctx, i) => Container(
            //                   height: MediaQuery.of(context).size.height * 0.33,
            //                   width: MediaQuery.of(context).size.width,
            //                   color: Colors.white,
            //                 )),
            //       ),
            //     ],
            //   ),
            // );
          }
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        widget.category!.categoryEn!,
        style: const TextStyle(color: Colors.black),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      excludeHeaderSemantics: true,
    );
  }
}

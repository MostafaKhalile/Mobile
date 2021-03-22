import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techtime/Controllers/blocs/client/companies_list_bloc.dart/companieslist_bloc.dart';
import 'package:techtime/Helpers/utils/custom_snackbar.dart';
import 'package:techtime/models/client/category.dart';

import 'components/companies_list_view.dart';

class CategoryCompaniesScreen extends StatefulWidget {
  final Category category;

  const CategoryCompaniesScreen({Key key, this.category}) : super(key: key);

  @override
  _CategoryCompaniesScreenState createState() =>
      _CategoryCompaniesScreenState();
}

class _CategoryCompaniesScreenState extends State<CategoryCompaniesScreen> {
  @override
  void initState() {
    BlocProvider.of<CompanieslistBloc>(context)
        .add(GetCompaniesList(widget.category.categoryId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Snackbar _snackbar = Snackbar();
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
                  child: Text(
                "No Data Yet",
                style: Theme.of(context).textTheme.caption,
              ));
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        widget.category.categoryEn,
        style: TextStyle(color: Colors.black),
      ),
      automaticallyImplyLeading: false,
      // leading: Container(),
      excludeHeaderSemantics: true,
    );
  }
}

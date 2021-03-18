import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techtime/Controllers/blocs/client/companies_list_bloc.dart/companieslist_bloc.dart';
import 'package:techtime/models/client/category.dart';

import 'components/companies_list_view.dart';

class CompaniesListScreen extends StatefulWidget {
  final Category category;

  const CompaniesListScreen({Key key, this.category}) : super(key: key);

  @override
  _CompaniesListScreenState createState() => _CompaniesListScreenState();
}

class _CompaniesListScreenState extends State<CompaniesListScreen> {
  @override
  void initState() {
    BlocProvider.of<CompanieslistBloc>(context)
        .add(GetCompaniesList(widget.category.categoryId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: BlocBuilder<CompanieslistBloc, CompanieslistState>(
        builder: (context, state) {
          if (state is CompanieslistFinished) {
            return CompaniesListView(companies: state.companies);
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:newshop_app/models/favorites_model.dart';
import 'package:newshop_app/modules/favorites/components/favorite_item.dart';
import 'package:newshop_app/shared/components/constants.dart';
import 'package:newshop_app/shared/components/outline_textfield_border.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (BuildContext context, SearchStates state) {},
        builder: (BuildContext context, SearchStates state) {
          var cubit = SearchCubit.getSearchCubit(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    OutlineTextfieldBorder(
                      controller: searchController,
                      textInputType: TextInputType.text,
                      labelText: 'Search',
                      prefixIcon: Icons.search,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter search text';
                        }
                      },
                      onFieldSubmit: (text) {
                        cubit.search(text!);
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => FavoriteItem(
                                isOldPrice: false,
                                product: cubit.searchModel!.data.data[index]),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount:
                                cubit.searchModel?.data.data.length ?? 0),
                      )
                  ],
                ),
              ),
            ),
          );
          // return Conditional.single(
          //   context: context,
          //   conditionBuilder: (context) => state is! SearchLoadingState,
          //   widgetBuilder: (context) => Form(
          //     key: formKey,
          //     child: Padding(
          //       padding: const EdgeInsets.all(20),
          //       child: Column(
          //         children: [
          //           OutlineTextfieldBorder(
          //             controller: searchController,
          //             textInputType: TextInputType.text,
          //             labelText: 'Search',
          //             prefixIcon: Icons.search,
          //             validate: (value) {
          //               if (value!.isEmpty) {
          //                 return 'Please enter search text';
          //               }
          //             },
          //             onFieldSubmit: (text) {
          //               cubit.search(text ?? '');
          //             },
          //           ),
          //           SizedBox(
          //             height: 20,
          //           ),
          //           if (state is SearchSuccessState)
          //             Expanded(
          //               child: ListView.separated(
          //                   itemBuilder: (context, index) => FavoriteItem(
          //                       isOldPrice: false,
          //                       product: cubit.searchModel!.data.data[index]),
          //                   separatorBuilder: (context, index) => myDivider(),
          //                   itemCount: cubit.searchModel?.data.data.length ?? 0),
          //             )
          //         ],
          //       ),
          //     ),
          //   ),
          //   fallbackBuilder: (context) =>
          //       const Center(child: CircularProgressIndicator()),
          // );
        },
      ),
    );
  }
}

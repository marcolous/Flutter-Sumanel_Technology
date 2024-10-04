import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sumanel_technology/core/utils/no_bounce_scroll_behavior.dart';
import 'package:sumanel_technology/core/utils/show_snack_bar.dart';
import 'package:sumanel_technology/core/utils/styles.dart';
import 'package:sumanel_technology/core/widgets/custom_back_button.dart';
import 'package:sumanel_technology/data/model/user_model/user_model.dart';
import 'package:sumanel_technology/features/home/presentation/manager/user_cubit/user_cubit.dart';
import 'package:sumanel_technology/features/home/presentation/manager/user_cubit/user_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..fetchUserDetails(),
      child: Scaffold(
        body: SafeArea(
          child: ScrollConfiguration(
            behavior: NoBounceScrollBehavior(),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              children: const [
                CustomBackButton(),
                Gap(28),
                UsersListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UsersListView extends StatelessWidget {
  const UsersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserFailure) {
          ShowSnackBar.show(context, state.errMessage);
          log('fail');
        }
      },
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is UserSuccess) {
          List<User> users = state.user;
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: users.length,
            separatorBuilder: (context, index) => const Gap(5),
            itemBuilder: (context, index) => UserDetails(user: users[index]),
          );
        }
        return const Text('Something Went Wrong');
      },
    );
  }
}

class UserDetails extends StatelessWidget {
  const UserDetails({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Gap(20),
        CircleAvatar(
          radius: 60,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(user.avatar)),
        ),
        const Gap(70),
        Text(
          user.firstName,
          style: Styles.style30Bold(context),
        )
      ],
    );
  }
}

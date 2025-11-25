import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:graduation_project/features/profile/presentation/widgets/custom_text_field.dart';
import 'package:graduation_project/features/profile/presentation/widgets/segmented_progress_bar.dart';

class BasicInfoPage extends StatelessWidget {
  BasicInfoPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),

      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: [
            SegmentedProgressBar(progress: 0.25),
            SizedBox(height: 20.h),
            Text(
              "Let's start with the\n Basics",
              style: TextStyle(fontSize: 32.r, fontWeight: .bold),
            ),
            Text(
              "This information will be visiable to recruiters.",
              style: TextStyle(fontSize: 16.r, color: Color(0xff7b8594)),
            ),
            SizedBox(height: 20.h),

            Row(
              crossAxisAlignment: .center,
              children: [
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        context.read<ProfileCubit>().pickImage();
                        print(state.toString());
                      },
                      borderRadius: BorderRadius.circular(50),
                      child: state.image == null
                          ? DottedBorder(
                              options: CircularDottedBorderOptions(
                                dashPattern: [5, 5],
                                strokeWidth: 2,
                                color: Color(0xffccd6e1),
                              ),
                              child: Container(
                                width: 70.w,
                                height: 70.h,

                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xfff1f5f9),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    colorFilter: ColorFilter.mode(
                                      Color(0xff67768d),
                                      .srcIn,
                                    ),
                                    "assets/icons/camera_add.svg",
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              width: 70.w,
                              height: 70.h,

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xfff1f5f9),
                              ),
                              child: ClipOval(
                                child: Image.file(state.image!, fit: .fill),
                              ),
                            ),
                    );
                  },
                ),
                SizedBox(width: 25.w),
                Column(
                  children: [
                    Text(
                      "Upload Photo",
                      style: TextStyle(fontSize: 18.r, fontWeight: .bold),
                    ),
                    Text(
                      "Max file size: 5MB",
                      style: TextStyle(
                        fontSize: 14.r,
                        color: Color(0xff7b8594),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            CustomTextField(
              controller: nameController,
              title: "Full Name",
              hint: "Enter your full name",
            ),
            CustomTextField(
              controller: locationController,
              title: "Location",
              hint: "e.g., Riyadh, SA",
            ),
            CustomTextField(
              controller: emailController,
              title: "Email Address",
              hint: "Enter your email",
            ),
            CustomTextField(
              controller: phoneController,
              title: "Phone Number",
              hint: "(123) 456-7890",
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(1.sw, 60.h),
                backgroundColor: Color(0xff135bec),
              ),
              onPressed: () => context.read<ProfileCubit>().nextPage(),
              child: Text(
                "Continue to Experience",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

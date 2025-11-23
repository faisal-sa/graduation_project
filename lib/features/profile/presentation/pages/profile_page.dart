import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:graduation_project/features/profile/presentation/widgets/custom_text_field.dart';
import 'package:graduation_project/features/profile/presentation/widgets/segmented_progress_bar.dart';

class ProfilePage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text("Make your Profile"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: .all(16),
            child: PageView(
              reverse: false,
              physics: NeverScrollableScrollPhysics(),

              controller: context.read<ProfileCubit>().pageController,
              children: [
                FirstPage(
                  nameController: nameController,
                  locationController: locationController,
                  emailController: emailController,
                  phoneController: phoneController,
                ),
                SecondPage(),
                ThirdPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({
    super.key,
    required this.nameController,
    required this.locationController,
    required this.emailController,
    required this.phoneController,
  });

  final TextEditingController nameController;
  final TextEditingController locationController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

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

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),

      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: [
            SegmentedProgressBar(progress: 0.5),
            SizedBox(height: 20.h),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBEafe),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFFBFDBFE)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: const BoxDecoration(
                              color: Color(0xff135bec),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.videocam,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Stand Out to Employers",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                "Record a 30-second video intro.",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Color(0xff4d5765),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      SizedBox(
                        width: double.infinity,
                        height: 40.h,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff135bec),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: const Text(
                            "Add a Video Intro",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  "Work Experience",
                  style: TextStyle(fontSize: 24.r, fontWeight: .bold),
                ),

                CircleAvatar(
                  backgroundColor: Color(0xffe5e7eb),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add, color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: Radius.circular(12.r),
                color: Color(0xffd1d5db),
                dashPattern: [10, 7],
                strokeWidth: 2,
                strokeCap: .round,
              ),
              child: SizedBox(
                width: 1.sw,
                height: 200.h,
                child: Center(
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        "Your work experiences are displayed here",
                        style: TextStyle(fontWeight: .w500),
                      ),
                      Text("add your past roles to show your expertise"),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  "Education",
                  style: TextStyle(fontSize: 24.r, fontWeight: .bold),
                ),

                CircleAvatar(
                  backgroundColor: Color(0xffe5e7eb),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add, color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: Radius.circular(12.r),
                color: Color(0xffd1d5db),
                dashPattern: [10, 7],
                strokeWidth: 2,
                strokeCap: .round,
              ),
              child: SizedBox(
                width: 1.sw,
                height: 200.h,
                child: Center(
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        "No Education Added",
                        style: TextStyle(fontWeight: .w500),
                      ),
                      Text("add your degrees and certifications"),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 32.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(1.sw, 60.h),
                backgroundColor: Color(0xff135bec),
              ),
              onPressed: () => context.read<ProfileCubit>().nextPage(),
              child: Text(
                "Continue to Introduction",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () => context.read<ProfileCubit>().previousPage(),

              child: Text("go back"),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),

      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: [
            SegmentedProgressBar(progress: 1),
            SizedBox(height: 20.h),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBEafe),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFFBFDBFE)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: const BoxDecoration(
                              color: Color(0xff135bec),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.videocam,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Stand Out to Employers",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                "Record a 30-second video intro.",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Color(0xff4d5765),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      SizedBox(
                        width: double.infinity,
                        height: 40.h,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff135bec),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: const Text(
                            "Add a Video Intro",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  "Work Experience",
                  style: TextStyle(fontSize: 24.r, fontWeight: .bold),
                ),

                CircleAvatar(
                  backgroundColor: Color(0xffe5e7eb),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add, color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: Radius.circular(12.r),
                color: Color(0xffd1d5db),
                dashPattern: [10, 7],
                strokeWidth: 2,
                strokeCap: .round,
              ),
              child: SizedBox(
                width: 1.sw,
                height: 200.h,
                child: Center(
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        "Your work experiences are displayed here",
                        style: TextStyle(fontWeight: .w500),
                      ),
                      Text("add your past roles to show your expertise"),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  "Education",
                  style: TextStyle(fontSize: 24.r, fontWeight: .bold),
                ),

                CircleAvatar(
                  backgroundColor: Color(0xffe5e7eb),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add, color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: Radius.circular(12.r),
                color: Color(0xffd1d5db),
                dashPattern: [10, 7],
                strokeWidth: 2,
                strokeCap: .round,
              ),
              child: SizedBox(
                width: 1.sw,
                height: 200.h,
                child: Center(
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        "No Education Added",
                        style: TextStyle(fontWeight: .w500),
                      ),
                      Text("add your degrees and certifications"),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 32.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(1.sw, 60.h),
                backgroundColor: Color(0xff135bec),
              ),
              onPressed: () => context.read<ProfileCubit>().nextPage(),
              child: Text(
                "Continue to Introduction",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () => context.read<ProfileCubit>().previousPage(),

              child: Text("go back"),
            ),
          ],
        ),
      ),
    );
  }
}

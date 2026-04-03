import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homefinder/core/ui/components/app_button.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/components/app_text_field.dart';
import 'package:homefinder/core/ui/components/layouts/app_scaffold.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/ui/extensions/app_theme_extension.dart';
import 'package:homefinder/core/variables/app_iconsize.dart';
import 'package:homefinder/core/variables/colors.dart';
import 'package:homefinder/features/profile/domain/profile_domain.dart';
import 'package:homefinder/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:homefinder/features/profile/presentation/bloc/profile_event.dart';
import 'package:homefinder/features/profile/presentation/bloc/profile_state.dart';
import 'package:homefinder/features/profile/presentation/widgets/build_stat.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UsersAccount extends StatefulWidget {
  const UsersAccount({super.key});

  static const String routeName = '/users-account';

  @override
  State<UsersAccount> createState() => _UsersAccountState();
}

class _UsersAccountState extends State<UsersAccount> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  UserProfile? _currentProfile;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _initializeControllers(UserProfile profile) {
    _fullNameController.text = profile.fullName;
    _emailController.text = profile.email;
    _phoneController.text = profile.phoneNumber;
    _locationController.text = profile.location ?? '';
    _currentProfile = profile;
  }

  File? _imageFile;

  // pick image
  Future<void> pickImage() async {
    //   picker
    final picker = ImagePicker();

    // pick from gallery
    final image = await picker.pickImage(source: ImageSource.gallery);

    //   update image preview
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  // upload image
  Future<void> uploadImage() async {
    if (_imageFile == null) return;

    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    //   generate a unique file path
    final fileName = '${user.id}_${DateTime.now().millisecondsSinceEpoch}';
    final filePath = 'profile/$fileName';

    try {
      //   upload image to supabase storage
      await Supabase.instance.client.storage
          // to this bucket
          .from('images')
          .upload(filePath, _imageFile!);

      // Get the public URL of the uploaded image
      final ImageUrl = Supabase.instance.client.storage
          .from('images')
          .getPublicUrl(filePath);

      if (mounted) {
        setState(() {
          _currentProfile = _currentProfile?.copyWith(
            avatarUrl: ImageUrl,
          );
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image uploaded successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error uploading image: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appbar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const AppText(
          'My Account',
        ),
        titleTextStyle: context.textTheme.headlineSmall?.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.kGrey80,
        ),
        centerTitle: false,
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded) {
            _initializeControllers(state.profile);
          } else if (state is ProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')),
            );
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading && _currentProfile == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileInitial || state is ProfileLoading) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (state is ProfileError) {
                      return Center(child: AppText(state.message));
                    }

                    if (state is ProfileLoaded) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: _imageFile != null
                                  ? FileImage(_imageFile!)
                                  : NetworkImage(
                                          _currentProfile?.avatarUrl ??
                                              'https://images.unsplash.com/photo-1763757321139-e7e4de128cd9?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzZ8fGhlYWRzaG90JTIwYmxhY2slMjBwZW9wbGV8ZW58MHx8MHx8fDA%3D',
                                        )
                                        as ImageProvider,
                              child: IconButton(
                                onPressed: () async {
                                  await pickImage();

                                  await uploadImage();
                                },
                                icon: const Icon(
                                  Icons.camera_alt_outlined,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            16.verticalSpacing,

                            AppText(
                              _currentProfile?.fullName ?? 'User',
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.kGrey80,
                              ),
                            ),
                            4.verticalSpacing,
                            buildStat(context),
                          ],
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
                32.verticalSpacing,
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextField(
                        controller: _fullNameController,
                        title: 'Full Name',
                        hintText: 'Enter your full name',
                        keyboardType: TextInputType.name,
                        prefixIcon: const Icon(
                          FontAwesomeIcons.user,
                          size: AppIconSize.regular,
                        ),
                      ),
                      16.verticalSpacing,
                      AppTextField(
                        controller: _emailController,
                        title: 'Email Address',
                        hintText: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(
                          FontAwesomeIcons.envelope,
                          size: AppIconSize.regular,
                        ),
                      ),
                      16.verticalSpacing,
                      AppTextField(
                        title: 'Password',
                        hintText: '*****************',
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: const Icon(
                          FontAwesomeIcons.lock,
                          size: AppIconSize.regular,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppText(
                                'Change',
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.kPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      16.verticalSpacing,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextField(
                            controller: _phoneController,
                            title: 'Phone Number',
                            hintText: '9000-000-000',
                            keyboardType: TextInputType.phone,
                            prefixIcon: const Icon(Icons.phone),
                          ),
                          8.verticalSpacing,
                          AppText(
                            'You won’t be able to call landlord if this is empty',
                            style: context.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.kGrey40,
                            ),
                          ),
                        ],
                      ),
                      16.verticalSpacing,
                      AppTextField(
                        controller: _locationController,
                        title: 'Location',
                        hintText: 'Lagos, Nigeria',
                        prefixIcon: const Icon(Icons.location_on),
                        suffixIcon: const Icon(Icons.map_outlined),
                      ),
                      32.verticalSpacing,
                      PrimaryButton(
                        'Save changes',
                        loading: state is ProfileLoading,
                        pressed: () {
                          if (_currentProfile != null) {
                            final updatedProfile = _currentProfile!.copyWith(
                              fullName: _fullNameController.text,
                              email: _emailController.text,
                              phoneNumber: _phoneController.text,
                              location: _locationController.text,
                            );
                            context.read<ProfileBloc>().add(
                              UpdateProfile(updatedProfile),
                            );
                          }
                        },
                      ),
                      24.verticalSpacing,
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

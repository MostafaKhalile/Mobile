import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:techtime/Controllers/BLoCs/client/profile_edit_blocs/edit_cover_bloc/editcover_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/profile_edit_blocs/edit_profile_picture_Bloc/editprofilepicture_bloc.dart';
import 'package:techtime/Controllers/Providers/current_user_provider.dart';
import 'package:techtime/Controllers/Services/image_picker_service.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/utils/custom_toast.dart';
import 'package:techtime/Models/client_profile.dart';
import 'package:techtime/Widgets/client/custom_circle_avatar.dart';

class ProfileCoverAndImage extends StatefulWidget {
  const ProfileCoverAndImage({
    Key key,
  }) : super(key: key);

  @override
  _ProfileCoverAndImageState createState() => _ProfileCoverAndImageState();
}

class _ProfileCoverAndImageState extends State<ProfileCoverAndImage> {
  final ImagePickerService _picker = ImagePickerService();
  // File _profilePicture;
  // ignore: unused_field
  bool _uploadingProfilePicture = false;
  // File _cover;
  // final bool _uploadingCover = false;
  final CustomToast _customToast = CustomToast();

  @override
  Widget build(BuildContext context) {
    final UserProfile userData =
        context.watch<CurrentUserProvider>().currentUser;
    final ThemeData _theme = Theme.of(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        BlocConsumer<EditcoverBloc, EditcoverState>(listener: (context, state) {
          if (state is EditCoverDone) {
            _customToast.buildSuccessMessage(context);
            Provider.of<CurrentUserProvider>(context, listen: false)
                .loadCurrentUser();
          }
          if (state is EditCoverFailure) {
            _customToast.buildErrorMessage(context, "حدث خطأ ما");
          }
        }, builder: (context, state) {
          state = state;
          return SizedBox(
            width: double.infinity,
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //   image: (_cover != null)
            //       ? FileImage(_cover)
            //       : userData?.coverImage != null
            //           ? NetworkImage(
            //               NetworkConstants.baseUrl + userData.coverImage,
            //             )
            //           : AssetImage(placeHolderCover),
            //   fit: BoxFit.cover,
            // )),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // (state is EditCoverUploading)
                //     ? Center(
                //         child: CircularProgressIndicator(),
                //       )
                //     : Container(),
                Positioned(
                  bottom: 10,
                  right: 0,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocConsumer<EditprofilepictureBloc,
                          EditprofilepictureState>(
                        listener: (context, state) {
                          if (state is EditprofilepictureDone) {
                            _customToast.buildSuccessMessage(context);
                            Provider.of<CurrentUserProvider>(context,
                                    listen: false)
                                .loadCurrentUser();
                          }
                          if (state is EditprofilepictureFailure) {
                            _customToast.buildErrorMessage(
                                context, "حدث خطأ ما");
                          }
                        },
                        builder: (context, state) {
                          state = state;
                          return Stack(children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                CustomCircleAvatar(
                                  image: userData?.image,
                                  height: 120,
                                  width: 120,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: -5,
                                  child: InkWell(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () => changeProfilePicture(),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            _theme.accentColor.withOpacity(0.5),
                                      ),
                                      height: 40,
                                      width: 40,
                                      child: Icon(
                                        Icons.camera_alt,
                                        size: 15,
                                        color: _theme.scaffoldBackgroundColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (state is EditprofilepictureUploading)
                              Center(
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  color: Colors.black26,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              )
                            else
                              Container(),
                          ]);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }),
        // Row(
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.only(top: 80, right: 10, left: 10),
        //       child: ClipOval(
        //         child: Material(
        //             color: Colors.black26, // button color
        //             child: InkWell(
        //                 child: SizedBox(
        //                     width: 56,
        //                     height: 56,
        //                     child: Icon(
        //                       Icons.camera_alt_outlined,
        //                       color: Colors.white,
        //                       size: 25,
        //                     )),
        //                 onTap: () => changeCoverPicture())),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }

  void changeProfilePicture() {
    _showPicker(context).then((image) async {
      if (image != null) {
        setState(() {
          _uploadingProfilePicture = true;
        });
        context.read<EditprofilepictureBloc>().add(ChangeProfilePicture(image));
      } else {
        _customToast.buildErrorMessage(context, "لم تقم بإختار صورة");
        setState(() {
          _uploadingProfilePicture = false;
        });
      }
    });
  }

  // changeCoverPicture() {
  //   _showPicker(context).then((image) async {
  //     if (image != null) {
  //       setState(() {
  //         _uploadingCover = true;
  //       });
  //       context.read<EditcoverBloc>().add(ChangeCover(image));
  //     } else {
  //       _customToast.buildErrorMessage(context, "لم تقم بإختار صورة");
  //       setState(() {
  //         _uploadingCover = false;
  //       });
  //     }
  //   });
  // }

  Future<File> _imgFromCamera() async {
    final File image = await _picker.imgFromCamera();
    return image;
  }

  Future<File> _imgFromGallery() async {
    final File image = await _picker.imgFromGallery();
    return image;
  }

  Future<File> _showPicker(BuildContext context) {
    return showModalBottomSheet<File>(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: SizedBox(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: Text(AppLocalizations.of(context)
                          .translate("photo_gallery")),
                      onTap: () async {
                        final File image = await _imgFromGallery();
                        Navigator.pop(context, image);
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title:
                        Text(AppLocalizations.of(context).translate("camera")),
                    onTap: () async {
                      final File image = await _imgFromCamera();
                      Navigator.pop(context, image);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}

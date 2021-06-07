import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:techtime/Controllers/BLoCs/client/leastCompaniesBloc/leastcompanies_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/profile_edit_blocs/edit_cover_bloc/editcover_bloc.dart';
import 'package:techtime/Controllers/BLoCs/client/profile_edit_blocs/edit_profile_picture_Bloc/editprofilepicture_bloc.dart';
import 'package:techtime/Controllers/Providers/current_user_provider.dart';
import 'package:techtime/Controllers/Repositories/client/Account/repository.dart';
import 'package:techtime/Controllers/Services/image_picker_service.dart';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Helpers/utils/custom_toast.dart';
import 'package:techtime/Models/client_profile.dart';

class ProfileCoverAndImage extends StatefulWidget {
  const ProfileCoverAndImage({
    Key key,
  }) : super(key: key);

  @override
  _ProfileCoverAndImageState createState() => _ProfileCoverAndImageState();
}

class _ProfileCoverAndImageState extends State<ProfileCoverAndImage> {
  final ImagePickerService _picker = ImagePickerService();
  File _profilePicture;
  bool _uploadingProfilePicture = false;
  File _cover;
  bool _uploadingCover = false;
  CustomToast _customToast = CustomToast();

  @override
  Widget build(BuildContext context) {
    UserProfile userData = context.watch<CurrentUserProvider>().currentUser;

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
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: (_cover != null)
                  ? FileImage(_cover)
                  : userData?.coverImage != null
                      ? NetworkImage(
                          KAPIURL + userData.coverImage,
                        )
                      : AssetImage(KPlaceHolderCover),
              fit: BoxFit.cover,
            )),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                (state is EditCoverUploading)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(),
                Positioned(
                  bottom: -60,
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
                          return Stack(clipBehavior: Clip.none, children: [
                            InkWell(
                              child: Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: userData?.image != null
                                            ? NetworkImage(
                                                KAPIURL + userData.image,
                                              )
                                            : AssetImage(KPlaceHolderImage),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(KdefaultRadius),
                                      ))),
                              onTap: () => changeProfilePicture(),
                            ),
                            state is EditprofilepictureUploading
                                ? Center(
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      color: Colors.black26,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  )
                                : Container(),
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
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80, right: 10, left: 10),
              child: ClipOval(
                child: Material(
                    color: Colors.black26, // button color
                    child: InkWell(
                        child: SizedBox(
                            width: 56,
                            height: 56,
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 25,
                            )),
                        onTap: () => changeCoverPicture())),
              ),
            ),
          ],
        ),
      ],
    );
  }

  changeProfilePicture() {
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

  changeCoverPicture() {
    _showPicker(context).then((image) async {
      if (image != null) {
        setState(() {
          _uploadingCover = true;
        });
        context.read<EditcoverBloc>().add(ChangeCover(image));
      } else {
        _customToast.buildErrorMessage(context, "لم تقم بإختار صورة");
        setState(() {
          _uploadingCover = false;
        });
      }
    });
  }

  _imgFromCamera() async {
    File image = await _picker.imgFromCamera();
    return image;
  }

  _imgFromGallery() async {
    File image = await _picker.imgFromGallery();
    return image;
  }

  Future<File> _showPicker(context) {
    return showModalBottomSheet<File>(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text(AppLocalizations.of(context)
                          .translate("photo_gallery")),
                      onTap: () async {
                        File image = await _imgFromGallery();
                        Navigator.pop(context, image);
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text(
                        AppLocalizations.of(context).translate("camera")),
                    onTap: () async {
                      File image = await _imgFromCamera();
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

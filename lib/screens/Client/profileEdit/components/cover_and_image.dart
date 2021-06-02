import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techtime/Controllers/Services/image_picker_service.dart';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Models/client_profile.dart';

class ProfileCoverAndImage extends StatefulWidget {
  const ProfileCoverAndImage({
    Key key,
    @required this.userData,
  }) : super(key: key);
  final UserProfile userData;

  @override
  _ProfileCoverAndImageState createState() => _ProfileCoverAndImageState();
}

class _ProfileCoverAndImageState extends State<ProfileCoverAndImage> {
  final ImagePickerService _picker = ImagePickerService();
  File _profilePicture;
  File _cover;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: (_cover != null)
                ? FileImage(_cover)
                : widget.userData?.coverImage != null
                    ? NetworkImage(
                        KAPIURL + widget.userData.coverImage,
                      )
                    : AssetImage(KPlaceHolderCover),
            fit: BoxFit.cover,
          )),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: -60,
                right: 0,
                left: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(clipBehavior: Clip.none, children: [
                      InkWell(
                        child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: (_profilePicture != null)
                                      ? FileImage(_profilePicture)
                                      : widget.userData?.image != null
                                          ? NetworkImage(
                                              KAPIURL + widget.userData.image,
                                            )
                                          : AssetImage(KPlaceHolderCover),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(KdefaultRadius),
                                ))),
                        onTap: () => changeProfilePicture(),
                      ),
                      Positioned(
                        bottom: -28,
                        left: -28,
                        right: -28,
                        child: Row(
                          children: [
                            ClipOval(
                              child: Container(
                                  color: Colors.white10,
                                  width: 56,
                                  height: 56,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                    size: 25,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ],
                ),
              )
            ],
          ),
        ),
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
    _showPicker(context).then((value) => setState(() {
          print("Pp here =====> $value");
          _profilePicture = value;
        }));
  }

  changeCoverPicture() {
    _showPicker(context).then((value) => setState(() {
          print("Cover here =====> $value");
          _cover = value;
        }));
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

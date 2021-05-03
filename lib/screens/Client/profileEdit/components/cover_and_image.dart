import 'package:flutter/material.dart';
import 'package:techtime/Helpers/APIUrls.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/models/client_profile.dart';

class ProfileCoverAndImage extends StatelessWidget {
  const ProfileCoverAndImage({
    Key key,
    @required Decoration imagePikerDecoration,
    @required this.userData,
  })  : _imagePikerDecoration = imagePikerDecoration,
        super(key: key);
  final ClientProfile userData;
  final Decoration _imagePikerDecoration;

  @override
  Widget build(BuildContext context) {
    // ThemeData _theme = Theme.of(context);
    AppLocalizations _translator = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: userData?.coverImage != null
            ? NetworkImage(
                KAPIURL + userData.coverImage,
              )
            : AssetImage(KPlaceHolderCover),
        fit: BoxFit.fill,
      )),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80, right: 10, left: 10),
                child: ClipOval(
                  child: Material(
                    color: Colors.black45, // button color
                    child: InkWell(
                      child: SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                            size: 25,
                          )),
                      onTap: () {},
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned.fill(
            bottom: -60,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: 120,
                    width: 120,
                    decoration: _imagePikerDecoration,
                    child: InkWell(
                      onTap: () => print("update"),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(KdefaultRadius),
                                    bottomRight:
                                        Radius.circular(KdefaultRadius)),
                              ),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt_outlined,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    _translator.translate("update"),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(color: Colors.white),
                                  )
                                ],
                              )),
                            ),
                          )
                        ],
                      ),
                    ))),
          )
        ],
      ),
    );
  }
}

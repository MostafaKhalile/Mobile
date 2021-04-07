import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/widgets/core/horizontal_gap.dart';
import 'package:techtime/widgets/core/vertical_gab.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key key,
    @required Size size,
    @required ThemeData theme,
  })  : _size = size,
        _theme = theme,
        super(key: key);

  final Size _size;
  final ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size.width * 0.8,
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '18-5-2020',
                    style: _theme.textTheme.subtitle1,
                  )),
              Wrap(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset(
                            KPlaceHolderImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      HorizontalGap(width: KDefaultPadding / 2),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'سلامة الياسين',
                                style: _theme.textTheme.subtitle2,
                              ),
                            ],
                          ),
                          SmoothStarRating(
                            size: 14,
                            rating: 4.0,
                            allowHalfRating: true,
                            isReadOnly: true,
                          ),
                          VerticalGap(
                            height: KDefaultPadding / 4,
                          ),
                          SizedBox(
                            width: _size.width * 0.6,
                            child: Text(
                                ''' ريم ايبسوم دولار سيت أميت ,كونسيكتيتور أدايبا يسكينج أليايت,سيت دو أيوسمود تيمبور
أنكايديديونتيوت لابوري ات دولار ماجنا أليكيوا . يوت انيم أد مينيم فينايم,كيواس نوستريد

أكسير سيتاشن يللأمكو لابورأس نيسي يت أليكيوب أكس أيا كوممودو كونسيكيوات 
نيولا باراياتيور. أيكسسيبتيور ساينت''',
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.fade,
                                maxLines: 2,
                                style: _theme.textTheme.caption),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

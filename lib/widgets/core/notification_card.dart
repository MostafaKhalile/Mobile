import 'package:flutter/material.dart';
import 'package:techtime/Helpers/colors.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key key,
    @required this.hasBeenRead,
  }) : super(key: key);

  final bool hasBeenRead;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: Border(
          left: BorderSide(
              color: hasBeenRead ? Colors.transparent : KPrimaryColor,
              width: 8)),
      child: ListTile(
        // leading: CircleAvatarProfile(),
        title: Text('عنوان الاشعار'),
        subtitle: RichText(
          text: TextSpan(
            text: ' لوريم ايبسومت ,كونسيكتيتور أدايبا يسكينج\n',
            style: Theme.of(context).textTheme.subtitle1,
            children: <TextSpan>[
              TextSpan(
                text: 'منذ 7 ساعات',
              )
            ],
          ),
        ),
        trailing: Icon(Icons.more_horiz),
        isThreeLine: true,
      ),
    );
  }
}

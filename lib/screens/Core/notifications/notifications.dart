import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtime/Controllers/BLoCs/core/notificationsBloc/notifications_bloc.dart';
import 'package:techtime/Controllers/Repositories/notifications/api_client.dart';
import 'package:techtime/Helpers/app_colors.dart';
import 'package:techtime/Helpers/app_consts.dart';
import 'package:techtime/Helpers/enums.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';
import 'package:techtime/Models/notifications/all_notifications.dart';
import 'package:techtime/Models/notifications/user_notification.dart';

class Notifications extends StatefulWidget {
  static const String routeName = "/notifications";
  final AllNotifications? notifications;

  const Notifications({Key? key, this.notifications}) : super(key: key);
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final NotificatiosApiClient _notificatiosApiClient = NotificatiosApiClient();
  late NotificationsBloc notificationsBloc;
  AllNotifications? allNotifications;
  @override
  void initState() {
    allNotifications = widget.notifications;
    notificationsBloc = context.read<NotificationsBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    // Size _size = MediaQuery.of(context).size;
    final AppLocalizations _translator = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(
            _translator.translate("notifications")!,
            style: _theme.textTheme.headline6!.copyWith(color: Colors.black),
          ),
          actionsIconTheme: const IconThemeData(color: Colors.black),
          actions: [
            PopupMenuButton<NotificationsActions>(
              onSelected: (NotificationsActions result) async {
                if (result == NotificationsActions.readAll) {
                  final bool hasReadAll =
                      await _notificatiosApiClient.readAllNotifications();
                  if (hasReadAll) {
                    notificationsBloc.add(const GetAllUserNotifications());
                  }
                }
                if (result == NotificationsActions.clearAll) {
                  final bool clearAll =
                      await _notificatiosApiClient.clearAllNotifications();
                  if (clearAll) {
                    notificationsBloc.add(const GetAllUserNotifications());
                  }
                }
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<NotificationsActions>>[
                PopupMenuItem<NotificationsActions>(
                  value: NotificationsActions.readAll,
                  textStyle: _theme.textTheme.subtitle2,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.check,
                          color: _theme.accentColor,
                        ),
                      ),
                      Text(_translator.translate('mark_all_as_read')!),
                    ],
                  ),
                ),
                PopupMenuItem<NotificationsActions>(
                    value: NotificationsActions.clearAll,
                    textStyle: _theme.textTheme.subtitle2,
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.delete_forever,
                          color: _theme.accentColor,
                        ),
                      ),
                      Text(_translator.translate('clear_all')!),
                    ])),
              ],
            )
          ],
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: BlocConsumer<NotificationsBloc, NotificationsState>(
                  buildWhen: (previousState, currentState) =>
                      previousState != currentState,
                  listener: (context, state) {
                    if (state is NotificationsSuccess) {
                      setState(() {
                        allNotifications = state.notifications;
                      });
                    }
                  },
                  builder: (context, state) {
                    Widget view;
                    if (allNotifications!.notReadNotification!.isEmpty &&
                        allNotifications!.readNotification!.isEmpty) {
                      view = Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/notifications_empty_state.svg",
                            height: 120,
                          ),
                          const SizedBox(
                            height: defaultPadding,
                          ),
                          const Text("No Notifications to show .")
                        ],
                      );
                    } else {
                      view = buildNotificationsData(_translator);
                    }
                    return view;
                  },
                ),
              ),
            ],
          ),
        ));
  }

  ListView buildNotificationsData(AppLocalizations _translator) {
    return ListView.builder(
        itemCount: allNotifications!.notReadNotification!.length +
            allNotifications!.readNotification!.length,
        padding: const EdgeInsets.all(defaultPadding / 2),
        itemBuilder: (context, index) {
          final List<UserNotification> notifications = [
            ...allNotifications!.notReadNotification!,
            ...allNotifications!.readNotification!
          ];
          final item = notifications[index];

          return Dismissible(
              // Each Dismissible must contain a Key. Keys allow Flutter to
              // uniquely identify widgets.
              key: Key(item.toString()),
              // Provide a function that tells the app
              // what to do after an item has been swiped away.
              onDismissed: (direction) {
                // Remove the item from the data source.
                buildOnDismiss(index, context, item.toString());
              },
              confirmDismiss: (direction) {
                return buildShowDialog(context, _translator);
              },
              // Show a red background as the item is swiped away.
              direction: DismissDirection.startToEnd,
              background: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
              child: NotificationCard(
                hasBeenRead:
                    widget.notifications!.readNotification!.contains(item),
                notification: notifications[index],
              ));
        });
  }

  void buildOnDismiss(int index, BuildContext context, String item) {
    //TODO: Implement read notification
    // Remove the item from the data source.
    // setState(() {
    //   notifications.removeAt(index);
    // });

    // // Then show a snackbar.
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text("$item dismissed")));
  }

  Future<bool?> buildShowDialog(
      BuildContext context, AppLocalizations _translator) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_translator.translate("are_sure_to_delete_object")!),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                _translator.translate("confirm")!,
                style: Theme.of(context).textTheme.button,
              ),
            ),
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  _translator.translate("cancel")!,
                  style: Theme.of(context).textTheme.button,
                )),
          ],
        );
      },
    );
  }
}

class NotificationCard extends StatefulWidget {
  const NotificationCard({
    Key? key,
    this.hasBeenRead,
    this.notification,
  }) : super(key: key);
  final UserNotification? notification;
  final bool? hasBeenRead;

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  final NotificatiosApiClient _notificatiosApiClient = NotificatiosApiClient();
  bool? isRead;
  @override
  void initState() {
    isRead = widget.hasBeenRead;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final AppLocalizations? _translator = AppLocalizations.of(context);
    return Card(
      shape: Border(
          left: BorderSide(
              color: isRead! ? Colors.transparent : AppColors.primaryColor,
              width: 8)),
      child: ListTile(
        // leading: CircleAvatarProfile(),
        subtitle: Text(widget.notification!.notificationNotesEn ?? ""),
        title: RichText(
          text: TextSpan(
            text: "${widget.notification!.notificationDate}\t\t",
            style: Theme.of(context).textTheme.subtitle1,
            children: <TextSpan>[
              TextSpan(
                text: TimeOfDay(
                        hour: int.parse(widget.notification!.notificationTime
                            .toString()
                            .split(":")[0]),
                        minute: int.parse(widget.notification!.notificationTime
                            .toString()
                            .split(":")[1]))
                    .format(context),
              )
            ],
          ),
        ),
        trailing: PopupMenuButton<NotificationsActions>(
          icon: const Icon(Icons.more_horiz),
          onSelected: (NotificationsActions result) async {
            if (result == NotificationsActions.read) {
              await _notificatiosApiClient
                  .readNotification(widget.notification!.notificationId)
                  .then((value) => setState(() {
                        isRead = value;
                        if (isRead!) {
                          context
                              .read<NotificationsBloc>()
                              .add(const GetAllUserNotifications());
                        }
                      }));
            }
            if (result == NotificationsActions.delete) {
              bool hasBeenDeleted;
              hasBeenDeleted = await _notificatiosApiClient
                  .deleteNotification(widget.notification!.notificationId);

              if (hasBeenDeleted) {
                context
                    .read<NotificationsBloc>()
                    .add(const GetAllUserNotifications());
              }
            }
          },
          itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<NotificationsActions>>[
            PopupMenuItem<NotificationsActions>(
              value: NotificationsActions.read,
              textStyle: _theme.textTheme.subtitle2,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.check,
                      color: _theme.accentColor,
                    ),
                  ),
                  Text(_translator!.translate('mark_as_read')!),
                ],
              ),
            ),
            PopupMenuItem<NotificationsActions>(
                value: NotificationsActions.delete,
                textStyle: _theme.textTheme.subtitle2,
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.delete_forever,
                      color: _theme.accentColor,
                    ),
                  ),
                  Text(_translator.translate('delete')!),
                ])),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}

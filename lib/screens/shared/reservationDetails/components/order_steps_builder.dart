import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/material.dart';
import 'package:techtime/Controllers/BLoCs/core/ReservationsBlocs/reservationDetailsBloc/reservationdetails_bloc.dart';
import 'package:techtime/Helpers/app_colors.dart';

class StepperBuilder extends StatelessWidget {
  const StepperBuilder({
    Key? key,
    required this.currentStep,
    required ThemeData theme,
    required this.state,
  })  : _theme = theme,
        super(key: key);

  final int currentStep;
  final ThemeData _theme;
  final ReservationdetailsSuccess state;
  @override
  Widget build(BuildContext context) {
    final status = state.reservationDetails.orderStatus!;
    return Container(
      padding: const EdgeInsets.only(top: 10),
      height: 100,
      width: MediaQuery.of(context).size.width * .98,
      child: Row(
        children: [
          Expanded(
            child: Theme(
              data: ThemeData(
                  canvasColor: Colors.black,
                  accentColor: AppColors.primaryColor,
                  brightness: Brightness.dark),
              child: EnhanceStepper(
                horizontalTitlePosition: HorizontalTitlePosition.bottom,
                horizontalLinePosition: HorizontalLinePosition.center,
                type: StepperType.horizontal,
                stepIconSize: 25,
                physics: const ClampingScrollPhysics(),
                currentStep: currentStep,
                controlsBuilder: (BuildContext context,
                    {VoidCallback? onStepContinue,
                    VoidCallback? onStepCancel}) {
                  return Row();
                },
                steps: [
                  EnhanceStep(
                    title: Text(
                      'Request',
                      style: _theme.textTheme.subtitle2,
                    ),
                    isActive: status.assent! ||
                        status.confirm! ||
                        status.done! ||
                        status.finish!,
                    state: (status.assent! ||
                            status.confirm! ||
                            status.done! ||
                            status.finish!)
                        ? StepState.complete
                        : StepState.indexed,
                    content: Container(),
                  ),
                  EnhanceStep(
                    title: Text(
                      'Arrive',
                      style: _theme.textTheme.subtitle2,
                    ),
                    isActive: status.confirm! || status.done! || status.finish!,
                    state: status.confirm! || status.done! || status.finish!
                        ? StepState.complete
                        : StepState.disabled,
                    content: Container(),
                  ),
                  EnhanceStep(
                    title: Text(
                      'Complete',
                      style: _theme.textTheme.subtitle2,
                    ),
                    isActive: status.confirm! || status.done! || status.finish!,
                    state: (status.confirm! || status.done! || status.finish!)
                        ? StepState.complete
                        : StepState.disabled,
                    content: Container(),
                  ),
                  EnhanceStep(
                    title: Text(
                      'Reviews',
                      style: _theme.textTheme.subtitle2,
                    ),
                    isActive: status.finish!,
                    state:
                        status.finish! ? StepState.complete : StepState.indexed,
                    content: Container(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

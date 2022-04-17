import 'package:flutter/material.dart';
import 'package:habits_organizer/libraries/libraries.dart';
import 'package:habits_organizer/view/habits/form/import.dart';
import 'package:page_transition/page_transition.dart';
import '../list/habit_list_view.dart';

class ListFormChild extends StatelessWidget {
  const ListFormChild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formBloc = BlocProvider.of<AllFieldsFormBloc>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: DesignationForm(),
              )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                    onPressed: formBloc.submit,
                    splashRadius: 20, // onPressed
                    icon: const Icon(Icons.save_alt)),
              ),
            ],
          ),
          const FrequenceForm(),
          const IterationForm(),
          const JoursForm(),
          const IntervalForm()
        ],
      ),
    );
  }
}

class HabitForm extends StatelessWidget {
  late final AllFieldsFormBloc bloc;
  final Habit? habit;

  HabitForm({Key? key, this.habit}) : super(key: key) {
    bloc = AllFieldsFormBloc(habit);
  }

  void onSuccess(context, FormBlocSuccess<String, String> state) async {
    HabitOrganizerContext appContext = HabitOrganizerContext.of(context);
    Map<String, dynamic> map = {};
    map['interval'] = null;
    map['jours'] = null;
    map['frequence'] = null;
    map['designation'] = null;
    map['iteration'] = "1";
    map.addAll(state.toJson());
    await appContext.editCreateHabit(data: map, habit: habit);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => bloc,
        child: Builder(builder: (context) {
          final formBloc = BlocProvider.of<AllFieldsFormBloc>(context);
          return Scaffold(
              appBar: AppBar(
                centerTitle:true,
                backgroundColor: Colors.deepPurple,
                elevation: 4,
                title: const HabitOrganizerShimmer(
                    child: Text('Créer une habitude',textAlign: TextAlign.center,)

                ),
                leading: HabitOrganizerShimmer(
                    child: IconButton(
                        onPressed: () => Navigator.popAndPushNamed(context,Listhabits.listhabitsRouteName,
                            arguments: PageTransitionArgument(PageTransitionType.leftToRightWithFade)
                        ),
                        icon: const Icon(Icons.keyboard_return))),
              ),
              body: CloudBackground(
                child: Center(
                  child: Card(
                    elevation: 10,
                    child: FractionallySizedBox(
                      widthFactor: 0.9,
                      child:
                          FormBlocListener<AllFieldsFormBloc, String, String>(
                              onSuccess: (context, state) =>
                                  onSuccess(context, state),
                              child: ScrollableFormBlocManager(
                                  formBloc: formBloc,
                                  child: const ListFormChild())),
                    ),
                  ),
                ),
              ));
        }));
  }
}

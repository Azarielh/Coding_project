import 'package:habits_organizer/view/habits/form/import.dart';

class AllFieldsFormBloc extends FormBloc<String, String> {
  late TextFieldBloc designation;
  late InputFieldBloc<double, dynamic> frequence;
  late SelectFieldBloc<String, dynamic> iteration;
  late MultiSelectFieldBloc<String, dynamic> jours;
  late InputFieldBloc<double, dynamic> interval;

  void initBlocs(Habit? habt) {
    List<String> avf = Habit.availableFrequences;
    List<String> avi = Habit.availableIntervals;
    List<String> avj = Habit.availableJours;
    List<int> avt = Habit.availableIteration;

    frequence = InputFieldBloc<double, dynamic>(
        initialValue: habt != null
            ? avf.indexOf(habt.frequence).toDouble() / (avf.length - 1)
            : 0,
        name: "frequence",
        toJson: (value) => avf[(value * (avf.length - 1)).toInt()]);

    interval = InputFieldBloc<double, dynamic>(
        initialValue: habt?.interval != null
            ? avi.indexOf(habt!.interval!).toDouble() / (avi.length - 1)
            : 0,
        name: "interval",
        toJson: (value) => avi[(value * (avi.length - 1)).toInt()]);

    jours = MultiSelectFieldBloc<String, dynamic>(
      items: Habit.availableJours,
      initialValue: habt != null ? habt.jours?.split(' ').toList() ?? avj : avj,
      name: "jours",
      toJson: (value) => value.join(' '),
    );

    iteration = SelectFieldBloc<String, dynamic>(
      items: avt.map((i) => i.toString()).join(' ').split(' '),
      initialValue: habt != null ? habt.iteration.toString() : "1",
      name: "iteration",
      toJson: (value) => value,
    );

    designation = TextFieldBloc(
      name: "designation",
      initialValue: habt != null ? habt.designation : "",
      validators: [
        (value) => isNull(value) != true ? null : " -  can't be blank\n",
        (value) => isLength(value, 4) == true ? null : " -  min 4 len\n",
      ],
    );
  }

  void updateForm() {
    designation.changeValue("");
    designation.changeValue("w");
    designation.clear();
    frequence.changeValue(1);
    frequence.changeValue(0);
    frequence.clear();
  }

  void addConditionalRule(Habit? habit) {
    List<String> avf = Habit.availableFrequences;
    frequence.onValueChanges(onData: (p, c) async* {
      String cFre = avf[(c.value * (avf.length - 1)).toInt()];

      if (cFre == Frequence.daily) {
        addFieldBlocs(fieldBlocs: [jours, interval]);
        removeFieldBlocs(fieldBlocs: [iteration]);
        if (habit != null &&
            habit.jours != null &&
            habit.frequence == Frequence.daily) {
          jours.changeValue(habit.jours!.split(' '));
        } else {
          jours.changeValue(Habit.availableJours);
        }
      } else if (cFre == Frequence.hebdo) {
        addFieldBlocs(fieldBlocs: [jours, iteration]);
        removeFieldBlocs(fieldBlocs: [interval]);
        if (habit != null &&
            habit.jours != null &&
            habit.frequence == Frequence.hebdo) {
          jours.changeValue(habit.jours!.split(' '));
        } else {
          jours.changeValue([]);
        }
      } else if (cFre == Frequence.mensuel) {
        addFieldBlocs(fieldBlocs: [iteration]);
        removeFieldBlocs(fieldBlocs: [interval, jours]);
      }
    });

    designation.onValueChanges(onData: (p, c) async* {
      if (c.isValid && !p.isValid) {
        addFieldBloc(fieldBloc: frequence);
        frequence.changeValue(1);
        frequence.clear();
      } else if (!c.isValid && p.isValid) {
        removeFieldBlocs(fieldBlocs: state.fieldBlocs()?.values.toList() ?? []);
        addFieldBloc(fieldBloc: designation);
      }
    });
  }

  AllFieldsFormBloc(Habit? habit) : super(autoValidate: true) {
    initBlocs(habit);
    addConditionalRule(habit);
    addFieldBloc(fieldBloc: designation);
    habit != null ? updateForm() : 0;
  }

  @override
  void onSubmitting() async {
    try {
      emitSuccess(canSubmitAgain: false);
    } catch (e) {
      emitFailure();
    }
  }
}

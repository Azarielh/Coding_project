import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:habits_organizer/context.dart';
import 'package:habits_organizer/main.dart';
import 'package:root/home.dart';

class NewHabit extends StatefulWidget{
  const NewHabit({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NewHabitState();
}

class NewHabitState extends State<NewHabit> {
  @override
  Widget build(BuildContext context) {
    return const AllFieldsForm();
  }
}

class AllFieldsFormBloc extends FormBloc<String, String> {
  final designation = TextFieldBloc(name: "designation", validators: [
    (dynamic value) {
      if (value == null || value.length < 4) {
        return "can't be blank (min 4 lettres)";
      }
      return null;
    }
  ]);

  final iteration = SelectFieldBloc(
    items: ['1', '2', '3'],
    initialValue: '1',
    name: "iteration",
    toJson: (value) => value.toString(),
  );

  final jours = MultiSelectFieldBloc<String, dynamic>(
    items: ['Lu', 'Ma', 'Me', 'Je', 'Ve', 'Sa', 'Di'],
    initialValue: ['Lu', 'Ma', 'Me', 'Je', 'Ve', 'Sa', 'Di'],
    name: "jours",
    toJson: (value) => value.toList(),
  );

  final interval = InputFieldBloc<double, dynamic>(
    initialValue: 0.5,
    name: "interval",
    toJson: (value) {
      List<String> data = ["matin", "midi", "soir"];
      return data[(value * 2).toInt()];
    },
  );

  final frequence = InputFieldBloc<double, dynamic>(
    initialValue: 0,
    name: "frequence",
    toJson: (value) {
      List<String> data = ["daily", "hebdo", "mensuel"];
      return data[(value * 2).toInt()];
    },
  );

  AllFieldsFormBloc() : super(autoValidate: true) {
    addFieldBlocs(fieldBlocs: [
      designation,
    ]);

    designation.onValueChanges(onData: (previous, current) async* {
      if (previous.value.length <= 3 && current.value.length > 3) {
        double oldFrequence = frequence.value;
        frequence.updateValue(1);
        frequence.updateValue(0);
        frequence.updateValue(oldFrequence);
        addFieldBlocs(fieldBlocs: [frequence]);
        addFieldBlocs(fieldBlocs: [iteration]);
      } else if (current.value.length <= 3) {
        removeFieldBlocs(fieldBlocs: [frequence]);
        removeFieldBlocs(fieldBlocs: [jours]);
        removeFieldBlocs(fieldBlocs: [interval]);
        removeFieldBlocs(fieldBlocs: [iteration]);
      }
    });

    iteration.onValueChanges(onData: (previous, current) async* {
      if (current.value != '1'|| frequence.value != 0) {
        removeFieldBlocs(fieldBlocs: [interval]);
      } else if (frequence.value == 0){
        addFieldBlocs(fieldBlocs: [interval]);
      }
    });

    frequence.onValueChanges(onData: (previous, current) async* {
      if (current.value == 0.5) {
        jours.changeValue([]);
      } else {
        jours.changeValue(['Lu', 'Ma', 'Me', 'Je', 'Ve', 'Sa', 'Di']);
      }

      if (current.value == 0) {
        addFieldBlocs(fieldBlocs: [interval]);
      } else {
        removeFieldBlocs(fieldBlocs: [interval]);
      }

      if (current.value != 1) {
        addFieldBlocs(fieldBlocs: [jours]);
      } else {
        removeFieldBlocs(fieldBlocs: [jours]);
      }
    });
  }

  void addErrors() {
    designation.addFieldError("can't be blank (min 4 letters)");
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

class AllFieldsForm extends StatelessWidget {
  const AllFieldsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllFieldsFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<AllFieldsFormBloc>(context);

          return FormBlocListener<AllFieldsFormBloc, String, String>(
            onSubmitting: (context, state) {},
            onSuccess: (context, state) {
              HabitOrganizerContext.ofRootContext.addHabits(state.toJson());
            },
            onFailure: (context, state) {},
            child: ScrollableFormBlocManager(
              formBloc: formBloc,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: <Widget>[
                    TextFieldBlocBuilder(
                      textFieldBloc: formBloc.designation,
                      decoration: const InputDecoration(
                        labelText: 'designation',
                        prefixIcon: Icon(Icons.drive_file_rename_outline),
                      ),
                    ),
                    SliderFieldBlocBuilder(
                        inputFieldBloc: formBloc.frequence,
                        divisions: 2,
                        decoration:
                            const InputDecoration(labelText: "frequence"),
                        labelBuilder: (context, value) {
                          List<String> name = ["daily", "hebdo", "mensuel"];
                          return (name[(value * 2).toInt()]);
                        }),
                    RadioButtonGroupFieldBlocBuilder<String>(
                      selectFieldBloc: formBloc.iteration,
                      decoration: const InputDecoration(
                          labelText: 'iterations',
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          border: InputBorder.none),
                      groupStyle: const TableGroupStyle(crossAxisCount: 3),
                      itemBuilder: (context, item) => FieldItem(
                        child: Text(item),
                      ),
                    ),
                    CheckboxGroupFieldBlocBuilder<String>(
                      multiSelectFieldBloc: formBloc.jours,
                      groupStyle: const TableGroupStyle(crossAxisCount: 3),
                      itemBuilder: (context, item) =>
                          FieldItem(child: Text(item)),
                    ),
                    SliderFieldBlocBuilder(
                        inputFieldBloc: formBloc.interval,
                        divisions: 2,
                        decoration: InputDecoration(
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Flexible(child: Icon(Icons.alarm)),
                              Flexible(child: Icon(Icons.wb_sunny_outlined)),
                              Flexible(child: Icon(Icons.shield_moon_outlined))
                            ],
                          ),
                        ),
                        labelBuilder: (context, value) {
                          List<String> name = ["matin", "midi", "soir"];
                          return (name[(value * 2).toInt()]);
                        }),
                    FloatingActionButton.extended(
                      onPressed: () {
                        formBloc.submit();
                      },
                      icon: const Icon(Icons.send),
                      label: const Text('SUBMIT'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

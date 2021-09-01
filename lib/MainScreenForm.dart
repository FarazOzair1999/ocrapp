import 'package:flutter/material.dart';
import 'package:ocrapp/confirmationForm.dart';

class MainScreenForm extends StatefulWidget {
  final List lineResultList;
  MainScreenForm({Key key, @required this.lineResultList}) : super(key: key);

  @override
  _MainScreenFormState createState() => _MainScreenFormState();
}

class _MainScreenFormState extends State<MainScreenForm> {
  Map<String, bool> checkboxListValues = {};
  var vendorSet = <String>{};
  var itemSet = <String>{};
  var total = <String>{};

  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stepper"),
        centerTitle: true,
        actions: [
          ElevatedButton.icon(
              icon: Icon(Icons.arrow_forward),
              label: Text("Completed", style: TextStyle(fontSize: 10)),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.red, width: 2.0)))),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConfirmationForm(
                            vendorSet: vendorSet,
                            itemSet: itemSet,
                            total: total,
                          ))))
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Stepper(
            type: StepperType.horizontal,
            currentStep: _currentStep,
            onStepTapped: (int step) => setState(() => _currentStep = step),
            onStepContinue: _currentStep < 2
                ? () => setState(() => _currentStep += 1)
                : null,
            onStepCancel: _currentStep > 0
                ? () => setState(() => _currentStep -= 1)
                : null,
            steps: <Step>[
              new Step(
                title: new Text("Pick Vendor"),
                content: Expanded(
                    flex: widget.lineResultList.length,
                    child:
                        Column(children: _checkBoxLineResultList(vendorSet))),
                isActive: _currentStep >= 0,
                state:
                    _currentStep >= 0 ? StepState.complete : StepState.disabled,
              ),
              new Step(
                title: new Text("Pick Items"),
                content: Expanded(
                    flex: widget.lineResultList.length,
                    child: Column(children: _checkBoxLineResultList(itemSet))),
                isActive: _currentStep >= 0,
                state:
                    _currentStep >= 1 ? StepState.complete : StepState.disabled,
              ),
              new Step(
                title: new Text("Pick Total"),
                content: Expanded(
                  flex: widget.lineResultList.length,
                  child: Column(
                    children: _checkBoxLineResultList(total),
                  ),
                ),
                isActive: _currentStep >= 0,
                state:
                    _currentStep >= 2 ? StepState.complete : StepState.disabled,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _checkBoxLineResultList(Set listToAdd) {
    return widget.lineResultList
        .map((label) => CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(label),
            value: checkboxListValues[label] ?? false,
            onChanged: (newValue) {
              setState(() {
                if (checkboxListValues[label] == null) {
                  checkboxListValues[label] = true;
                }

                checkboxListValues[label] = !checkboxListValues[label];

                if (newValue == true) {
                  listToAdd.add(label);
                  print("added $label");
                } else if (newValue == false) {
                  listToAdd.remove(label);
                  print("removed $label");
                }
                print(listToAdd);
              });
            }))
        .toList();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  runApp(const MaterialApp(
    home: FormB(),
  ));
}

class FormB extends StatefulWidget {
  const FormB({Key? key}) : super(key: key);

  @override
  State<FormB> createState() => _FormBState();
}

class _FormBState extends State<FormB> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormBuilderState>();
  void _onChanged(dynamic val) => debugPrint(val.toString());
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raúl Millán- Salesians Sarrià 24/25'),
        backgroundColor: Colors.blue[300],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stepper(
              type: StepperType.horizontal,
              currentStep: _currentStep,
              steps: _getSteps(),
              onStepContinue: _continue,
              onStepCancel: _cancel,
              onStepTapped: (int step) {
                setState(() {
                  _currentStep = step;
                });
              },
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: const Text('CONTINUE'),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: details.onStepCancel,
                      child: const Text('CANCEL'),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Step> _getSteps() {
    return [
      Step(
        title: const Text('Pers.'),
        content: Column(
          children: const [
            Text(
              'Personal',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Pulsi "Contact" o pulsi el botó de "Continue".'),
          ],
        ),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: const Text('Contact'),
        content: Column(
          children: const [
            Text(
              'Contact',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Pulsi "Upload" o pulsi el botó de "Continue".'),
          ],
        ),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: const Text('Upload'),
        isActive: _currentStep >= 2,
        state: _currentStep == 2 ? StepState.indexed : StepState.complete,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Upload',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ingrese su información de contacto a continuación.',
              style: TextStyle(color: Colors.blue),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.home, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 16),
            FormBuilderTextField(
              name: 'algo',
              validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(errorText: 'Es necesario seleccionar una opción')]),
                      
              decoration: InputDecoration(
                labelText: 'Mobile No',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone, color: Colors.blue),
              ),
              onChanged: _onChanged,  
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ];
  }

  void _continue() {
    if (_currentStep < _getSteps().length - 1) {
      setState(() {
        _currentStep += 1;
      });
    }else {
   
    _showAlertDialog();
    }
  }

  void _showAlertDialog() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formValues = _formKey.currentState!.value;
      showDialog(context: context,
        barrierDismissible: true, 
        builder: (BuildContext context){
          return AlertDialog(
            icon: const Icon(Icons.check_circle),                
            title: const Text('Submission Completed'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Velocidad: ${formValues['algo'] ?? 'No seleccionado'}'),
                Text(
                  'Opción: ${formValues['remarks'] ?? 'No seleccionado'}'),
                Text(
                  'Rango de Velocidad: ${formValues['country'] ?? 'No seleccionado'}'),
                Text(
                  'Múltiple Velocidad: ${formValues['high_speed'] ?? 'No seleccionado'}'),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },          
      ); 
    }   
  }

  void _cancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }
}
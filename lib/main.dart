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
  int _currentStep = 0; // Muestra el indice del paso inicial
  final _formKey = GlobalKey<FormBuilderState>();

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raúl Millán-Salesians Sarrià 24/25'),
        backgroundColor: const Color.fromARGB(255, 167, 3, 208),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stepper(// Es el componente Stepper que muestra pasos secuenciales
              type: StepperType.horizontal, 
              currentStep: _currentStep, 
              steps: _getSteps(), // Lista de pasos generada por _getSteps()
              onStepContinue: _continue,
              onStepCancel: _cancel, 
              onStepTapped: (int step) {
                setState(() {
                  _currentStep = step;
                });
              },
              // Los botones de control
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: details.onStepContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 30, 46, 117),
                      ),
                      child: const Text('CONTINUE',
                        style: TextStyle(color: Colors.white),
                      ),
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

  // Genera la lista de pasos (Steps) que se muestra en el Stepper
  List<Step> _getSteps() {
    return [
      Step(//primer paso
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
        isActive: _currentStep >= 0, // Define si el paso está activo
      ),
      Step(//segundo paso
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
      Step( //tercer paso
        title: const Text('Upload'),
        isActive: _currentStep >= 2,
        state: _currentStep == 2 ? StepState.indexed : StepState.complete,
        content: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Upload',
                style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 8),
              const Text(
                'Ingrese su información de contacto a continuación.',
                style: TextStyle(color: Colors.blue),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(//cuadro de texto del gmail
                name: 'gmail',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Es necesario llenar este texto')
                ]),
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email, color: Colors.blue),
                ),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(// cuadro de texto de la direccion
                name: 'direccion',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Es necesario llenar este texto')
                ]),
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.home, color: Colors.blue),
                ),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(//cuadro de texto del telefono
                name: 'telefono',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Es necesario llenar este texto')
                ]),
                decoration: const InputDecoration(
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
      ),
    ];
  }

  // Función para avanzar al siguiente paso en el Stepper
  void _continue() {
    if (_currentStep < _getSteps().length - 1) {
      setState(() {
        _currentStep += 1;
      });
    } else {//se ejecuta en el continuar del tecero
      _showAlertDialog();
    }
  }

  void _showAlertDialog() {// muestra los datos de los cuadros de texto de la tercera parte
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formValues = _formKey.currentState!.value;
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: const Icon(Icons.check_circle),
            title: const Text('Submission Completed'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Email: ${formValues['gmail'] ?? 'No seleccionado'}'),
                Text(
                  'Address: ${formValues['direccion'] ?? 'No seleccionado'}'),
                Text(
                  'Mobile: ${formValues['telefono'] ?? 'No seleccionado'}'),
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

  // Función para retroceder al paso anterior
  void _cancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }
}

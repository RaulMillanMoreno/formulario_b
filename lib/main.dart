import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  runApp(const FormB());
}

class FormB extends StatelessWidget {
  const FormB({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Raúl Millán project',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: StepOne(),
      );
    }
}

class ProgressIndicatorWidget extends StatelessWidget {
  final int currentStep;

  const ProgressIndicatorWidget({required this.currentStep, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(3, (index) {
            return Column(
              children: [
                CircleAvatar(
                  backgroundColor:
                      index < currentStep ? Colors.green : Colors.grey,
                  child: Text('${index + 1}', style: const TextStyle(color: Colors.white)
                  ),
                ),
                const SizedBox(height: 8),
                Text('Paso ${index + 1}'),
              ],
            );
          }),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class StepOne extends StatelessWidget {
  const StepOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text( 'Raúl Millán project-Personal')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ProgressIndicatorWidget(currentStep: 1),
            const Text('Pulsi "Contact" o pulsi el botó de "Continue"'),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Continue'),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const StepTwo()),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class StepTwo extends StatelessWidget {
  const StepTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text( 'Raúl Millán project-Contact')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ProgressIndicatorWidget(currentStep: 2),
            const Text('Pulsi "Upload" o pulsi el botó de "Continue"'),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Continue'),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const StepThree()),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const StepOne()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class StepThree extends StatefulWidget {
  const StepThree({super.key});

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text( 'Raúl Millán project-Email')),
        body: SingleChildScrollView( 
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormBuilder(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 13.0 , right: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const ProgressIndicatorWidget(currentStep: 3),
                        FormBuilderTextField(
                          name: 'email_subject',
                          keyboardType: TextInputType.emailAddress,
                          decoration:
                            InputDecoration(labelText: 'Asunto del Email',
                              prefixIcon: Icon(Icons.email, color: Colors.blueAccent),
                              filled: true,
                              fillColor: Colors.transparent,
                              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.blue),                      
                              ),
                            ),
                          validator: FormBuilderValidators.required(),
                        ),
                        const SizedBox(height: 20),
                        FormBuilderTextField(
                          name: 'email_body',
                          decoration:
                            InputDecoration(labelText: 'Cuerpo del Email',
                              prefixIcon: Icon(Icons.home, color: Colors.blueAccent),
                              filled: true,
                              fillColor: Colors.transparent,
                              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.blue),                      
                              ),
                            ),
                          maxLines: 5,
                          validator: FormBuilderValidators.required(),
                        ),
                        const SizedBox(height: 20),
                        FormBuilderTextField(
                          name: 'email_mobile',
                          decoration: 
                            InputDecoration(labelText: 'Telèfon mòbil',
                              prefixIcon: Icon(Icons.phone, color: Colors.blueAccent),
                              filled: true,
                              fillColor: Colors.transparent,
                              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.blue),                      
                              ),
                            ),
                          validator: FormBuilderValidators.required(),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          child: const Text('Continue'),
                          onPressed: () {
                            if (_formKey.currentState?.saveAndValidate() ?? false) {
                              final formData = _formKey.currentState?.value;
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Resumen de Envío'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        Text('Asunto: ${formData?['email_subject']}'),
                                        Text('Cuerpo: ${formData?['email_body']}'),
                                        Text('Teléfono: ${formData?['email_mobile']}'),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () => Navigator.of(context).pop(),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          child: const Text('Cancelar'),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => const StepTwo()),
                          );
                          },
                        ),  
                      ],
                    ),
                  ),
                ),
              ],
            ),            
          ),


        ),
    //   body: FormBuilder(
    //     key: _formKey,
    //     child: Padding(
    //       padding: const EdgeInsets.only(left: 13.0 , right: 5),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           const ProgressIndicatorWidget(currentStep: 3),
    //           FormBuilderTextField(
    //             name: 'email_subject',
    //             keyboardType: TextInputType.emailAddress,
    //             decoration:
    //               InputDecoration(labelText: 'Asunto del Email',
    //                 prefixIcon: Icon(Icons.email, color: Colors.blueAccent),
    //                 filled: true,
    //                 fillColor: Colors.transparent,
    //                 contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    //                 border: OutlineInputBorder(
    //                   borderRadius: BorderRadius.circular(10.0),
    //                   borderSide: BorderSide(color: Colors.blue),                      
    //                 ),
    //               ),
    //             validator: FormBuilderValidators.required(),
    //           ),
    //           const SizedBox(height: 20),
    //           FormBuilderTextField(
    //             name: 'email_body',
    //             decoration:
    //               InputDecoration(labelText: 'Cuerpo del Email',
    //                 prefixIcon: Icon(Icons.home, color: Colors.blueAccent),
    //                 filled: true,
    //                 fillColor: Colors.transparent,
    //                 contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    //                 border: OutlineInputBorder(
    //                   borderRadius: BorderRadius.circular(10.0),
    //                   borderSide: BorderSide(color: Colors.blue),                      
    //                 ),
    //               ),
    //             maxLines: 5,
    //             validator: FormBuilderValidators.required(),
    //           ),
    //           const SizedBox(height: 20),
    //           FormBuilderTextField(
    //             name: 'email_mobile',
    //             decoration: 
    //               InputDecoration(labelText: 'Telèfon mòbil',
    //                 prefixIcon: Icon(Icons.phone, color: Colors.blueAccent),
    //                 filled: true,
    //                 fillColor: Colors.transparent,
    //                 contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    //                 border: OutlineInputBorder(
    //                   borderRadius: BorderRadius.circular(10.0),
    //                   borderSide: BorderSide(color: Colors.blue),                      
    //                 ),
    //               ),
    //             validator: FormBuilderValidators.required(),
    //           ),
    //           const SizedBox(height: 20),
    //           ElevatedButton(
    //             child: const Text('Continue'),
    //             onPressed: () {
    //               if (_formKey.currentState?.saveAndValidate() ?? false) {
    //                 final formData = _formKey.currentState?.value;
    //                 showDialog(
    //                   context: context,
    //                   builder: (context) => AlertDialog(
    //                     title: const Text('Resumen de Envío'),
    //                     content: SingleChildScrollView(
    //                       child: ListBody(
    //                         children: [
    //                           Text('Asunto: ${formData?['email_subject']}'),
    //                           Text('Cuerpo: ${formData?['email_body']}'),
    //                           Text('Teléfono: ${formData?['email_mobile']}'),
    //                         ],
    //                       ),
    //                     ),
    //                     actions: [
    //                       TextButton(
    //                         child: const Text('OK'),
    //                         onPressed: () => Navigator.of(context).pop(),
    //                       ),
    //                     ],
    //                   ),
    //                 );
    //               }
    //             },
    //           ),
    //           const SizedBox(height: 20),
    //           ElevatedButton(
    //             child: const Text('Cancelar'),
    //             onPressed: () {
    //                Navigator.of(context).pushReplacement(
    //               MaterialPageRoute(builder: (context) => const StepTwo()),
    //             );
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mvc_todo_list/Login/controller/auth_controller.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthController(),
      child: Consumer<AuthController>(
        builder: (context, authProvider, child) {
          return Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Image.asset('assets/images/splash_image.png'),
              ),
              title: const Text(
                'Todo List MVC',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: const Color.fromARGB(255, 98, 102, 100),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 23.0, // This is equivalent to the shadow elevation
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    margin: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            onChanged: (username) => authProvider.setUsername(username),
                            style: Theme.of(context).textTheme.titleSmall,
                            decoration: InputDecoration(
                              labelText: 'Usuario',
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 10,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            onChanged: (value) => authProvider.setPassword(value),
                            obscureText: authProvider.obscurePassword,
                            style: Theme.of(context).textTheme.titleSmall,
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              prefixIcon: const Icon(Icons.lock),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 10,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () => authProvider.togglePasswordVisibility(),
                                child: Icon(
                                  authProvider.obscurePassword ? Icons.visibility : Icons.visibility_off,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Visibility(
                          visible: authProvider.visible,
                          child: Consumer<AuthController>(
                            builder: (context, provider, child) {
                              return Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  provider.error,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              final loginSuccess = await authProvider.logar(
                                email: authProvider.username.text,
                                password: authProvider.password.text,
                              );

                              if (loginSuccess) {
                                Navigator.pushNamed(context, '/todo');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8C1D18),
                              elevation: 8,
                              fixedSize: Size(
                                MediaQuery.of(context).size.width * (214 / MediaQuery.of(context).size.width),
                                MediaQuery.of(context).size.height * (62 / MediaQuery.of(context).size.height),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 68, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                // Defina o estilo do texto do botão de acordo com o tema atual do contexto
                                color: Color.fromARGB(255, 23, 139, 201),
                                fontSize: 18,
                                // Outras propriedades de estilo aqui
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

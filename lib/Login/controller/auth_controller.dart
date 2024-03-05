// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool obscurePassword = true;
  bool visible = false;
  String _error = '';

  String get error => _error;

  void clearCredentials() {
    username.clear();
    password.clear();
  }

  void setUsername(String user) {
    username.text = user;
    _error = '';
    notifyListeners();
  }

  void setPassword(String pass) {
    password.text = pass;
    _error = '';
    notifyListeners();
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  Future<bool> logar({
    required String email,
    required String password,
  }) async {
    // Simulação de um login fake
    if (email == 'admin' && password == '123456') {
      // Simulação de uma chamada assíncrona esperando 2 segundos
      await Future.delayed(const Duration(seconds: 2));
      return true; // Login bem-sucedido
    } else {
      visible = true;
      _error = 'Credenciais inválidas';
      notifyListeners();
      return false; // Login falhou
      // try {
      //   await remote.logar(email: email, password: password);
      //   return true; // Login bem-sucedido
      // } catch (e) {
      //   visible = true;
      //   _error = 'Credenciais inválidas';
      //   notifyListeners();
      //   if (kDebugMode) {
      //     print('Erro de autenticação: $e');
      //   }
      //   return false; // Login falhou
    }
  }
}


/* Deixei aqui esta parte final pois seria como conectariamos com o banco de dados mas para fins
didaticos usaremos um fake de login. */
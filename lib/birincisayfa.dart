
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:highlight/languages/dart.dart';

import 'IkinciSoru.dart';

class BirinciSayfa extends StatefulWidget {
  const BirinciSayfa({super.key});

  @override
  _BirinciSayfaState createState() => _BirinciSayfaState();
}

class _BirinciSayfaState extends State<BirinciSayfa> {
  final CodeController _controller = CodeController(
    text: 'void main() {\n  print("");\n}',
    language: dart,
  );
  String _output = '';

  // FocusNode oluşturun
  final FocusNode _focusNode = FocusNode();

  final int _currentQuestionIndex = 1; // Başlangıçta 1. sorudayız
  final int _totalQuestions = 3;

  @override
  void initState() {
    super.initState();
    // Sayfa yüklendiğinde klavye gizlenmesini sağlamak için
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _hideKeyboard();
    });
  }

  void _hideKeyboard() {
    // Klavyeyi gizle
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _runCode() {
    final code = _controller.text;
    final regex = RegExp(r'print\("([^"]*)"\)');
    final match = regex.firstMatch(code);
    if (match != null) {
      final output = match.group(1) ?? 'No output';
      setState(() {
        _output = output;
      });


      if (_output == 'Merhaba Ben Maria') {
        _showAlertDialog();
      }
    } else {
      setState(() {
        _output = 'No output';
      });
    }
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 400,
                height: 270,
                child: Image.asset(
                  'images/tebrikler.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Devam', style: TextStyle(fontSize: 20)),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const IkinciSoru()), // Bu satırı güncelleyin
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    width: constraints.maxWidth * (_currentQuestionIndex / _totalQuestions),
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                },
              ),
              const Positioned(
                right: 0,
                child: Icon(
                  Icons.bolt,
                  color: Colors.yellow,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Soru $_currentQuestionIndex / $_totalQuestions',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Klavye açıldığında ekranın geri kalanını değiştirme
      extendBodyBehindAppBar: true, // AppBar'ın arka planını uzat
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: _runCode,
            iconSize: 60, // İkon boyutunu burada da ayarla
            color: Colors.black, // İkon rengini siyah yap
          ),
        ],
        title: const Text('Kod Düzenleyici'),
        backgroundColor: Colors.transparent, // AppBar arka plan rengini şeffaf yap
        elevation: 0, // Gölgeyi kaldır
        shadowColor: Colors.transparent, // Gölge rengini şeffaf yap
        iconTheme: const IconThemeData(
          color: Colors.black, // İkon rengini siyah yap
          size: 30, // İkon boyutunu büyüt
        ),
      ),
      body: GestureDetector(
        onTap: () {
          // Kullanıcı ekrana tıkladığında klavyeyi gizle
          _hideKeyboard();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/arkaplan.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  _buildProgressBar(),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'merhaba ben maria',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8, // Genişliği sınırlama
                    height: MediaQuery.of(context).size.height * 0.4, // Yüksekliği sınırlama
                    child: CodeTheme(
                      data: CodeThemeData(styles: monokaiSublimeTheme),
                      child: CodeField(
                        controller: _controller,
                        focusNode: _focusNode,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Kod Çıktısı:\n$_output',
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

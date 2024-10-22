import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:xym/service/user.dart';

class ExcersiseScreenScreen extends StatefulWidget {
  final String excersise; // Primer parámetro
  final String video; // Segundo parámetro

  const ExcersiseScreenScreen(
      {super.key, required this.excersise, required this.video});

  @override
  // ignore: library_private_types_in_public_api
  _ExcersiseScreenScreenState createState() => _ExcersiseScreenScreenState();
}

class _ExcersiseScreenScreenState extends State<ExcersiseScreenScreen> {
  UserService userService = UserService();
  late VideoPlayerController _controller;
  Timer? _timer;
  int _elapsedSeconds = 0;
  bool _isRunning = false;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/${widget.video}')
      ..initialize().then((_) {
        // Asegúrate de que el estado ha sido actualizado correctamente después de la inicialización.
        if (mounted) setState(() {});
      });

    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
    _controller.dispose();
  }

  void _updateTimer(Timer timer) {
    if (_isRunning) {
      setState(() {
        _elapsedSeconds++;
      });
    }
  }

  void _toggleTimer() {
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.excersise),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Tiempo transcurrido: ${_elapsedSeconds ~/ 60}:${(_elapsedSeconds % 60).toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        _toggleTimer();
                      },
                      child: Icon(
                        _isRunning ? Icons.pause : Icons.play_arrow,
                        size: 50,
                        color: Colors.black,
                      ),
                    ),
                  ]),
            ),
            const Text(
              'Como realizar el ejercicio:',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    height: 480,
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    },
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await _save(context);
              },
              child: const Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save(BuildContext context) async {
    int seconds = _elapsedSeconds;

    List success = await userService.insertExcersises(seconds);
    if (success.isEmpty) {
      _showSnackBar('Datos registrados exitosamente.');
    } else {
      _showSnackBar('Error al registrar. Por favor, verifica los datos.');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

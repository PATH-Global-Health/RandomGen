import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/dao/place_dao.dart';
import '../../logic/bloc/home/home_bloc.dart';
import 'place_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isPasswordTextVisible = false;
  bool isUsernameTextEmpty = true;
  bool _isNotInit = true;

  void _changeUsernameTextEmpty() {
    if (_usernameController.text.isEmpty == false &&
        isUsernameTextEmpty == true) {
      setState(() {
        isUsernameTextEmpty = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_changeUsernameTextEmpty);
  }

  @override
  void didChangeDependencies() {
    if (_isNotInit) {
      context.read<HomeBloc>().add(RegisterServiceEvent());
      _isNotInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RandomGen')),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is SuccessfulLoginState) {
            final args = PlaceDAO(username: state.username);
            Navigator.of(context)
                .pushReplacementNamed(PlaceScreen.routeName, arguments: args);
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => PlaceScreen(username: state.username),
            //   ),
            // );
          }
        },
        builder: (context, state) {
          if (state is HomeInitial || state is FailedLoginState) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    // decoration: const InputDecoration(labelText: 'Username'),
                    controller: _usernameController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      suffixIcon: isUsernameTextEmpty
                          ? const Text('')
                          : GestureDetector(
                              onTap: () {
                                _usernameController.clear();
                                setState(() {
                                  isUsernameTextEmpty =
                                      _usernameController.text.isEmpty;
                                });
                              },
                              child: const Icon(Icons.close),
                            ),
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: _passwordController,
                    // decoration: const InputDecoration(labelText: 'Passsword'),
                    decoration: InputDecoration(
                      // icon: Icon(Icons.mail),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPasswordTextVisible = !isPasswordTextVisible;
                            });
                          },
                          child: Icon(isPasswordTextVisible
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      hintText: 'Password',
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1),
                      ),
                    ),
                    obscureText: !isPasswordTextVisible,

                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (state is FailedLoginState)
                    const Text('Login failed',
                        style: TextStyle(fontSize: 14, color: Colors.red)),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<HomeBloc>(context).add(LoginEvent(
                          _usernameController.text,
                          int.parse(_passwordController.text)));
                    },
                    child: const SizedBox(
                      height: 40,
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 18, fontFamily: "Proxima Nova"),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 10.0),
                Text('Initializing...'),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/services/authentication.dart';
import '../../data/services/place.dart';
import '../../logic/bloc/home/home_bloc.dart';
import 'place_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordTextVisible = false;
  bool isUsernameTextEmpty = true;

  void _changeUsernameTextEmpty() {
    if (usernameController.text.isEmpty == false &&
        isUsernameTextEmpty == true) {
      setState(() {
        isUsernameTextEmpty = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    usernameController.addListener(_changeUsernameTextEmpty);
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RandomGen')),
      body: BlocProvider(
        create: (context) => HomeBloc(
            RepositoryProvider.of<AuthenticationService>(context),
            RepositoryProvider.of<PlaceService>(context))
          ..add(RegisterServiceEvent()),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is SuccessfulLoginState) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PlaceScreen(username: state.username),
                ),
              );
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
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      // decoration: const InputDecoration(labelText: 'Username'),
                      controller: usernameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        suffixIcon: isUsernameTextEmpty
                            ? const Text('')
                            : GestureDetector(
                                onTap: () {
                                  usernameController.clear();
                                  setState(() {
                                    isUsernameTextEmpty =
                                        usernameController.text.isEmpty;
                                  });
                                },
                                child: const Icon(Icons.close),
                              ),
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: passwordController,
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
                        hintText: 'type your password',
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1),
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
                              usernameController.text,
                              int.parse(passwordController.text)));
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
                        ))
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

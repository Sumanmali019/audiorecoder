import 'package:audiorecoed/firebaseAuth/export_firebase.dart';

class Singup extends StatefulWidget {
  const Singup({Key? key}) : super(key: key);

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  TextEditingController emailID = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    emailID.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: veryDarkBlue,
      appBar: const AppBarClass(
        title: "Welcome",
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          buildTextField("emailID", emailID, Icons.email, false),
          const HeightSpacer(myHeight: 15.00),
          buildTextField("Password", password, Icons.lock, true),
          const HeightSpacer(myHeight: 25.00),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSubmitBtn2(),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Or',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                width: 10,
              ),
              buildSubmitBtn(),
            ],
          ),
        ]),
      ),
    );
  }

  Widget buildTextField(
          String labelText,
          TextEditingController textEditingController,
          IconData prefixIcons,
          bool isPassword) =>
      SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        child: TextFormField(
          obscureText: isPassword,
          controller: textEditingController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(5.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(5.5),
            ),
            prefixIcon: Icon(prefixIcons, color: Colors.black),
            hintText: labelText,
            hintStyle: const TextStyle(color: Colors.black),
            filled: true,
            fillColor: Colors.blue[50],
          ),
        ),
      );

  Widget buildTextField2(
          String labelText,
          TextEditingController textEditingController,
          IconData prefixIcons,
          bool isPassword) =>
      SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        child: TextFormField(
          obscureText: isPassword,
          controller: textEditingController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(5.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(5.5),
            ),
            prefixIcon: Icon(prefixIcons, color: Colors.blue),
            hintText: labelText,
            hintStyle: const TextStyle(color: Colors.black),
            filled: true,
            fillColor: Colors.blue[50],
          ),
        ),
      );

  Widget buildSubmitBtn2() => ElevatedButton(
      onPressed: () {
        Authentication().signup(
          emailID.text,
          password.text,
        );
      },
      child: const Text("Create Account"));

  Widget buildSubmitBtn() => ElevatedButton(
      onPressed: () {
        Authentication().signin(
          emailID.text,
          password.text,
        );
      },
      child: const Text("Login"));
}

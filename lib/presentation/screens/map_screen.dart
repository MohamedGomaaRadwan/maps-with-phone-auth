import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/business_logic/phone_auth/phone_auth__cubit.dart';
import 'package:flutter_maps/constants/strings.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  PhoneAuthCubit phoneAuthCubit=PhoneAuthCubit();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider<PhoneAuthCubit>(
        create: (context) => phoneAuthCubit,
        child: ElevatedButton(
          onPressed: () async{
            await phoneAuthCubit.logout();
            Navigator.of(context).pushReplacementNamed(loginScreen);
          },
          child: Text(
            'Logout',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
              minimumSize: Size(110, 50),
              primary: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)
              )
          ),
        ),
      ),
    );
  }
}

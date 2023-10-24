import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/models/lock_model.dart';
import 'package:todo_app/ui/widgets/taost_notification.dart';

class LockRepository {
  late Box<LockModel> _lock;

//This function is to initiate the hive databse and create/ open the box for lock models
  Future<void> init() async {
    Hive.registerAdapter(LockModelAdapter());
    _lock = await Hive.openBox<LockModel>('lock_box');
  }

//For registering the code for the particular user...
//_lock.add(LockModel(code)); will be called if succesful ? return success els return failure...
  Future<RegisterResponse> registerUser(final int code) async {
    final alreadyExists = _lock.values.any((element) => element.code == code);
    if (alreadyExists) {
      return RegisterResponse.alreadyExists;
    }
    try {
      _lock
          .add(LockModel(code))
          .whenComplete(() => showTaost('Registred as $code!'));
      return RegisterResponse.success;
    } on Exception catch (e) {
      debugPrint('error $e');
      return RegisterResponse.failure;
    }
  }

//for authenticationg/ login the user using the code...
  Future<int?> authenticate(final int code) async {
    final success = await _lock.values.any((element) => element.code == code);
    if (success) {
      showTaost('Log-in as $code!');
      return code;
    } else {
      return null;
    }
  }
}

//For getting a bool from the function calling...
enum RegisterResponse { success, failure, alreadyExists }

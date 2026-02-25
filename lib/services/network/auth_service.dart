import 'package:intime_manager/network/socket/socket_service.dart';
import 'package:intime_manager/models/request/auth_request.dart';
import 'package:intime_manager/models/request/verify_request.dart';
import 'package:intime_manager/models/request/login_request.dart';
import 'package:intime_manager/models/request/reg_member_request.dart';
import 'package:intime_manager/models/request/work_info_request.dart';
import 'package:intime_manager/models/response/generic_response.dart';
import 'package:intime_manager/models/response/login_response.dart';
import 'package:intime_manager/models/response/emp_working_info_response.dart';

class AuthService extends SocketService {
  Future<GenericResponse> requestAuthCode({
    required String phoneNumber,
    required String reqTime,
  }) async {
    final request = AuthRequest(
      reqTime: reqTime,
      phoneNumber: phoneNumber,
    );

    final response = await sendAndReceive(
      request: request,
    );

    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> verifyAuthCode({
    required String phoneNumber,
    required String authCode,
    required String reqTime,
  }) async {
    final request = VerifyRequest(
      reqTime: reqTime,
      phoneNumber: phoneNumber,
      authCode: authCode,
    );

    final response = await sendAndReceive(
      request: request,
    );

    return GenericResponse.fromJson(response);
  }

  Future<LoginResponse> login({
    required String loginID,
    required String birthDay,
  }) async {
    final request = LoginRequest(
      loginID: loginID,
      birthDay: birthDay,
    );

    final response = await sendAndReceive(
      request: request,
    );

    return LoginResponse.fromJson(response);
  }

  Future<GenericResponse> registerMember({
    required String loginID,
    required String birthDay,
  }) async {
    final request = RegMemberRequest(
      loginID: loginID,
      birthDay: birthDay,
    );

    final response = await sendAndReceive(
      request: request,
    );

    return GenericResponse.fromJson(response);
  }

  Future<EmpWorkingInfoResponse> getWorkInfo({
    required int companyID,
    required int fieldID,
    required String fieldCode,
    required String workDate,
  }) async {
    final request = WorkInfoRequest(
      companyID: companyID,
      fieldID: fieldID,
      fieldCode: fieldCode,
      workDate: workDate,
    );

    final response = await sendAndReceive(
      request: request,
    );

    return EmpWorkingInfoResponse.fromJson(response);
  }
}

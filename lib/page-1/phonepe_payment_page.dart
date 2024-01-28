import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

class PhonepePaymentPage extends StatefulWidget {
  const PhonepePaymentPage({super.key});

  @override
  State<PhonepePaymentPage> createState() => _PhonepePaymentPageState();
}

class _PhonepePaymentPageState extends State<PhonepePaymentPage> {
  String environment = "UAT_SIM";
  String appId = "";
  String merchantId = "SORTMYCOLLONLINE";
  bool enableLogging = true;
  String saltKey = "099eb0cd-02cf-4e2a-8aca-3e6c6aff0399";
  String saltIndex = "1";
  String checkSum = "";
  String callBackUrl =
      "https://webhook.site/a53375c1-0ed6-432e-8c25-ad324fed6c2a";
  String body = "";
  Object? result;
  String apiEndPoint = "/pg/v1/pay";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    phonePeInit();
    body = getCheckSum().toString();
  }

  void phonePeInit() {
    PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
        .then((val) => {
              setState(() {
                result = 'PhonePe SDK Initialized - $val';
              })
            })
        .catchError((error) {
      handleError(error);
      return <dynamic>{};
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  void startPgTransaction() {
    try {
      var response = PhonePePaymentSdk.startPGTransaction(
          body, callBackUrl, checkSum, {}, apiEndPoint, "");
      response
          .then((val) => {
                setState(() {
                  if (val != null) {
                    String status = val["status"].toString();
                    String error = val["error"].toString();

                    if (status == "SUCCESS") {
                      result = "Success";
                    } else {
                      result = "Failed : $error";
                    }
                  }
                })
              })
          .catchError((error) {
        handleError(error);
        return <dynamic>{};
      });
    } catch (error) {
      handleError(error);
    }
  }

  getCheckSum() {
    var requestData = {
      "merchantId": merchantId,
      "merchantTransactionId": "transaction_123",
      "merchantUserId": "90223250",
      "amount": 1000,
      "mobileNumber": "9999999999",
      "callbackUrl": callBackUrl,
      "paymentInstrument": {
        "type": "PAY_PAGE",
      },
    };

    String base64Body = base64.encode(utf8.encode(json.encode(requestData)));

    checkSum =
        "${sha256.convert(utf8.encode(base64Body + apiEndPoint + saltKey)).toString()}###$saltIndex";

    return checkSum;
  }

  void handleError(error) {
    setState(() {
      result = {"error": error};
    });
  }
}

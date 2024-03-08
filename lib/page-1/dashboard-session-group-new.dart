import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiffy/jiffy.dart';
import 'package:myapp/home_page/homepagecontainer_2.dart';
import 'package:myapp/other/api_service.dart';
import 'package:myapp/shared/app_const.dart';
import 'package:myapp/utils.dart';

import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../model/counsellor_sessions.dart';
import '../other/provider/counsellor_details_provider.dart';
import 'dart:developer' as console show log;

class Counseling_Session_group extends StatefulWidget {
  const Counseling_Session_group(
      {super.key, required this.name, required this.id});

  final String name;
  final String id;

  @override
  State<Counseling_Session_group> createState() =>
      _Counseling_Session_groupState();
}

class _Counseling_Session_groupState extends State<Counseling_Session_group>
    with SingleTickerProviderStateMixin {
//phone pe  members
// SANDBOX
// PRODUCTION
  String environment = "PRODUCTION";
  String appId = "";
  String merchantId = "SORTMYCOLLONLINE";
// PGTESTPAYUAT
// SORTMYCOLLONLINE
  bool enableLogging = true;
  String saltKey = "fd064c88-80c4-4ef1-bf9f-0628189916a5";
  String saltIndex = "2";
  String checkSum = "";
  String callBackUrl = "https://webhook.site/a53375c1-0ed6-432e-8c25-ad324fed6c2a";
  String body = "";
  Object? result;
  String apiEndPoint = "/pg/v1/pay";
  String? packageName = 'com.sortmycollege';

  //widget members
  bool isExpanded = false;
  SessionDate sessionDate = SessionDate();
  String selectedDate = Jiffy.now().format(pattern: "d MMM");
  String selectedSessionDate = Jiffy.now().format(pattern: "dd/M/yyyy");

  late Razorpay razorpay;
  TextEditingController amountController = TextEditingController();

  void startPgTransaction(String? id, String? sessionDate, sessionPrice) {
   /* try {
      body = getCheckSum(sessionPrice);
      var response = PhonePePaymentSdk.startTransaction(
          body, callBackUrl, checkSum, packageName);
      response.then((val) {
        setState(() {
          if (val != null) {
            String status = val["status"].toString();
            String error = val["error"].toString();
            if (status == "SUCCESS") {
              AppConst1.showToast("Payment Successfully");
              EasyLoading.show(
                  status: "Loading...",
                  dismissOnTap: false);
              ApiService.sessionBooked(
                  id!)
                  .then((value) {
                if (value["message"] ==
                    "Counseling session booked successfully") {
                  EasyLoading.showToast(
                      value["message"],
                      toastPosition:
                      EasyLoadingToastPosition.bottom);
                  context
                      .read<CounsellorDetailsProvider>()
                      .fetchCounsellor_session(
                      id: widget.id);
                  var date = Jiffy.parse(
                      sessionDate!)
                      .format(
                      pattern: "yyyy-M-d");
                  context
                      .read<CounsellorDetailsProvider>()
                      .fetchCounsellor_session(
                      id: widget.id,
                      sessionType: "Group",
                      date: date);
                  setState(() {});
                } else {
                  EasyLoading.showToast(
                      value["error"],
                      toastPosition:
                      EasyLoadingToastPosition.bottom);
                }
              });
            } else {
              AppConst1.showToast("Transaction failed please try again $error");
              print('Error:    ${error}');
            }
          }
        });
      }).catchError((error) {
        handleError(error);
        AppConst1.showToast("Transaction failed please try again $error");
        print('Error:    ${error}');
        return <dynamic>{};
      });
    } catch (error) {
      handleError(error);
      AppConst1.showToast("Transaction failed please try again $error");
    }*/
  }


  void openCheckOut(amount) async {
    amount = amount * 100;
    var options = {
      "key": "rzp_test_1DP5mmOlF5G5ag",
      "amount": amount,
      "name": "Sort My College",
      "theme.color": "#0xff1f0a68",
      "currency": "INR",
      "image" : "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAoHCBIVEhgSFhQZGBgaGBgcGhoZGhoaGhgYGhwZHBwaGhkdIS4lHR4rHxgZJjgmKy8xNTU1HCQ7QDszPy40NTEBDAwMEA8QHhISHjUsJCc2ODExPz82NDQ7NDExNjE0ND8+MTQ0MTQ1PTQ0ND80NDQ0MTQ9NDQ0NDQxNEA0NDQ0NP/AABEIAIoBbAMBIgACEQEDEQH/xAAcAAEAAgIDAQAAAAAAAAAAAAAABgcEBQEDCAL/xABJEAACAQMBBAQICQkHBQEAAAABAgADBBEFBhIhMQdBUXETIlJhgZGT0RQXMjVTVKGxshUWI0JicnOzwTZ0g5KiwvAzNEPS4YL/xAAaAQEAAgMBAAAAAAAAAAAAAAAAAgUBAwYE/8QAJxEBAAICAQQBAwUBAAAAAAAAAAECAxEEBSExQXESIlEjMoGRsRP/2gAMAwEAAhEDEQA/ALmiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiJ8O4AJJwBzMD6iVJtb0m1FrinZlSiHxnYZDkc1XsHnk72T2no31EVEOHGA6Hmrf1Hnm/JxcuOkXtHaWdJDERNDBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQOJxmJrdX1VLdd5uJPJRzJhKtLXtFaxuZbOJqdG1lLhcjxWHNTzHvm1EF6Wpaa2jUw+oifDsACScAQi4dwASTgDmZT/SHtuau9a27Yp8ncc37VU+T5+ud+322Zq71tbtimMh2HAv5h+z98rarL3p3T/GTJHxCdYYrTN0XV61pWWvSbDDmOpl61YdYmE0+TLnJSLRNbeJZl6Q2S2no31EOhw4wHQnih/qOwyQzy7oOrVra4StSYqwYA9jKTxVh1ien6TZUHtAP2Tledxf+F+3ifCEolt5tvS06mo3fCVnB3KecDA/WY9Q++VBedKmrVGJSotMdSogOB3tkmZPTbRqDU99gd1qSbh6sDIIHp++SPYDbbR6FpToVUFOqowzGlvB28reAJ4+eeNhErPpT1amwLVVqDrV0XiO9cES4NgtuKWoow3fB1kALpnIIP6ynrH3TB1uro+o2z0ada1NRlO4xKqyv1HOARNL0f8AR3eWN6t01akybjqwQsSQwGMcMcwPVAmG2m2dvp1MM/jVGzuUweLY6z5K+eU5qfS1qdRiUZKK9QRASB5y2czSbdam93qVZyScVDTQdiq26oHfz9MvrZbYmytaCL4BHqboLVHUMxYjJ4kcBnqECmLTpT1ZDk11cdjouD/lwZaewfSRRvmFCoopV+pc+K+PJJ6/NJNqey9jcIUqW1MgjmEUMPOGAyDPNeu2T6fqL00Y71CqCjdeBhlPqIgXP0tbU3dgtubd1XwhcNlQ2d0Ljn3ytfjX1f6ZPZrJD0xXwr2en1x/5EZvSyoT9s3XQjZUXsapemjHwxGWVWON1esiBBR0sat9Kh/w1ku2R6XneqtG8RAGIUVUyApJwN9SeXnEtGrpFoVIa3o4xxzTTGPVPL+1VCkt/Xp2+DTFVlpheIxnkvmzkQLJ6Rdv9QtNQehQqKKYRCAUVvlKCeMi/wAa+r/TJ7NZfWnaZTahSNWkjOKdMMWVWOQoBySJDemKxoppbMlJEbwlPiqKp+V2gQK3+NfV/pU9ms77LpS1VqtNTVTDOgP6NeRYAzZ9BVrTqV7kOiuBTTG8obHjHlkS6RpVsOIoU/8AIvugZi8hKA2h6TNUpXdeklVAqVXVRuKcKrEDj3T0DPKG09ItqdwgOC1zUXPZlyP6wLs6Kts6l9TqU7hlNam2eAC7yNyOPMcj1Sw55Z2W1R9N1JXbhuVGp1R2oTuv92fQJ6hp1VZQ4IIIDA9RBGQfVAhPSltc1hbIKTAV6jYTIB3VXBZiD3gemVjp3Sjqr1qaNVTdaoin9GvIsAfsM1nSDrbX+pP4M7yBhSpDtAOMj95iT6ppLS1NK+SkSCUuEUkcsq4B+0QLT6RNqtX0+63VqqaFQb1NjTU4HWpPlD7iJKujLbP4fQKVCPhFP5YHDfU8nA+wzc7ZbOU7+0e3YANjept5FQA7p7uo+YzzpoupXGmX4fBV6TFaiHhvLnDKfMeY9BgepLu5SlTaq7BURSzMeQA4kyhdQ6VtSqXLC3KqjNu003AzEZwvE8ST/WZ/Svt5TuKVO0tnzTdVeqwPPOCtM93Mjunf0MbH7zflGsviqSKCkc266no5D0wLX2ep3Itqfwlw9YrlyoChSeO6AOzlmQfX9o9zVattVv3tUFOkaQUU9wswJbfdkO71c5ZkqnWadE67cNVtVrbtCgQ1RkWnR4HxnL+KSTjHPiIGVoes3f5Xo2rVa7U3pVHPhfAlamB4r02pjivAyzZUmjbx163Y+EO9QqlXeolVGTHDwRpgKqjiMY5y24CIiBxETFvbjcps+M4BIHaYZiJmdQxdZ1ZKCbx4sfkr1kyub69es5djknl2Adgi/u3quXc5PZ2DsEx5qtbbp+Dwq4a/VPeZd1pdNSYOpww+3zGWLoesJcJ2OPlD+o80rWdlpdPSYOrYI/5gxW2kubwq567jtaPC2mYAZPACVdtxtcau9bUGwnJnHNu0D9n742k2tqV6YpIN1SPHIPFj1gfsyE1p0PTuBE6y3/iHNWxWpaa3jUwwqswa0zqswa0vSGK0+cTsK5nw0TDEuaJw6n9pfvnqq3+Qv7o+4Ty1p9q9WqlNFLszABRzPGepqC4VQeoAfZOf6xMfVWPlCUH2/wBR0Zj8Evnw4AdSFfeTOQCGUeblIdT6IqFxSWvaXxNNxvL4SnzHoIP2Tc9MOxta53Lygpd0XdqIPlMnEhgOsjJ4eeVvoe3mpWKfB0Ybqk4SomSnaBnBHHqlMw2mt9E2oUEaqrU6qqpZt0lWwOJwp5+uZXRDtXXp3iWTuzUauVVWOdxgCQVJ5DgRiazUulLVK9NqRamqsCDuJgkHgQCSZvOiHY2u10t/VRkp0wSm8CpdyMAgH9UAnj3QIFrNNqGoVQ4IKXDkjzByftE9U2NwtSklRSCrKrAjkQQDKt6Vuj+pXc31qmXx+lQc2wODr2nGAR5pXGkbZanYjwKVXRV/8dRche4MMrA9RGeW+ki8WtqtzUQgrvhQRyO4qqftUzM1DpJ1auhpmvuhuB8GiqSD1ZAz6pt+jno8r3FZLm5RqdBGDBWBDVCCCAFPHdzzMDu6TbVqWmaXTb5S0sHv3UP9ZHNldldTu6TVLUkIH3TirueNgHlnsIk76feCWo89T7lm16CPm+p/HP4VgVVtJpGqWe6tyaqq/AHwhdG7RkHGfMZO+iTZ/Sq58OC73FIglKmAEPUyhflDPWZZO2mgLe2VS3ON4jeQ+TUXip7uo+YzzvsnrNTTr9ajAjcYpVXr3c4dcdoxn0QPVEr/AKavmlv4lP8AFJzbV1dFqIQVYBlI5EEZBkG6avmlv4lP8UCHdAH/AHF1/DT8Rl4yjugD/uLr+Gn4jLxgJ5T2h+da396f+ZPVk8p7Q/Otb+9P/MgSvpn2e8DdLeIPErjxvNVUcfWMH0GbTStuNzZ10Lfp0PwdO3dceKw7k3v8ssfbjQRe2D0MePu79M9lRRlfXxHpnnn8y9T5fAq/+QwJF0O7P/CL8V2Gadvhj2FzkIPWCfQJGq3zof74f5s9B9HOzvwKwSmy4qP49Tt326j3DA9E891vnRv72f5sD1eJUPTXsmGp/lGmAGTdWsPKUnCv3gkDuPmlvCRDpW+Z7n91PxpAoXYjZ1r+8S3Bwnyqh7Kakb2POeAHfPUVpapSprSRQqIoVVHIKBgCUJ0F/OT/AMB/xJPQcBKh2soirqd9auj+BqW1u9SohUGl4LLqcNgEE5GOfKW9KS6QdSt01K7tbjfWlcUbbL0wC6NSyy+KeYOSDAztlqfg9VsbZEcUadtXam7lSaoqeOzDdJAAPDHVLflN7GMo1DT6dJX8AlvdeDqVN3fqbzEuSqk7gBwADLkgIiIHEwNY/wCi/dM+YGsf9F+6E8f76/Kvr+2B8Yc/vmum7uJqrheuaZddgtOtSxyZg3NxnxRy7e2Lm4z4o5TFnrw4NfdZ76U9yTDuUxMycOgIwZa8bk2xW16eTn8GnIruO0x4aSrMXwRY4+2bSpZtvY6u2cVECjAl9W9bxFo8OSyUtS01tGphqqqADAnVaWj1qi0qalnY4VRzJ90zqVpUrVFpU1LuxwFH/OA88uvYfY6lYpvNhq7Dxn8keSvYPP1zx83m149fzafENcz2fOwuxlOxTfbD12HjP1KPJTsHn65MYictkyWyWm1p3MtbmanVLCyIL3FOiR1tUVPxNMfa7aGnY2r3D8SOCL5Tn5K+/wA0rbRNkrzWMX1/XdaTcadJOGV6iByVfPjJkBMbfVNnqbeI9krZ5jwfPvxJbaXVOou9TdHXqKMGHrEhI6JNJxjwdTPb4Vs+6RXaLY260gG/0+u5RDl6bccL2kDg69uRmBdMwLzSbar/ANShTqfvIrH1kTX7G7QpfWlO5UYY+K6+TUX5Q7useYyBbUbSXmo3p0rT23EUkVqwJHI4bxhyUcuHEmBMq1bRbR8MbSi/dTDD+omx0/aWxrndpXVJ28lXXPqzIdp3Q/p6qPDtUrOflNvlAT5gOPrM51Hog09l/QNUouOKtvFwD1ZB4+owJ/c2VKpjwlNHxy3lDY7sjhOs/B7dC36OimeJ8VFyeHHkM8pWOy+0V5p16ulag2+jYFGqSTzOF8Y8SpxjjxBkj6Yvmet+/S/mLAmVvXR1FRGDKwyGUggjtBHOY9TSbZiWahTYk5JKKST2kkcZpejP5otf4f8AuaSmB1UqaqoVQFUDAAGAB2ADlMK/ubUstCs1Is+CtOoVJY9WEPObKVBt3/aOw/w/xtAtS2sKNMkpSRCeZRFXI8+BMuIgcEyOPe6OWLM9oWzkkmlnPaT25khq/JPcfulB9GOx1pqHwlq4clHULutu8G3s57eQgXQNpbD63Q9onvj85bD63Q9onvkU+KDSvJq+0Puj4oNK8mr7Q+6BOra5p1EDoyup5MpDKergRzmOdKtc7xoUs5zveDTOeec4+2dek6bRsrVaKErSphjljkgZLEk+kyq619fa9dPSt6jULGmcMwyC/fjizHmF5Ac4Fl3W1unUm3HvKKsOYNRcj1Gd1pq9jdqUStRrg81DI+e9ZErToh0tUAcVKjY4sahXJ7lwBMPV+iC23d+zq1KFUcVyxZSe/wCUveDAsS206gh3qdKmhxjKIqnHZkCfF7q1tRIWrWp0yRkB3VSR2jJkC6M9rbh6tTTLz/uKWd1jzcLwZWPWRwIPWJpemC1Wrqmn0nzuPuo2OB3WqgHB7jAs/wDOWw+t0PaJ75rL2totZzUqtZu5ABZ2pMcDkMmaf4oNK8mr7Q+6Pig0ryavtD7oEg0ilpfhB8HFsaiqceC3CyqflY3eIHGSGRTZvYGxsaxuKAqBihXxnLDdJBPDHmElkBERAT4dQRg8jPuIEO1/SSnjoMp1jyf/AJIrcS13UEYIyDINtNoZp5qIMp1jyf8A5ITX2u+n8yJmKXnv6lBimc458Z1MpHMTIp8z3zMQSwiezppv9LVzIt7NmPHgO2bNEHYJ3rM7ar5p9Q1mp0wqKoHDJmkp2tSq600Us7HAA/5ykkvrZ6hREUszMQAP+cpPtltmadqu8cNVYeM3Z+yvYPvllHNrx+PHu071Dk+oT+tLq2O2Tp2abzYesw8Z+z9lewffJTESiyZLZLTa07mVe5iIkBTvTJUNW9sbP9RnBYdpdwufVveuW7QoqiKijAVQAOwAYH3SoumOmaV9YXhHiKyhj2FHV8erPqlu0aqsqupyGAII6wRkGB2zD1O0FajUongKiOhPPG8CM46+czJiajdijRqVjxCIzEcshQTj7IEM0fQDo+l3eK3hCEqVQd3dwwp4A5nrUTUdBViBa17o8XqVd0nr3VAP4mJm503aH8saZd7lJqfiVKYBOd5imRgjvAmn6Cr0G0rWx4PTq7xHXusAOXerCBakRECrOnSxBtKNyOD06oUN14cHhnvUGd+314a2zYrHm6WzHvLJmdPTpegWdK3HF6lUMAOe6gPHHewE7tvbM0dmxRPNEtlPeHTP2wJH0Z/NFr/D/wBzSUyLdGfzRafw/wDc0lMBKg27/tHYf4f42lvyoNu/7R2H+H+NoFvxEQPir8k9x+6Uf0R7SWdmLoXFZaZd0K7wJyBv55DziXhV+Se4/dKQ6Itm7O7F0biitQo6Bd7PAHfzyPmECxfjF0j64nqf3R8YukfXE9T+6fXxd6T9Tp/6vfHxd6T9Tp/6vfA1/SXrK/kWpWotvLVWmqsOtXYZI/8Azmd/RRYLS0mgQONQNUY9pZjj1DA9Ex+k3SFGiVKNFd1aQpsqjqRGGQO5c+qZXRVfLV0m3weKKyMOwqx+8YPpgTAkCcb47R65pNq9nVvqK0Wq1KQVw29TIBJAIwc9XGRL4o6P167/AM6+6Bul2JpflX8qLWYOTk0wF3T+j3Dk8/PIZ0t10p6tp9RzuqhRmPYq1QSfUJrtL082e0lC0SvVqKvE775OWosxBA4dk2PS1QV9W0+m67yuUVgetWqgEeowJv8AGNpH1xPU/wD6x8YukfXE9T+6fXxd6T9Tp/6vfHxd6T9Tp/6vfA2Gi7T2d2zLb1lqFACwAYYBOAeIm7ml0bZqztGZregtMuAGK54gcQOJm6gIiICIiAnXUpgggjIPMTsiBXeu7IOjGpQG8p4lesd3aJHvBspwwKnsIxLiInTWtqbfKUHvE21yzHlbYOr5KVit43/qqUmxsdNq1ThVOPKPAD0ywU02iDkU1HoEylQDkJKc34hPL1aZj7K/21WjaOlAZ+U55ns8w7BNvOJzNMzMzuVRe9r2m1p3MuYiJhEiIgaDbHZynf2j2znB+UjeS4zunu44PmMrfQtsrrSMWGo0XZE4U6q8fF6gCeDr2dYlzzGu7OnVXcqIrqepgCPUYENHSvpG7nwz93g3z90iO0u21fVQdP06i5VyA7sMZXs7EXtJ4ywzsJpWd74FSz+7w9WcTe2djSpLuU6aovYihR9kDT7F7PLY2aWwOWHjO3lVGxvEebqHdIFtLs/d6Zetqlgpem5JrUh1Z4t4o5qTxGOIPmlvTgiBXWm9L2nOo8L4Si3WrIWHoZf6xqXS7pqKfBeErP1KqFQT1ZZv6SV6hsrp9dt6ra0nbtKAH1iNP2V0+g29StaSN2hAT6zAr3ZrQrzU75dUv03KSY8DSIPHByvinkoJzk8SZI+mL5nrfv0v5iyczHvLOlWQ06iK6HGVYZBxxGQYFW7FdJGm22n0Leq7h6abrAU2IzkngRz5ze/G3pH0lT2bSR/mnp31Oj7NfdH5p6d9To+zX3QNFZdKGl1aiUkdyzsqrmmwG8xwMnqkO6TL5KGu2ldyQiKjMQMnAds4HXLQpbM2CsHW1pKykEEIoII5EGd9/olrXYNWoU6jAYBdQxA7MmBE/jb0j6Sp7No+NvSPpKns2kj/ADT076nR9mvuj809O+p0fZr7oGLs7thZ34qLbszGmoLbyFcBt7GM8/kmVP0X7YWdh8JW4Z1LupXdQtkLvZzjlzEu3T9ItqG94GilPexvbihd4DOM458zMQ7K6fz+CUfZr7oEc+NvSPpKns2j429I+kqezaSP809O+p0fZr7o/NPTvqdH2a+6B36bf0L21FVPGpVVYeMMZXJVgQe4ypzTvNnrp2Sm1axqNk4/V7Mn9VwOGTwIxLjtLWnSQU6aKiLyVRgDJzwAna6AgggEHmDxB9ECB2fS1pTqCzvTPWrIxx6VyDOm76VbVyKVlRq3NZuCqFKLnqJJ449EklzsTplRi7WdIseZ3cZ9U2WmaNbW43aFBKY/ZUD7ecCnLLT6tHaS08O2/XqIatUjl4R0q+Kv7KgKo7pm9L9ylLVNPqv8hN12wMndWqCeHXwEtl9NoNVFc0kNRRhahUbwHEYDc+s+udeoaNa1yGrUEqFRgF1DEDsGYES+NvSPpKns2j429I+kqezaSP8ANPTvqdH2a+6PzT076nR9mvugYGzu3dhe1jQt3dnCFsMjKMAgHif3hJVNZY6FaUX8JSoU0bBG8iBTg8xkdXCbOAiIgIiICIiAnE5iAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgf//Z",
      "Prefill": {
        "contact": '1234567890',
        "email": "test@gmail.com",
      },
      // "external": {
      //   "wallets": ["Paytm"]
      // }
    };
    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint('Error : $e');
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Success ${response.paymentId!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Fail ${response.message!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "External Wallet ${response.walletName!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void PhonePayInit() {
   /* PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
        .then((val) => {
      setState(() {
        result = 'PhonePe SDK Initialized - $val';
        print(result);
        //handleException: Invalid appId!
      })
    })
        .catchError((error) {
      handleError(error);
      return <dynamic>{};
    });*/
  }
  // void startPgTransaction() {
  //   try {
  //     body = getCheckSum();
  //     var response = PhonePePaymentSdk.startTransaction(
  //         body, callBackUrl, checkSum, packageName);
  //     response.then((val) {
  //       setState(() {
  //         if (val != null) {
  //           String status = val["status"].toString();
  //           String error = val["error"].toString();
  //         }
  //       });
  //     }).catchError((error) {
  //       handleError(error);
  //       AppConst1.showToast("Transaction failed please try again $error");
  //       print('Error:    ${error}');
  //       return <dynamic>{};
  //     });
  //   } catch (error) {
  //     handleError(error);
  //     AppConst1.showToast("Transaction failed please try again $error");
  //   }
  // }

  // getCheckSum(sessionPrice) {
  //   var requestData = {
  //     "merchantId": merchantId,
  //     "merchantTransactionId": "transaction_123",
  //     "merchantUserId": "90223250",
  //     "amount": 100,
  //     "mobileNumber": "9999999999",
  //     "callbackUrl": callBackUrl,
  //     "paymentInstrument": {
  //       "type": "PAY_PAGE",
  //     },
  //   };
  //   String base64Body = base64.encode(utf8.encode(json.encode(requestData)));
  //   checkSum =
  //   "${sha256.convert(utf8.encode(base64Body + apiEndPoint + saltKey)).toString()}###$saltIndex";
  //
  //   return base64Body;
  // }

  getCheckSum(int sessionPrice) {
   int price = int.parse(sessionPrice.toString());
   price * 100;
  // String strPrice = price.toString();
   String strPrice = '1';
    var requestData = {
      "merchantId": merchantId,
      "merchantTransactionId": "transaction_123",
      "merchantUserId": "90223250",
      "amount": strPrice,
      "mobileNumber": "9999999999",
      "callbackUrl": callBackUrl,
      "paymentInstrument": {
        "type": "PAY_PAGE",
      },
    };
    String base64Body = base64.encode(utf8.encode(json.encode(requestData)));
    checkSum =
        "${sha256.convert(utf8.encode(base64Body + apiEndPoint + saltKey)).toString()}###$saltIndex";

    return base64Body;
  }

  void handleError(error) {
    setState(() {
      result = {"error": error};
    });
  }

  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);

    PhonePayInit();
    // body = getCheckSum();
    sessionDate.getDates();
    tabController =
        TabController(length: sessionDate.dates.length, vsync: this);
    configLoading();
    fetchDataFromApi();
    context
        .read<CounsellorDetailsProvider>()
        .fetchCounsellor_session(id: widget.id);
  }

  void configLoading() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..displayDuration = const Duration(milliseconds: 1000)
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..maskType = EasyLoadingMaskType.none
      ..radius = 10.0
      ..maskColor = Colors.black.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  void fetchDataFromApi() {
    var date = Jiffy.now().format(pattern: "yyyy-M-d");
    context.read<CounsellorDetailsProvider>().fetchCounsellor_session(
        id: widget.id, date: date, sessionType: "Group");
  }

  @override
  Widget build(BuildContext context) {
    var counsellorSessionProvider = context.watch<CounsellorDetailsProvider>();
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return counsellorSessionProvider.isLoading
        ? const Center(child: CircularProgressIndicator())
        : Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xffffffff),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            // frame12Fje (1879:51)
            width: double.infinity,
            height: 100,
            child: Stack(
              children: [
                Positioned(
                  // frame311tGg (2620:3569)
                  left: 14 * fem,
                  top: 20,
                  child: SizedBox(
                      width: 400 * fem,
                      height: 45 * fem,
                      child: TabBar(
                          indicatorColor: const Color(0xff1F0A68),
                          indicatorWeight: 3,
                          controller: tabController,
                          isScrollable: true,
                          tabs: sessionDate.dates.map((e) {
                            return GestureDetector(
                              onTap: () {
                                tabController.animateTo(e.index);
                                String date = Jiffy.parse(e.date,
                                    pattern: "d MMM yyyy")
                                    .format(pattern: "yyyy-M-d");
                                selectedSessionDate = Jiffy.parse(date)
                                    .format(pattern: "dd/M/yyyy");
                                console.log(date);
                                selectedDate = e.formattedDate;
                                context
                                    .read<CounsellorDetailsProvider>()
                                    .fetchCounsellor_session(
                                    id: widget.id,
                                    date: date,
                                    sessionType: "Group");
                                context
                                    .read<CounsellorDetailsProvider>()
                                    .fetchCounsellor_session(
                                    id: widget.id);
                              },
                              child: SizedBox(
                                // group310VQt (2620:3574)

                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    // crossAxisAlignment:
                                    //     CrossAxisAlignment
                                    //         .center,
                                    children: [
                                      Center(
                                        // today21octT6p (2620:3575)
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(
                                              0 * fem,
                                              0 * fem,
                                              7 * fem,
                                              0 * fem),
                                          child: Text(
                                            '${e.index == 0 ? "Today" : e.index == 1 ? "Tomorrow" : e.day}, ${e.formattedDate}',
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 12 * ffem,
                                              fontWeight: FontWeight.w700,
                                              height: 1.2125 * ffem / fem,
                                              letterSpacing:
                                              0.59375 * fem,
                                              color: e.day == "Sun"
                                                  ? Colors.red
                                                  : const Color(
                                                  0xff000000),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        // noslotskrc (2620:3576)
                                        child: Text(
                                          isDateIsSame(
                                              e.formattedDate,
                                              counsellorSessionProvider
                                                  .allDetails
                                                  .sessions ??
                                                  [])
                                              ? slotCount(
                                              e.formattedDate,
                                              counsellorSessionProvider
                                                  .allDetails
                                                  .sessions ??
                                                  []) ==
                                              ""
                                              ? "No Slots"
                                              : "${slotCount(e.formattedDate, counsellorSessionProvider.allDetails.sessions ?? [])} Slots"
                                              : "No Slots",
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont('Inter',
                                              fontSize: 12 * ffem,
                                              fontWeight: FontWeight.w700,
                                              height: 1.2125 * ffem / fem,
                                              letterSpacing:
                                              0.59375 * fem,
                                              color: isDateIsSame(
                                                  e.formattedDate,
                                                  counsellorSessionProvider
                                                      .allDetails
                                                      .sessions ??
                                                      [])
                                                  ? slotCount(
                                                  e
                                                      .formattedDate,
                                                  counsellorSessionProvider
                                                      .allDetails
                                                      .sessions ??
                                                      []) ==
                                                  ""
                                                  ? Colors.red
                                                  : Colors.green
                                                  : Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList())),
                ),
                Positioned(
                  // bookyourslotnzU (1779:1252)
                  left: 30 * fem,
                  top: 80.5 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 220 * fem,
                      height: 20 * fem,
                      child: Text(
                        'Book Your Group Slot',
                        style: SafeGoogleFont(
                          'Inter',
                          fontSize: 20 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.2125 * ffem / fem,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // IconButton(onPressed: (){
          //   startPgTransaction();
          // }, icon: Icon(Icons.add)),
          Expanded(
            child: counsellorSessionProvider
                .allDetails.totalAvailableSlots ==
                -1 ||
                counsellorSessionProvider
                    .details.totalAvailableSlots ==
                    -1
                ? Builder(builder: (context) {
              if (counsellorSessionProvider
                  .allDetails.totalAvailableSlots ==
                  -1 ||
                  counsellorSessionProvider
                      .details.totalAvailableSlots ==
                      -1) {
                EasyLoading.showToast(
                  "404 Page Not Found!",
                  toastPosition: EasyLoadingToastPosition.bottom,
                );
              }
              return const Center(
                child: Text("Something went wrong!"),
              );
            })
                : counsellorSessionProvider.details.sessions == null
                ? const Center(
              child: /*CircularProgressIndicator(
                               valueColor:AlwaysStoppedAnimation<Color>(Colors.red)
                            )*/
              Text("No Sessions Available"),
            )
                : counsellorSessionProvider.details.sessions!.isEmpty
                ? const Center(
              child: Text("No Sessions Available"),
            )
                : ListView.builder(
                itemCount: counsellorSessionProvider
                    .details.sessions!.length,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 19.5, vertical: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  'Coming soon',
                                  style: TextStyle(
                                    color: Color(0xFF1F0A68),
                                    fontSize: 20,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ),
                                Container(
                                  width: 45.51,
                                  height: 19,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFB1A0EA),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(99),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${counsellorSessionProvider.details.sessions![index].sessionAvailableSlots}/${counsellorSessionProvider.details.sessions![index].sessionSlots}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      selectedSessionDate,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      '2:00 PM - 03:00 PM',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Price - ${counsellorSessionProvider.details.sessions?[index].sessionPrice} /-',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        isExpanded = !isExpanded;
                                        setState(() {});
                                      },
                                      child: const Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'View Details',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w800,
                                              height: 0,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 15,
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    isExpanded
                                        ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Name : ${widget.name}"),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            "Slots : ${counsellorSessionProvider.details.sessions?[index].sessionSlots ?? "0"}"),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            "Duration : ${counsellorSessionProvider.details.sessions?[index].sessionDuration ?? "0"}"),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            "Session Status : ${counsellorSessionProvider.details.sessions?[index].sessionStatus ?? "N/A"}"),
                                      ],
                                    )
                                        : const SizedBox()
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () async{
                                    var availableSlots = counsellorSessionProvider.details.sessions![index].sessionAvailableSlots!;
                                    var totalAvailableSlots = counsellorSessionProvider.allDetails.totalAvailableSlots!;
                                    // call first create order api it success call razorpay with amount
                                    // after razorpay success call create payment api
                                    /*startPgTransaction(
                                      counsellorSessionProvider.details.sessions![index].id,
                                      counsellorSessionProvider.details.sessions![index].sessionDate,
                                      counsellorSessionProvider.details.sessions![index].sessionPrice,
                                    );*/

                                      var value =
                                          await    ApiService.counsellor_create_order(widget.name, 'abc@gmail.com', 1, 'test', '1234567890');
                                      if (value["error"] ==
                                          "Oder not successfully") {
                                        EasyLoading.showToast(value["error"],
                                            toastPosition:
                                            EasyLoadingToastPosition.bottom);
                                      } else{
                                        (value["message"] ==
                                            "Oder create  successfully");
                                        EasyLoading.showToast(value["message"],
                                            toastPosition:
                                            EasyLoadingToastPosition.bottom);
                                        counsellorSessionProvider.openCheckOut(10);
                                      }
                                    if (availableSlots >= 0) {
                                      EasyLoading.showToast('There are no booking slots available in this session, please book another session', toastPosition: EasyLoadingToastPosition.bottom);
                                    } else if (availableSlots <= totalAvailableSlots) {
                                      /* call first create order api it success call razorpay with amount
                                       after razorpay success call create payment api*/
                                      /*startPgTransaction(
                                        counsellorSessionProvider.details.sessions![index].id,
                                        counsellorSessionProvider.details.sessions![index].sessionDate,
                                        counsellorSessionProvider.details.sessions![index].sessionPrice,
                                      );*/
                                    } else{
                                      EasyLoading.showToast('There are no booking slots available in this session, please book another session', toastPosition: EasyLoadingToastPosition.bottom);
                                    }
                                  },
                                  child: Container(
                                    width: 96,
                                    height: 38,
                                    decoration: ShapeDecoration(
                                      color: counsellorSessionProvider.details.sessions![index].sessionAvailableSlots! > 0
                                          ? const Color(0xFF1F0A68)
                                          : const Color(0xFF1F0A68),
                                      shape: RoundedRectangleBorder(
                                        // side: const BorderSide(width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Book',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                  // return Container(
                  //   // group193fip (I2510:2510;2510:2244)
                  //   margin: EdgeInsets.fromLTRB(
                  //       10 * fem, 0 * fem, 10 * fem, 0 * fem),
                  //   padding: EdgeInsets.fromLTRB(
                  //       5 * fem, 0.5 * fem, 5 * fem, 16 * fem),
                  //   width: double.infinity,

                  //   child: Column(
                  //     crossAxisAlignment:
                  //         CrossAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //         width: 350,
                  //         height: 130,
                  //         decoration: ShapeDecoration(
                  //           color: Colors.white,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius:
                  //                 BorderRadius.circular(20),
                  //           ),
                  //           shadows: const [
                  //             BoxShadow(
                  //               color: Color(0x3F000000),
                  //               blurRadius: 5,
                  //               offset: Offset(0, 0),
                  //               spreadRadius: 0,
                  //             )
                  //           ],
                  //         ),
                  //         child: Row(
                  //           mainAxisSize: MainAxisSize.min,
                  //           mainAxisAlignment:
                  //               MainAxisAlignment.center,
                  //           crossAxisAlignment:
                  //               CrossAxisAlignment.center,
                  //           children: [
                  //             Container(
                  //               width: 330,
                  //               height: 150,
                  //               child: Stack(
                  //                 children: [
                  //                   Positioned(
                  //                     left: 0,
                  //                     top: 0,
                  //                     child: Container(
                  //                       width: 350,
                  //                       height: 131,
                  //                     ),
                  //                   ),
                  //                   Positioned(
                  //                     left: 230,
                  //                     top: 70,
                  //                     child: Container(
                  //                       width: 96,
                  //                       height: 38,
                  //                       child: Stack(
                  //                         children: [
                  //                           Positioned(
                  //                             left: 0,
                  //                             top: 0,
                  //                             child: Container(
                  //                               width: 96,
                  //                               height: 38,
                  //                               decoration:
                  //                                   ShapeDecoration(
                  //                                 color: const Color(
                  //                                     0xFF1F0A68),
                  //                                 shape:
                  //                                     RoundedRectangleBorder(
                  //                                   side: const BorderSide(
                  //                                       width:
                  //                                           1),
                  //                                   borderRadius:
                  //                                       BorderRadius.circular(
                  //                                           10),
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           ),
                  //                           const Positioned(
                  //                             left: 24,
                  //                             top: 7,
                  //                             child: Text(
                  //                               'Book',
                  //                               textAlign:
                  //                                   TextAlign
                  //                                       .center,
                  //                               style:
                  //                                   TextStyle(
                  //                                 color: Colors
                  //                                     .white,
                  //                                 fontSize: 18,
                  //                                 fontFamily:
                  //                                     'Inter',
                  //                                 fontWeight:
                  //                                     FontWeight
                  //                                         .w600,
                  //                                 height: 0,
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   const Positioned(
                  //                     left: 19.01,
                  //                     top: 63,
                  //                     child: SizedBox(
                  //                       width: 174.98,
                  //                       child: Text(
                  //                         '2:00 PM - 03:00 PM',
                  //                         style: TextStyle(
                  //                           color: Colors.black,
                  //                           fontSize: 12,
                  //                           fontFamily: 'Inter',
                  //                           fontWeight:
                  //                               FontWeight.w400,
                  //                           height: 0,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   //updated
                  //                   Positioned(
                  //                     left: 19.01,
                  //                     top: 81,
                  //                     child: SizedBox(
                  //                       width: 78.89,
                  //                       child: Text(
                  //                         'Price - ${counsellorSessionProvider.details.sessions![index].sessionPrice} /-',
                  //                         textAlign:
                  //                             TextAlign.center,
                  //                         style:
                  //                             const TextStyle(
                  //                           color: Colors.black,
                  //                           fontSize: 12,
                  //                           fontFamily: 'Inter',
                  //                           fontWeight:
                  //                               FontWeight.w500,
                  //                           height: 0,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Positioned(
                  //                     left: 18,
                  //                     top: 98,
                  //                     child: SizedBox(
                  //                       width: 97,
                  //                       height: 17,
                  //                       child: Stack(
                  //                         children: [
                  //                           Positioned(
                  //                             left: 80,
                  //                             top: 17,
                  //                             child: Transform(
                  //                               transform: Matrix4
                  //                                   .identity()
                  //                                 ..translate(
                  //                                     0.0, 0.0)
                  //                                 ..rotateZ(
                  //                                     -1.57),
                  //                               child:
                  //                                   Container(
                  //                                 width: 17,
                  //                                 height: 17,
                  //                                 decoration:
                  //                                     const BoxDecoration(
                  //                                   image:
                  //                                       DecorationImage(
                  //                                     image: AssetImage(
                  //                                         'assets/page-1/images/arrow-down-2.png'),
                  //                                     fit: BoxFit
                  //                                         .fill,
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           ),
                  //                           Positioned(
                  //                             left: 0,
                  //                             top: 1,
                  //                             child: SizedBox(
                  //                               width: 150,
                  //                               child:
                  //                                   GestureDetector(
                  //                                 onTap: () {
                  //                                   isExpanded =
                  //                                       !isExpanded;
                  //                                 },
                  //                                 child: Column(
                  //                                   crossAxisAlignment:
                  //                                       CrossAxisAlignment
                  //                                           .start,
                  //                                   children: [
                  //                                     Text(
                  //                                       'View Details',
                  //                                       textAlign:
                  //                                           TextAlign.left,
                  //                                       style:
                  //                                           TextStyle(
                  //                                         color:
                  //                                             Colors.black,
                  //                                         fontSize:
                  //                                             12,
                  //                                         fontFamily:
                  //                                             'Inter',
                  //                                         fontWeight:
                  //                                             FontWeight.w800,
                  //                                         height:
                  //                                             0,
                  //                                       ),
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Positioned(
                  //                     left: 19.01,
                  //                     top: 15,
                  //                     child: Container(
                  //                       width: 352.99,
                  //                       height: 24,
                  //                       child: Stack(
                  //                         children: [
                  //                           Positioned(
                  //                             left: 260.47,
                  //                             top: 3,
                  //                             child: Container(
                  //                               width: 45.51,
                  //                               height: 19,
                  //                               child: Stack(
                  //                                 children: [
                  //                                   Positioned(
                  //                                     left: 0,
                  //                                     top: 0,
                  //                                     child:
                  //             Container(
                  //           width:
                  //               45.51,
                  //           height:
                  //               19,
                  //           decoration:
                  //               ShapeDecoration(
                  //             color:
                  //                 const Color(0xFFB1A0EA),
                  //             shape:
                  //                 RoundedRectangleBorder(
                  //               borderRadius:
                  //                   BorderRadius.circular(99),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       Positioned(
                  //         left: 5,
                  //         top: 2,
                  //         child:
                  //             Text(
                  //           '${counsellorSessionProvider.details.sessions![index].sessionAvailableSlots}/${counsellorSessionProvider.details.sessions![index].sessionSlots}',
                  //           style:
                  //               const TextStyle(
                  //             color:
                  //                 Colors.white,
                  //             fontSize:
                  //                 13,
                  //             fontFamily:
                  //                 'Inter',
                  //             fontWeight:
                  //                 FontWeight.w500,
                  //             height:
                  //                 0,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // ),
                  //                           const Positioned(
                  //                             left: 0,
                  //                             top: 0,
                  //                             child: SizedBox(
                  //                               width: 198.24,
                  //                               child: Text(
                  //                                 'Coming soon',
                  //                                 style:
                  //                                     TextStyle(
                  //                                   color: Color(
                  //                                       0xFF1F0A68),
                  //                                   fontSize:
                  //                                       20,
                  //                                   fontFamily:
                  //                                       'Inter',
                  //                                   fontWeight:
                  //                                       FontWeight
                  //                                           .w600,
                  //                                   height: 0,
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Positioned(
                  //                     left: 19.01,
                  //                     top: 43,
                  //                     child: SizedBox(
                  //                       width: 67.77,
                  //                       height: 16,
                  //                       child: Text(
                  //                         selectedDate,
                  //                         textAlign:
                  //                             TextAlign.center,
                  //                         style:
                  //                             const TextStyle(
                  //                           color: Colors.black,
                  //                           fontSize: 12,
                  //                           fontFamily: 'Inter',
                  //                           fontWeight:
                  //                               FontWeight.w400,
                  //                           height: 0,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // );
                }),
          ),
        ],
      ),
    );
  }

  callme() async {
    await Future.delayed(const Duration(seconds: 3));
    const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.red));
  }

  Future<bool> _onBackPressed() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePageContainer_2()),
    );
    return true;
  }
}

List<String> sampleViewDetails = [
  "\u2022 name:",
  "\u2022 slots:",
  "\u2022 duration:",
];

bool isDateIsSame(String date, List<Sessions> sessions) {
  for (final element in sessions) {
    var apiDate = Jiffy.parse(element.sessionDate!).format(pattern: "d MMM");
    if (date.contains(apiDate)) {
      // console.log("yess");
      return true;
    }
  }
  //console.log("nope");

  return false;
}

String slotCount(String date, List<Sessions> sessions) {
  for (final element in sessions) {
    var apiDate = Jiffy.parse(element.sessionDate!).format(pattern: "d MMM");

    if (element.sessionType == "Group") {
      if (date.contains(apiDate)) {
        return element.sessionAvailableSlots.toString();
      }
    }
  }

  return "";
}

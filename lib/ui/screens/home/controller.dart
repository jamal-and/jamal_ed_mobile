import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jamal_ed/core/api/api_request.dart';
import 'package:jamal_ed/core/api/api_routes.dart';
import 'package:jamal_ed/core/api/keys.dart';
import 'package:jamal_ed/core/api/log.dart';
import 'package:jamal_ed/core/controllers/userController.dart';
import 'package:jamal_ed/core/helpers/ui_helper.dart';
import 'package:jamal_ed/core/utils/keys.dart';

class HomeController extends GetxController {
  int selectedIndex = 0;
  List numbers = [];
  List transactions = [];
  List topupOptions = [5, 10, 20, 30, 50, 75, 100];
  Map transactionsTotalsPerBeneficiaries = {};
  Map userData = Get.find<Usercontroller>().userData!;
  Usercontroller usercontroller = Get.find<Usercontroller>();

  @override
  void onInit() {
    super.onInit();
    // usercontroller.getUserData().then(
    //   (value) {
    //     refreshUserData();
    //   },
    // );
    refreshUserData();
  }

  void refreshUserData() {
    consoleLogPretty(userData, key: kUserData);
    userData = usercontroller.userData!;
    numbers = userData[kContacts][kValues];
    transactions = userData[kTransactions][kValues];
    update();
  }

  updateSelectedIndex(int v) {
    selectedIndex = v;
    update();
  }

  bool didReachLimit({required num valueToBeAdded, required num contactId}) {
    if (valueToBeAdded + 1 > userData[kCredit]) {
      showErrorMessage(
        message: 'You don\'nt have enough credit',
      );
      return true;
    }
    num limit = userData['emailConfirmed'] ? 1000 : 500;
    num totalOfMonth = 0;
    transactionsTotalsPerBeneficiaries = {};
    consoleLogPretty(transactions);
    for (var i in transactions) {
      int currentMonth = DateTime.now().month;
      int currentYear = DateTime.now().year;
      DateTime itemDate = DateTime.parse(i[kDate]);
      // consoleLog(
      //     'current $currentYear/$currentMonth and ItemDate is ${itemDate.year}/${itemDate.month}');
      if (itemDate.year == currentYear && itemDate.month == currentMonth) {
        transactionsTotalsPerBeneficiaries[i[kContactId]] ??= 0;
        transactionsTotalsPerBeneficiaries[i[kContactId]] += i[kTotal];
        consoleLog(
            'id:$contactId and total is ${transactionsTotalsPerBeneficiaries[contactId]}');
        if ((transactionsTotalsPerBeneficiaries[contactId] ?? 0) >= limit) {
          consoleLog(
              'id:$contactId and total is ${transactionsTotalsPerBeneficiaries[contactId]}');
          showErrorMessage(
            message: 'You reached your monthly limit for this beneficiaries',
          );
          return true;
        }
        totalOfMonth += i[kTotal];
        //consoleLog('Total is $totalOfMonth and Limit is $limit');
        if (totalOfMonth + valueToBeAdded >= 3000) {
          consoleLog(transactionsTotalsPerBeneficiaries);
          showErrorMessage(message: 'You reached your monthly limit');
          return true;
        }
      }
    }
    consoleLog(transactionsTotalsPerBeneficiaries);
    return false;
  }

  topUp(num id, num amount) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(DateTime.now());
    ApiRequest(
      path: apiTopup(),
      method: postMethod,
      queryParameters: {
        // 'userId': getUserId(),
        'contactId': id,
      },
      body: {
        'total': amount,
        'transactions': [],
        kDate: formatted,
      },
    ).request(
      onSuccess: (data, response) {
        usercontroller.getUserData().then(
          (value) {
            Get.back();
            showSuccessMessage(message: 'Recharged succefully');
            userData = usercontroller.userData!;
            update();
          },
        );
      },
    );
  }

  addNumber({required String name, required String number}) {
    ApiRequest(
      path: apiAddContact(),
      method: postMethod,
      body: {
        kNickname: name,
        kPhoneNumber: number.replaceAll(RegExp(r"\D"), ''),
      },
    ).request(
      onSuccess: (data, response) {
        numbers.add({
          kNickname: name,
          kPhoneNumber: number,
        });
        update();
        usercontroller.getUserData().then((value) {
          numbers = userData[kContacts][kValues];
        });
      },
    );
  }

  deleteNumber({required num numberId}) {
    ApiRequest(
      path: apiDeleteContact(numberId),
      method: deleteMethod,
    ).request(
      onSuccess: (data, response) {
        update();
        usercontroller.getUserData().then((value) {
          numbers = userData[kContacts][kValues];
        });
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
      },
    );
  }
}



import 'package:busha_task/views/recipients_page.dart';
import 'package:busha_task/views/transactions_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/di/locator.dart';
import '../models/dashboard_tab_data_model/dashboard_tab_model.dart';
import '../routes/app_router.dart';
import '../views/home_page.dart';

final tabHostProvider = ChangeNotifierProvider<TabHostViewModel>((ref) {
  return TabHostViewModel();
});

class TabHostViewModel extends ChangeNotifier {



  DashBoardTabModel _selectedDashBoardTab=DashBoardTabModel(page:  HomePage()
      , iconUrl: "ic_home", tabName: "Home");

  DashBoardTabModel get selectedDashBoardTab => _selectedDashBoardTab;
  set selectedDashBoardTab(DashBoardTabModel dashBoardTabModel) {
    _selectedDashBoardTab = dashBoardTabModel;
    notifyListeners();
  }
  double buttonScale=1.0;
  void setButtonScale(double value){
    buttonScale=value;
    notifyListeners();
  }

  void navigateBack(){
    int index=dashBoardTabsData.indexWhere((element) => element.tabName
        ==selectedDashBoardTab.tabName);
    int tabIndex=index-1;
    if(tabIndex!=-1){
      selectedDashBoardTab=dashBoardTabsData[tabIndex];
      locator<AppRouter>().back();
    }
  }



  List<DashBoardTabModel>dashBoardTabsData=[
    DashBoardTabModel(page:  HomePage()
        , iconUrl: "ic_home", tabName: "Home"),
    DashBoardTabModel(page: const TransactionsPage()
        , iconUrl: "ic_transaction", tabName: "Transactions"),
    DashBoardTabModel(page: const RecipientsPage()
        , iconUrl: "ic_recipient", tabName: "Recipient"),

  ];



}
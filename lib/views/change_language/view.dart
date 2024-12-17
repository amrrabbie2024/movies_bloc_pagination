import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_bloc/core/logic/cash_helper.dart';
import 'package:flutter_movies_bloc/core/logic/helper_methods.dart';
import 'package:flutter_movies_bloc/views/splash/view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeLanguageView extends StatefulWidget {
  const ChangeLanguageView({super.key});

  @override
  State<ChangeLanguageView> createState() => _ChangeLanguageViewState();
}

final languages=["English","العربية","France00"];
final languagesCodes=['en','ar','fr'];
int selectedValue=0;

class _ChangeLanguageViewState extends State<ChangeLanguageView> {
  @override
  Widget build(BuildContext context) {
    final lng=CashHelper.getLanguage();
    if(lng == "ar")
      selectedValue=1;
    else if(lng == "fr")
      selectedValue=2;
    else
      selectedValue=0;
    return Scaffold(
      appBar: AppBar(
        title: Text("change_language".tr()),
      ),
      body: Column(
        children: [
          ...List.generate(languages.length, (index) => _Item(index))
        ],
      ),
    );
  }

  _Item(int index) {
    return Row(
      children: [
        Radio(
          activeColor: Colors.orange,
          value: selectedValue, groupValue: index, onChanged: (value) {
          setState(() {
            selectedValue=index;
            context.setLocale(Locale(languagesCodes[index]));
            CashHelper.saveLanguage(languagesCodes[index]);
            navigateTo(SplashView());
          });
        },),
        SizedBox(width: 8.w,),
        Text(languages[index],style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w500,fontSize: 21),)
      ],
    );
  }
}

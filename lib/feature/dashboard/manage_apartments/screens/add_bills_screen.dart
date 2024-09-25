import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travoli/core/helpers/regex_validation.dart';
import 'package:travoli/core/helpers/toast_manager.dart';
import 'package:travoli/feature/dashboard/manage_apartments/widgets/billing_popup.dart';
import '../../../../core/components/components.dart';
import '../../../../core/configs/configs.dart';
import '../../../../core/configs/storage_box.dart';
import '../../../../core/helpers/hive_repository.dart';
import '../../../../core/helpers/router/router.dart';
import 'rental_listing_overview.dart';

class AddBillsScreen extends StatefulWidget {
  static const routeName = "addBillScreen";
  const AddBillsScreen({super.key});

  @override
  State<AddBillsScreen> createState() => _AddBillsScreenState();
}

class _AddBillsScreenState extends State<AddBillsScreen> {
final HiveRepository _hiveRepository = HiveRepository();
  final _ = TextEditingController();
  final rentController = TextEditingController();
  final newBillNameController = TextEditingController();
  final newAmountController = TextEditingController();
  Map<String,dynamic> newBills = {};
 final _formKey = GlobalKey<FormState>();
  @override
  void initState() {

    super.initState();
  }
    final CurrencyTextInputFormatter amountFormatter =
      CurrencyTextInputFormatter.currency(decimalDigits: 2, locale: "ko", symbol: "₦");
  @override
  Widget build(BuildContext context) {
     final image  =   _hiveRepository.get(key: HiveKeys.images,name: HiveKeys.images);
     print("images ${image}");
    print(newBills.toString());
     print(newBills.length);
      List<MapEntry<String, dynamic>> entries = newBills.entries.toList();
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SpaceY(40.dy),
                CustomText(
                  text: "Billings",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff0B0B0B),
                  fontFamily: kFontFamily,
                ),
                SpaceY(4.dy),
                CustomText(
                  text: "Tab to add your bill.",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff100C08),
                  fontFamily: kSecondaryFontFamily,
                ),
                SpaceY(32.dy),
                NormalTextFormField(
                  hintText: "300,000", 
                  labelText: "Rent*", 
                  controller: rentController, 
                  inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  amountFormatter
                 ],
                validator: (String? value ){
                  if (value!.isEmpty) {
                    return 'Please enter rent amount';
                   }
                    return null;
                }),
                SpaceY(24.dy),
                SizedBox(
                  height: 45.dy * newBills.length,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:newBills.length,
                    itemBuilder: (context,index){
                    return  Dismissible(
                       background: Container(
              color: Colors.red,
            ),
            key: ValueKey<int>(index),
                      child: BillingListTile(
                      title:entries[index].key.toString().capitalize,
                      amount: entries[index].value.toString(),),
                    );
                  }),
                ),
                SpaceY(54.dy),
                  GestureDetector(
                    onTap: (){
                  showModalSheetWithRadius(context: context, 
                  returnWidget:  AddBillingPopup(title: "Add Bills", 
                  amountController: newAmountController, 
                  nameController: newBillNameController,
                  onPressed: (){
                    if (newBillNameController.text.toLowerCase() == "rent" || newBills.containsKey(newBillNameController.text)){
                    }else{
                      setState(() {
                       newBills[newBillNameController.text.toLowerCase()] = newAmountController.text;
                       moveToOldScreen(context: context);
                    });
                    }
                    
                  },), height: 150,
                  );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                    Container(
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: kBlack)
                    ),
                    child: const Icon(CupertinoIcons.add, color: kBlack,),
                  ),
                      SpaceX(8.dx),
                      CustomText(
                    text: "Add other bill payment",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff100C08),
                    fontFamily: kSecondaryFontFamily,
                      ),
                        ]
                    ),
                  ),
                  SpaceY(24.dy),
                //  DropDownTextFormField(hintText: "Add bills", labelText: "", controller: _, onTap: (){
                //   showModalSheetWithRadius(context: context, 
                //   returnWidget:  AddBillingPopup(title: "Add Bills", amountController: newAmountController, nameController: newBillNameController,onPressed: (){
                //       newBills[newBillNameController.text.toLowerCase()] = newAmountController.text;
                //   },), height: 150,
                //   );
                //  },
                // validator: (String? value ){
                //     return null;
                // }),
                Align(
                  alignment: Alignment.bottomCenter ,
                  child: CustomElevatedButton(onPressed: (){
                     if (_formKey.currentState!.validate()) {
                      newBills["rent"] = rentController.text;
                    _hiveRepository.add(key: HiveKeys.bills, name: HiveKeys.bills, item: newBills);
                    moveToNextScreen(context: context, page: RentalListingOverview.routeName);
                     }else{
                      ToastManager.errorToast(context, message: "Please enter rent amount");
                     }
                  }, buttonText: "Next Step"),
                ),
                SpaceY(32.dy),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BillingListTile extends StatelessWidget {
  const BillingListTile({
    super.key, required this.amount, required this.title
  });
  final String title, amount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 8.dy),
      child: Container(
        height: 40,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              text: title,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xff0B0B0B),
              fontFamily: kFontFamily,
            ),
            CustomText(
              text: amount,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: kGrey,
              fontFamily: kFontFamily,
            ),
          ],
        ),
      ),
    );
  }
}
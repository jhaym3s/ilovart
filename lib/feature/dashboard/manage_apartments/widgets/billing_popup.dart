import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travoli/core/components/components.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import '../../../../core/configs/configs.dart';
import '../screens/house_features_screen.dart';

class AddBillingPopup extends StatefulWidget {
  const AddBillingPopup({Key? key, required this.title, this.height = 150, 
  required this.nameController, required this.amountController, required this.onPressed}) : super(key: key);
 final String title;
 final double? height;
 final TextEditingController nameController, amountController;
 final Function()? onPressed;
  @override
  State<AddBillingPopup> createState() => _AddBillingPopupState();
}
class _AddBillingPopupState extends State<AddBillingPopup> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final amountControllerMain = TextEditingController();
  List<String> customApartmentFeatures = [
"Agent Fee",
"Caution Fee",
"Legal Fee",
"Service Fee",
"Maintenance Fee"
  ];
  final CurrencyTextInputFormatter amountFormatter =
      CurrencyTextInputFormatter.currency(decimalDigits: 2, locale: "ko", symbol: "₦");
  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: kScreenHeight(context) * 1 - widget.height!.dy,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
        //topRight: Radius.circular(30.0),
        //bottomRight: Radius.circular(40.0),
        //topLeft: Radius.circular(30.0),
      )
          // bottomLeft: Radius.circular(40.0)),
          ),
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(top: 24.dx, left: 19.dx, right: 19.dx),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                  widget.title,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                      color: kBlack),
                ),
                    ],
                  ),
                  SpaceY(24.dy),
                 NormalTextFormField(hintText: "Caution Fee", labelText: "Bill Name", controller: widget.nameController, 
                 validator: (String? value){
                  if (value == null || value.isEmpty) {
                    return "Please add bill name";
                  }
                  return null;
                 }),
                 SpaceY(24.dy),
                 NormalTextFormField(
                 hintText: customAmount, 
                 labelText: "Bill Amount", 
                //  onChanged: (p0) {
                //  final something =  CurrencyFormatter.format(widget.amountController.text, nairaSettings, decimal: 2);
                //  print("$something else something");
                //  },
                 inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  amountFormatter
                 ],
                 controller: widget.amountController, 
                 validator: (String? value){
                  if (value == null || value.isEmpty) {
                    return "Please add amount";
                  }
                  return null;
                  
                 }),
                 SpaceY(30.dy),
                  Wrap(
                    children: List.generate(
                      customApartmentFeatures.length,
                      (index) => GestureDetector(
                        onTap: (){
                          setState(() {
                            widget.nameController.text =customApartmentFeatures[index];
                          });
                        },
                        child: FeaturesListTile(name: customApartmentFeatures[index], isSelected: false,)),
                    ),
                  ),
                 SpaceY(54.dy),
                 CustomElevatedButton(onPressed: widget.onPressed, buttonText: "Add Bill")
                ],
              ),
            )),
      ),
    );
  }
}
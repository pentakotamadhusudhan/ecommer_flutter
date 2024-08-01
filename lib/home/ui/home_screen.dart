import 'package:blocproject/productsmodule/orders_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:blocproject/utils/color_const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../productsmodule/ui/productsui.dart';
import '../../utils/text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  OrdersBloc ordersBloc = OrdersBloc();
  TextEditingController empId = TextEditingController();
  TextEditingController passoword = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();

  @override
  void initState() {
    ordersBloc.add(PostInitialEvent());
    print("object1");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            custome_textfield(context, empId, "Name"),
            20.verticalSpace,
            custome_textfield(context, passoword, "Password"),
            20.verticalSpace,
            custome_textfield(context, mobilenumber, "Mobile Number"),
            20.verticalSpace,
            custome_textfield(context, mobilenumber, "Email"),
            20.verticalSpace,
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              height: 30,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Productsui()));
                },
                child: Text(
                  "Submit",
                  style: TextStyleConst.button,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConst.selectedcolor,
                  foregroundColor: ColorConst.whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget custome_textfield(
    BuildContext context, TextEditingController controller, labeltext) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "$labeltext",
        style: TextStyleConst.labelstyle,
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        height: 35,
        child: TextFormField(

          style: TextStyle(fontSize: 12),
          controller: controller,
          decoration: const InputDecoration(
            contentPadding:EdgeInsets.only(left: 10,top: 2,bottom: 2,right: 2) ,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: ColorConst.blackcolor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorConst.selectedcolor),
            ),
          ),
        ),
      ),
    ],
  );
}


import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:iconsax/iconsax.dart";
import "package:medilink/features/personalization/screens/address/widgets/single_address.dart";

import "../../../../common/widgets/appbar/appbar.dart";
import "../../../../utils/constants/colors.dart";
import "../../../../utils/constants/sizes.dart";
import "add_new_ddress.dart";


class AddressesScreen extends StatelessWidget {
  const AddressesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){Get.to(() => const AddNewAddressScreen());},
        backgroundColor: TColors.primary,
        elevation: 0,
        child: const Icon(Iconsax.add, color: TColors.white,),
      ),
      appBar: const TAppBar(
        title: Text('Addresses'),
        showBackArrow: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TSingleAddress(selectedAddress: true,),
              TSingleAddress(selectedAddress: false,),
              TSingleAddress(selectedAddress: false,),
            ],
          ),
        ),
      ),
    );
  }
}

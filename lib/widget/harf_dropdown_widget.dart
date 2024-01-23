import 'package:dinamik_ortalama_hesapla/constants/app_constant.dart';
import 'package:dinamik_ortalama_hesapla/helper/data_helper.dart';
import 'package:flutter/material.dart';

class HarflerDropdown extends StatefulWidget {
  const HarflerDropdown({required this.onHarfSecildi, super.key});
  final Function onHarfSecildi;

  @override
  State<HarflerDropdown> createState() => _HarflerDropdownState();
}

class _HarflerDropdownState extends State<HarflerDropdown> {
  double secilenHarfDegeri = 4;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: Sabitler.dropDownPadding,
      decoration: BoxDecoration(
          color: Sabitler.anaRenk.shade100.withOpacity(0.3),
          borderRadius: Sabitler.borderRadius),
      child: DropdownButton(
          items: DataHelper.tumDerslerinHarfleri(),
          underline: Container(),
          iconEnabledColor: Sabitler.anaRenk.shade200,
          value: secilenHarfDegeri,
          onChanged: (double? deger) {
            setState(() {
              secilenHarfDegeri = deger!;
              widget.onHarfSecildi(deger);
            });
          }),
    );
  }
}

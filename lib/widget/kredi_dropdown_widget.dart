import 'package:dinamik_ortalama_hesapla/constants/app_constant.dart';
import 'package:dinamik_ortalama_hesapla/helper/data_helper.dart';
import 'package:flutter/material.dart';

class KrediDropdown extends StatefulWidget {
  const KrediDropdown({super.key, required this.onKrediSecildi});
  final Function onKrediSecildi;
  @override
  State<KrediDropdown> createState() => _KrediDropdownState();
}

class _KrediDropdownState extends State<KrediDropdown> {
  double secilenKrediDegeri = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: Sabitler.dropDownPadding,
      decoration: BoxDecoration(
          color: Sabitler.anaRenk.shade100.withOpacity(0.3),
          borderRadius: Sabitler.borderRadius),
      child: DropdownButton(
          items: DataHelper.tumDerslerinKrediler(),
          underline: Container(),
          iconEnabledColor: Sabitler.anaRenk.shade200,
          value: secilenKrediDegeri,
          onChanged: (deger) {
            setState(() {
              secilenKrediDegeri = deger!;
              widget.onKrediSecildi(deger);
            });
          }),
    );
  }
}

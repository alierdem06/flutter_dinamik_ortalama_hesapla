import 'package:dinamik_ortalama_hesapla/constants/app_constant.dart';
import 'package:dinamik_ortalama_hesapla/helper/data_helper.dart';
import 'package:dinamik_ortalama_hesapla/model/ders.dart';
import 'package:dinamik_ortalama_hesapla/widget/ders_listesi.dart';
import 'package:dinamik_ortalama_hesapla/widget/harf_dropdown_widget.dart';
import 'package:dinamik_ortalama_hesapla/widget/kredi_dropdown_widget.dart';
import 'package:dinamik_ortalama_hesapla/widget/ortalama_goster.dart';
import 'package:flutter/material.dart';

class OrtalamaHesaplaPage extends StatefulWidget {
  const OrtalamaHesaplaPage({super.key});

  @override
  State<OrtalamaHesaplaPage> createState() => _OrtalamaHesaplaPageState();
}

class _OrtalamaHesaplaPageState extends State<OrtalamaHesaplaPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  double secilenHarfDegeri = 4;
  double secilenKrediDegeri = 1;
  String girilenDersAdi = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          Sabitler.baslikText,
          style: Sabitler.baslikStyle,
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildForm(),
            ),
            Expanded(
              flex: 1,
              child: OrtalamaGoster(
                dersSayisi: DataHelper.tumEklenenDersler.length,
                ortalama: DataHelper.ortalamaHesapla(),
              ),
            )
          ],
        ),
        Expanded(
          child: DersListesi(onElemanCikarildi: (index) {
            setState(() {
              DataHelper.tumEklenenDersler.removeAt(index);
            });
          }),
        ),
      ]),
    );
  }

  Widget _buildForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: Sabitler.yatayPadding8,
            child: _buildTextFormField(),
          ),
          Sabitler.sized5Height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: Sabitler.yatayPadding8,
                  child: HarflerDropdown(onHarfSecildi: (harf) {
                    setState(() {
                      secilenHarfDegeri = harf;
                    });
                  }),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: Sabitler.yatayPadding8,
                  child: KrediDropdown(onKrediSecildi: (deger) {
                    setState(() {
                      secilenKrediDegeri = deger;
                    });
                  }),
                ),
              ),
              IconButton(
                onPressed: _dersEkleVeortalamaHesapla,
                icon: const Icon(Icons.arrow_forward_ios_outlined),
                iconSize: 30,
                color: Sabitler.anaRenk,
              )
            ],
          ),
          Sabitler.sized5Height,
        ],
      ),
    );
  }

  Widget _buildTextFormField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Ders adını giriniz";
        } else {
          return null;
        }
      },
      onSaved: (deger) {
        setState(() {
          girilenDersAdi = deger!;
        });
      },
      decoration: InputDecoration(
        hintText: "Ders Adı Giriniz...",
        border: OutlineInputBorder(
            borderRadius: Sabitler.borderRadius, borderSide: BorderSide.none),
        filled: true,
        fillColor: Sabitler.anaRenk.shade100.withOpacity(0.3),
      ),
    );
  }

  void _dersEkleVeortalamaHesapla() {
    setState(() {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        var eklenecekDers = Ders(
            ad: girilenDersAdi,
            harfDegeri: secilenHarfDegeri,
            krediDegeri: secilenKrediDegeri);
        DataHelper.dersEkle(eklenecekDers);
      }
    });
  }
}

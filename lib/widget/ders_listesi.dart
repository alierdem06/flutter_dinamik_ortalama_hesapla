import 'package:dinamik_ortalama_hesapla/constants/app_constant.dart';
import 'package:dinamik_ortalama_hesapla/helper/data_helper.dart';
import 'package:dinamik_ortalama_hesapla/model/ders.dart';
import 'package:flutter/material.dart';

class DersListesi extends StatelessWidget {
  final Function onElemanCikarildi;
  const DersListesi({super.key, required this.onElemanCikarildi});

  @override
  Widget build(BuildContext context) {
    List<Ders> tumDersler = DataHelper.tumEklenenDersler;
    return tumDersler.isNotEmpty
        ? ListView.builder(
            itemCount: DataHelper.tumEklenenDersler.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                onDismissed: (a) {
                  onElemanCikarildi(index);
                },
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Card(
                    child: ListTile(
                      title: Text(tumDersler[index].ad),
                      leading: CircleAvatar(
                        backgroundColor: Sabitler.anaRenk.shade300,
                        child: Text((tumDersler[index].harfDegeri *
                                tumDersler[index].krediDegeri)
                            .toStringAsFixed(0)),
                      ),
                      subtitle: Text(
                          "${tumDersler[index].krediDegeri} Kredi , Not Değeri ${tumDersler[index].harfDegeri}"),
                    ),
                  ),
                ),
              );
            })
        : Center(
            child: Text(
              "Lütfen Ders Ekleyiniz",
              style: Sabitler.baslikStyle,
            ),
          );
  }
}

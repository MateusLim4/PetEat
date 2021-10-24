import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peteat/share/presets/app_colors.dart';

class ModalHour extends StatelessWidget {
  const ModalHour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        height: 1,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
          color: AppColors.titleWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                child: Text('Excluir'),
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.buttonRed))),
            ElevatedButton(
              child: Text('Alterar'),
              onPressed: () {
                Navigator.pushNamed(context, '/changeTime');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.secondary),
              ),
            )
          ],
        ));
  }
}

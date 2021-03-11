import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/DefectModel.dart';
import '../model/IssueModel.dart';

import '../tools/mmk_widgets.dart';
import '../tools/mmk_tools.dart';
import 'CertificateLookup.dart';
import 'PositionLookup.dart';
import 'DefectTypeLookup.dart';

class DefectAdd extends StatelessWidget {
  @override
  build(context) {
    var issueModel = context.read<IssueModel>();
    var defectModel = DefectModel();
    return BlocConsumer<DefectModel, DefectState>(
      cubit: defectModel,
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: Text('Дефект'),
                actions: [
                  //IconButton(tooltip: 'Сканировать штрихкод', icon: Icon(Icons.qr_code_scanner), onPressed: () {}),
                  IconButton(
                      tooltip: 'Добавить изображение',
                      icon: Icon(Icons.add_a_photo),
                      onPressed: () => _pickImage(defectModel)),
                ],
              ),
              body: Hpadding1(
                Column(
                  children: [
                    MmkLookupField(
                      text: state.data.certificate,
                      label: 'Сертификат',
                      onSelect: () async {
                        defectModel.set(
                            certificate:
                                await Navigator.push(context, MaterialPageRoute(builder: (_) => CertificateLookup())));
                      },
                    ),
                    MmkLookupField(
                      text: state.data.position,
                      label: 'Позиция',
                      onSelect: () async {
                        defectModel.set(
                            position:
                                await Navigator.push(context, MaterialPageRoute(builder: (_) => PositionLookup())));
                      },
                    ),
                    MmkTextField(
                      text: state.data.productType,
                      label: 'Вид продукции',
                      onChanged: (v) => defectModel.set(productType: v),
                    ),
                    MmkLookupField(
                      text: state.data.defectType.name,
                      label: 'Дефект',
                      onSelect: () async {
                        defectModel.set(
                            defectType:
                                await Navigator.push(context, MaterialPageRoute(builder: (_) => DefectTypeLookup())));
                      },
                    ),
                    MmkTextField(
                      text: state.data.notes,
                      label: 'Замечания',
                      onChanged: (v) => defectModel.set(notes: v),
                      minLines: 3,
                      maxLines: 6,
                    ),
                  ],
                ),
              ),
              bottomSheet: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('Изображений: ${state.data.photos.length}'),
                        (state.data.photos.length > 0)
                            ? IconButton(
                                tooltip: 'Перейти к изображениям',
                                icon: Icon(Icons.photo_library),
                                onPressed: () {},
                              )
                            : Text(''),
                      ],
                    ),
                    TextButton(
                      child: Text('Сохранить', style: TextStyle(fontSize: 16)),
                      onPressed: () => defectModel.addToIssue(issueModel),
                    ),
                  ],
                ),
              ),
            ),
            (state.waiting) ? Waiting() : Container(),
          ],
        );
      },
      listener: (context, state) {
        if (state.error != '') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
        } else if (state.done) {
          Navigator.pop(context);
        }
      },
    );
  }

  void _pickImage(DefectModel defectModel) async {
    var image = await pickImage();
    if (image != null) {
      defectModel.addImage(image);
    }
  }

  // void _takePhoto(context) {
  //   if (kIsWeb) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(
  //           'В web-версии фотосъемка не реализована!\nУстановите приложение из магазина, или нажмите кнопку выбора файла из галереи.'),
  //     ));
  //   }
  // }
}

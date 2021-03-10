import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/DefectModel.dart';
import '../model/IssueModel.dart';

import '../mmk_widgets.dart';
import 'CertificateLookup.dart';
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
                  IconButton(
                    tooltip: 'Сканировать штрихкод',
                    icon: Icon(Icons.qr_code_scanner),
                    onPressed: () {},
                  ),
                  IconButton(
                    tooltip: 'Добавить изображение',
                    icon: Icon(Icons.add_photo_alternate),
                    onPressed: () {},
                  ),
                  IconButton(
                    tooltip: 'Сфотографировать',
                    icon: Icon(Icons.add_a_photo),
                    onPressed: () {},
                  ),
                ],
              ),
              body: Hpadding1(
                Column(
                  children: [
                    MmkLookupField(
                      text: state.defect.certificate,
                      label: 'Сертификат',
                      onSelect: () async {
                        defectModel.set(
                            certificate:
                                await Navigator.push(context, MaterialPageRoute(builder: (_) => CertificateLookup())));
                      },
                    ),
                    TextField(
                      controller: TextEditingController(text: state.defect.productType),
                      decoration: InputDecoration(labelText: 'Вид продукции'),
                      onChanged: (v) => defectModel.set(productType: v),
                    ),
                    MmkLookupField(
                      text: state.defect.defectType,
                      label: 'Дефект',
                      onSelect: () async {
                        defectModel.set(
                            defectType:
                                await Navigator.push(context, MaterialPageRoute(builder: (_) => DefectTypeLookup())));
                      },
                    ),
                    TextField(
                      controller: TextEditingController(text: state.defect.notes),
                      decoration: InputDecoration(labelText: 'Замечания'),
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
                        Text('Изображений: ${state.defect.photos.length}'),
                        IconButton(
                          tooltip: 'Перейти к изображениям',
                          icon: Icon(Icons.photo_library),
                          onPressed: () {},
                        ),
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
        } else if (state.saved) {
          Navigator.pop(context);
        }
      },
    );
  }
}

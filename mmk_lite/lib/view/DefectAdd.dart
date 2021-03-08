import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/Defect.dart';
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
    return BlocConsumer<DefectModel, Defect>(
      cubit: defectModel,
      builder: (context, state) {
        return Scaffold(
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
                icon: Icon(Icons.photo_library),
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
                  text: state.certificate,
                  label: 'Сертификат',
                  onSelect: () async {
                    defectModel.set(
                        certificate:
                            await Navigator.push(context, MaterialPageRoute(builder: (_) => CertificateLookup())));
                  },
                ),
                MmkLookupField(
                  text: state.position,
                  label: 'Позиция',
                  onSelect: () async {},
                ),
                TextField(
                  controller: TextEditingController(text: state.productType),
                  decoration: InputDecoration(labelText: 'Вид продукции'),
                  onChanged: (v) => defectModel.set(productType: v),
                ),
                MmkLookupField(
                  text: state.defect,
                  label: 'Дефект',
                  onSelect: () async {
                    defectModel.set(
                        defect: await Navigator.push(context, MaterialPageRoute(builder: (_) => DefectTypeLookup())));
                  },
                ),
                TextField(
                  controller: TextEditingController(text: state.notes),
                  decoration: InputDecoration(labelText: 'Замечания'),
                  onChanged: (v) => defectModel.set(notes: v),
                  minLines: 5,
                  maxLines: 5,
                ),
              ],
            ),
          ),
          bottomSheet: Padding(
            padding: EdgeInsets.only(left: 15, right: 20, bottom: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Изображений: ${state.photos.length}'),
                TextButton(
                  child: Text('Сохранить', style: TextStyle(fontSize: 16)),
                  onPressed: () {
                    issueModel.add(state);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}

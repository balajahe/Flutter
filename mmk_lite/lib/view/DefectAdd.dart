import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/DefectModel.dart';
import '../model/IssueModel.dart';

import 'lib/common_widgets.dart';
import 'lib/camera.dart';
import 'CertificateLookup.dart';
import 'PositionLookup.dart';
import 'DefectTypeLookup.dart';
import 'ArrangementLookup.dart';
import 'DefectImages.dart';

class DefectAdd extends StatelessWidget {
  @override
  build(context) {
    return BlocProvider(
      create: (_) => DefectModel(),
      child: BlocConsumer<DefectModel, DefectState>(
        builder: (context, state) {
          var issueModel = context.read<IssueModel>();
          var defectModel = context.read<DefectModel>();
          return WillPopScope(
            onWillPop: () => _onExit(context),
            child: Stack(
              children: [
                Scaffold(
                  appBar: AppBar(
                    title: Text('Дефект'),
                    actions: [
                      IconButton(tooltip: 'Сканировать штрихкод', icon: Icon(Icons.qr_code_scanner), onPressed: () {}),
                      IconButton(
                          tooltip: 'Добавить изображение',
                          icon: Icon(Icons.add_a_photo),
                          onPressed: () => _pickImage(defectModel)),
                    ],
                  ),
                  body: Hpadding1(
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          LookupField(
                              text: state.data.certificate.name,
                              label: 'Сертификат',
                              onSelect: () async {
                                defectModel.set(
                                    certificate: await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => CertificateLookup()),
                                ));
                              }),
                          LookupField(
                              text: state.data.position.name,
                              label: 'Позиция',
                              onSelect: () async {
                                defectModel.set(
                                    position: await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => PositionLookup()),
                                ));
                              }),
                          StatelessTextField(
                            text: state.data.productType,
                            label: 'Вид продукции',
                            onChanged: (v) => defectModel.set(productType: v),
                          ),
                          LookupField(
                              text: state.data.defectType.name,
                              label: 'Дефект',
                              onSelect: () async {
                                defectModel.set(
                                    defectType: await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => DefectTypeLookup()),
                                ));
                              }),
                          StatelessTextField(
                            text: state.data.marriageWeight?.toString(),
                            label: 'Вес брака, т',
                            onChanged: (v) => defectModel.set(marriageWeight: double.parse(v)),
                            keyboardType: TextInputType.number,
                            selectOnFocus: true,
                          ),
                          LookupField(
                              text: state.data.arrangement.name,
                              label: 'Урегулирование',
                              onSelect: () async {
                                defectModel.set(
                                    arrangement: await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => ArrangementLookup()),
                                ));
                              }),
                          StatelessTextField(
                            text: state.data.notes,
                            label: 'Замечания',
                            onChanged: (v) => defectModel.set(notes: v),
                            minLines: 3,
                            maxLines: 6,
                          ),
                          Container(height: 50),
                        ],
                      ),
                    ),
                  ),
                  bottomSheet: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('Изображений: ${state.data.images.length}'),
                            (state.data.images.length > 0)
                                ? IconButton(
                                    tooltip: 'Перейти к изображениям',
                                    icon: Icon(Icons.photo_library),
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => BlocProvider.value(value: defectModel, child: DefectImages()),
                                      ),
                                    ),
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
            ),
          );
        },
        listener: (context, state) {
          if (state.userError != '') {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.userError)));
          } else if (state.done) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  void _pickImage(DefectModel defectModel) async {
    var image = await pickImage();
    if (image != null) defectModel.addImage(image);
  }

  Future<bool> _onExit(context) async {
    var isExit = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Выйти без сохранения?'),
        actions: <Widget>[
          TextButton(child: Text('Нет'), onPressed: () => Navigator.pop(context, false)),
          TextButton(child: Text('Да'), onPressed: () => Navigator.pop(context, true)),
        ],
      ),
    );
    return (isExit is bool && isExit);
  }
}

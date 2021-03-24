import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entity/Defect.dart';
import '../model/DefectModel.dart';

import 'lib/common_widgets.dart';
import 'lib/camera.dart';
import 'CertificateLookup.dart';
import 'PositionLookup.dart';
import 'DefectTypeLookup.dart';
import 'ArrangementLookup.dart';
import 'DefectImages.dart';

class DefectAddEdit extends StatelessWidget {
  final AddEditMode _mode;
  final Defect _oldData;
  DefectAddEdit(this._mode, [this._oldData]);

  @override
  build(context) {
    return BlocProvider(
      create: (_) => DefectModel(context, _mode, _oldData),
      child: BlocConsumer<DefectModel, DefectState>(
        builder: (context, state) {
          var model = context.read<DefectModel>();
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
                          onPressed: () => _pickImage(context, model)),
                    ],
                  ),
                  body: Hpadding1(
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          LookupTextField(
                              text: state.data.certificate.name,
                              label: 'Сертификат',
                              onSelect: () async {
                                model.set(
                                    certificate: await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => CertificateLookup()),
                                ));
                              }),
                          LookupTextField(
                              text: state.data.position.name,
                              label: 'Позиция',
                              onSelect: () async {
                                model.set(
                                    position: await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => PositionLookup()),
                                ));
                              }),
                          StatelessTextField(
                            text: state.data.productType,
                            label: 'Вид продукции',
                            onChanged: (v) => model.set(productType: v),
                          ),
                          LookupTextField(
                              text: state.data.defectType.name,
                              label: 'Дефект',
                              onSelect: () async {
                                model.set(
                                    defectType: await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => DefectTypeLookup()),
                                ));
                              }),
                          StatelessTextField(
                            text: state.data.marriageWeight?.toString(),
                            label: 'Вес брака, т',
                            onChanged: (v) => model.set(marriageWeight: double.parse(v)),
                            keyboardType: TextInputType.number,
                            selectOnFocus: true,
                          ),
                          LookupTextField(
                              text: state.data.arrangement.name,
                              label: 'Урегулирование',
                              onSelect: () async {
                                model.set(
                                    arrangement: await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => ArrangementLookup()),
                                ));
                              }),
                          StatelessTextField(
                            text: state.data.notes,
                            label: 'Замечания',
                            onChanged: (v) => model.set(notes: v),
                            minLines: 2,
                            maxLines: 5,
                          ),
                          Container(height: 55),
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
                                        builder: (_) => BlocProvider.value(value: model, child: DefectImages()),
                                      ),
                                    ),
                                  )
                                : Text(''),
                          ],
                        ),
                        TextButton(
                          child: Text('Сохранить', style: TextStyle(fontSize: 16)),
                          onPressed: () => model.save(),
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

  void _pickImage(BuildContext context, DefectModel model) async {
    var image = await pickImage(context);
    if (image != null) model.addImage(image);
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

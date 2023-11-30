import 'dart:convert';
import 'package:project/all_imports.dart';
import 'package:flutter_quill/flutter_quill.dart';

class MainDetails extends StatelessWidget {
  const MainDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuillController _controller = QuillController.basic();
    final json = jsonEncode(_controller.document.toDelta().toJson());

    return Container(
      padding: const EdgeInsets.all(24.0),
      margin: const EdgeInsets.only(top: 32),
      color: Colors.white,
      width: 1600,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  Image(
                    image: AssetImage('img/product/product1.jpg'),
                  ),
                ],
              )),
          Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'PC Đỗ đại học',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      'MSP: ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF8d94ac)),
                    ),
                    Container(
                      height: 16,
                      decoration: BoxDecoration(
                          border: BorderDirectional(
                              bottom: BorderSide(
                                  width: 1, color: Color(0xffededed)))),
                    ),
                    Container(
                      width: 500,
                      height: 500,
                      child: QuillProvider(
                        configurations: QuillConfigurations(
                          controller: _controller,
                          sharedConfigurations: const QuillSharedConfigurations(
                            locale: Locale('de'),
                          ),
                        ),
                        child: Column(
                          children: [
                            const QuillToolbar(),
                            Expanded(
                              child: QuillEditor.basic(
                                configurations: const QuillEditorConfigurations(
                                  readOnly: false,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: Column(
                children: [],
              )),
        ],
      ),
    );
  }
}

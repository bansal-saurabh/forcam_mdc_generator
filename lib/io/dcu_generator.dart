import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:xml/xml.dart';

class DCUGenerator {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/JavisController.xml');
  }

  Future<File?> readFile(String templateName, String selectedPlugin) async {
    try {
      final file = await _localFile;

      // Read the document
      final document = XmlDocument.parse(file.readAsStringSync());

      print("DCU Template Name: " + document.findAllElements("mController").first.text.substring(1));
      print("DCU Template Type: " + document.findAllElements("mControllerType").first.text);
      print("DCU Bus Type: " + document.findAllElements("mBusType").first.text);

      return null;
    } catch (e) {
      // If encountering an error, return 0
      return null;
    }
  }

  Future<File?> writeFile(String templateName, String selectedPlugin, String selectedBus) async {
    try {
      final file = await _localFile;

      final builder = XmlBuilder();
      // builder.processing('xml', 'version="1.0"');
      builder.element('com.forcam.na.domaintemplate.configurations.JavisControllerConfiguration', nest: () {
        builder.element('mEnvelopes', nest: () {
          builder.element('com.forcam.na.domaintemplate.configurations.envelopes.JavisControllerEnvelope', nest: () {
            builder.element('mTemplateController', nest: () {
              builder.element('mController', nest: "@$templateName");
              builder.element('mControllerType', nest: selectedPlugin);
              builder.element('mBusType', nest: selectedBus);
              builder.element('mChanged', nest: ((DateTime.now().millisecondsSinceEpoch) / 1000).round());
            });
            for(int i = 0; i <= 5; i++) {
              builder.element('mSignals', nest: () {
                builder.element('com.forcam.na.common.javis.JavisSignal', nest: () {
                  builder.element('mSigName', nest: "Slurry_Temp");
                  builder.element('mController', nest: "@TSTRIG_OPCUA_DCU");
                  builder.element('mDevice', nest: "");
                  builder.element('mSigValTyp', nest: "N");
                  builder.element('mSigTyp', nest: "Int16");
                  builder.element('mDescription', nest: "Slurry Temperature (C)");
                  builder.element('mChanged', nest: "1628260609");
                  builder.element('mAlias', nest: "2\\Address Space.Forcam_Test.Slurry_Temp");
                });
              });
            }
          });
        });
      });

      final dcuTemplateXml = builder.buildDocument();

      file.writeAsString(dcuTemplateXml.toXmlString(pretty: true, indent: '  '));

      return null;
    } catch (e) {
      // If encountering an error, return 0
      return null;
    }

  }
}
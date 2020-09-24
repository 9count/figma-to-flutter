import 'package:code_builder/code_builder.dart';
import 'package:figma_to_flutter/context.dart';
import 'package:figma_to_flutter/nodes/node.dart';
import 'package:figma_to_flutter/tools/format.dart';

/**
 * The root generator for initializing generated [CustomPainter] 
 * paint method, generating all the [Widget], [CustomPainter] and data 
 * classes 
 */
class ComponentGenerator {
  final NodeGenerator _node;

  ComponentGenerator(this._node);

  List<Class> generate(String name, dynamic map, {bool withComments = false}) {
    var context = BuildContext(name, map, withComments: withComments);

    map["constraints"] = {
      "horizontal": "LEFT_RIGHT",
      "vertical": "TOP_BOTTOM",
    };

    var relativeTransform = map["relativeTransform"];
    var vx = -1 * relativeTransform[0][2].toDouble();
    var vy = -1 * relativeTransform[1][2].toDouble();

    context.addPaint([
      "canvas.drawColor(Colors.transparent, BlendMode.screen);",
      "var frame = Offset.zero & size;",
      "canvas.translate(${toFixedDouble(vx)}, ${toFixedDouble(vy)});",
    ]);

    _node.generate(context, map, map, relativeTransform);

    return context.build();
  }
}

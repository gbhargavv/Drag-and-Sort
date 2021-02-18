import 'package:drag_and_sort/drag_sort_view.dart';

class ImageBean extends DragBean {
  ImageBean({
    this.originPath,
    this.middlePath,
    this.thumbPath,
    this.originalWidth,
    this.originalHeight,
  });

  String originPath;
  String middlePath;
  String thumbPath;
  int originalWidth;
  int originalHeight;
}

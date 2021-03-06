import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:paradox/widgets/no_data_connection.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class ExpandedImageView extends StatelessWidget {
  final image;

  ExpandedImageView({@required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Stack(
          children: [
            AbsorbPointer(
              absorbing: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected ? true : false,
              child: Opacity(
                opacity: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected ? 0.2 : 1,
                child: Positioned.fill(
                  child: PhotoView(
                    imageProvider: NetworkImage(image),
                  ),
                ),
              ),
            ),
            AbsorbPointer(
              absorbing: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected ? true : false,
              child: Opacity(
                opacity: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected ? 0.2 : 1,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context)),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected,
              child: NoDataConnectionWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

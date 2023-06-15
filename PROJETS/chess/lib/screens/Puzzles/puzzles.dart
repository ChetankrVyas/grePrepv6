import 'package:chess_app/chessBoard/boardProvider/move_provider.dart';
import 'package:chess_app/chessBoard/board_model.dart';
import 'package:chess_app/chessBoard/chess_board_controller.dart';
import 'package:flutter/material.dart';
import 'package:chess_app/chessBoard/chess_board.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../constant.dart';

class Puzzles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _chessController = ChessBoardController();
    final read = context.read<MoveProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings_outlined,
              color: Colors.black,
              size: 30,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.refresh,
                color: Colors.black,
                size: 30,
              )),
        ],
      ),
      body: ScopedModel<BoardModel>(
        model: BoardModel(
          MediaQuery.of(context).size.width >= 400 ? 400 : 350,
          (covariant) {
            print("moveddddd");
          },
          (pieceColor) {
            String text;
            if (pieceColor.toString() == "PieceColor.black") {
              text = "Black Won";
            } else {
              text = "White won";
            }
            read.changeColor();
            print(pieceColor.toString());
            showPlatformDialog(
              context: context,
              builder: (_) => BasicDialogAlert(
                title: Text("CHECK MATE"),
                content: Text(text),
                actions: <Widget>[
                  BasicDialogAction(
                    title: Text("RESET"),
                    onPressed: () {
                      Navigator.pop(context);
                      read.changeColor();
                    },
                  ),
                ],
              ),
            );
          },
          (pieceColor) {
            if (pieceColor.toString() == "") {}
          },
          () {},
          true,
          _chessController,
          true,
        ),
        child: Container(
          height: ScreenSize().height(context),
          width: ScreenSize().width(context),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.yellow[100]],
          )),
          child: ScopedModelDescendant<BoardModel>(
            builder: (context, _, model) {
              return ChessBoard(
                whiteSideTowardsUser: true,
                size: MediaQuery.of(context).size.width >= 400 ? 400 : 350,
                onMove: (covariant) {
                  print("moved");
                },
                onCheckMate: (pieceColor) {
                  String text;
                  if (pieceColor.toString() == "PieceColor.black") {
                    text = "Black Won";
                  } else {
                    text = "White won";
                  }
                  read.changeColor();
                  print(pieceColor.toString());
                  showPlatformDialog(
                    context: context,
                    builder: (_) => BasicDialogAlert(
                      // title: Text("CHECK MATE"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(image: AssetImage('assets/images/checkMate.png'),),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                            ),
                            child: BasicDialogAction(
                              title: Text("RESET",style: TextStyle(color: Colors.black),),
                              onPressed: () {
                                Navigator.pop(context);
                                read.changeColor();
                                print('eees');
                                print(fen);
                                model.referBoard();
                              },
                            ),
                          ),
                        ],
                      ),

                    ),
                  );
                },
                onCheck: (pieceColor) {
                  if (pieceColor.toString() == "") {}
                },
                onDraw: () {},
                chessBoardController: _chessController,
              );
            },
          ),
        ),
      ),
    );
  }
}

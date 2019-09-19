import 'package:flutter/material.dart';
import 'package:finance/src/constants.dart' as Constants;

enum Picked {
  First,
  Second,
}

class Picker extends StatefulWidget {
  final List<String> variants;
  final Function onChange;

  Picker(this.variants, { this.onChange });

  @override
  State<StatefulWidget> createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  Picked selected;

  @override
  void initState({@required variants}) {
    super.initState();

    if (this.widget.variants.length != 2) {
      throw Error();
    }

    this.selected = Picked.First;
  }

  void onClick(Picked select) => this.setState(() {
        this.selected = select;
      });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 2 * 0.7;

    return Container(
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => this.onClick(Picked.First),
            child: Container(
              alignment: Alignment.center,
              width: width,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: this.selected == Picked.First ? Constants.toggle.enableColor : Constants.toggle.disableColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Constants.toggle.borderRadius),
                  bottomLeft: Radius.circular(Constants.toggle.borderRadius),
                ),
              ),
              child: Text(
                this.widget.variants[0],
                style: this.selected == Picked.First
                    ? Constants.toggle.textStyle
                    : null,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => this.onClick(Picked.Second),
            child: Container(
              alignment: Alignment.center,
              width: width,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: this.selected == Picked.Second ? Constants.toggle.enableColor : Constants.toggle.disableColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Constants.toggle.borderRadius),
                  bottomRight: Radius.circular(Constants.toggle.borderRadius),
                ),
              ),
              child: Text(this.widget.variants[1],
                  style: this.selected == Picked.Second
                      ? Constants.toggle.textStyle
                      : null),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tennistournament/utils/constants.dart';

class SearchBar extends StatefulWidget {
  SearchBar(this.expandContainer, this.collapseContainer, this.search,
      this.prevSearch);
  final Function expandContainer;
  final Function collapseContainer;
  final Function search;
  final String prevSearch;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String searchString = "";
  final controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    searchString = widget.prevSearch;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(BORDER_RADIUS),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              alignment: Alignment.center,
              child: TextField(
                style: TextStyle(color: Colors.grey[300]),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Buscar",
                  hintStyle: TextStyle(color: Colors.grey[300]),
                ),
                controller: controller,
                onChanged: (val) {
                  setState(() {
                    searchString = val;
                  });
                },
                onTap: () {
                  widget.expandContainer();
                },
              ),
            ),
          ),
          if (searchString.isNotEmpty ||
              (searchString.isEmpty && widget.prevSearch.isNotEmpty))
            Container(
              height: 40,
              width: 60,
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    searchString = "";
                    controller.text = "";
                  });
                  widget.collapseContainer();
                  widget.search("");
                  FocusScope.of(context).unfocus();
                },
                child: Text(
                  "Cancelar",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: ACCENT_COLOR,
              borderRadius: BorderRadius.circular(BORDER_RADIUS),
            ),
            alignment: Alignment.center,
            child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  widget.search(searchString);
                }),
          ),
        ],
      ),
    );
  }
}

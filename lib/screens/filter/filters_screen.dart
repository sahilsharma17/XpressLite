import 'package:flutter/material.dart';

import '../../constants/lists.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late int selectedFilterIndex;
  late List<Set<int>> selectedItemsList;

  @override
  void initState() {
    super.initState();
    selectedFilterIndex = 0;
    selectedItemsList = List.generate(listOfFilters.length, (index) => <int>{});
  }

  Color getColor(Set<WidgetState> states) {
    const Set<WidgetState> interactiveStates = <WidgetState>{
      WidgetState.pressed,
      WidgetState.hovered,
      WidgetState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.grey;
    }
    return Colors.grey.shade300;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        title: const Text(
          'FILTERS',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Row(
        children: [
          Container(
            width: screenWidth * 0.4,
            color: Colors.grey.shade200,
            height: screenHeight,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: filter1.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFilterIndex = i;
                    });
                  },
                  child: Container(
                    width: screenWidth * 0.4,
                    height: screenHeight * 0.05,
                    color: selectedFilterIndex == i
                        ? Colors.white
                        : Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          filter1[i],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Flexible(
            child: Container(
              color: Colors.white,
              height: screenHeight,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: listOfFilters[selectedFilterIndex].length,
                itemBuilder: (context, i) {
                  return SizedBox(
                    width: screenWidth * 0.6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Row(
                        children: [
                          Checkbox(

                            checkColor: Colors.black,
                            fillColor:
                            WidgetStateProperty.resolveWith(getColor),
                            value: selectedItemsList[selectedFilterIndex]
                                .contains(i),
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == true) {
                                  selectedItemsList[selectedFilterIndex].add(i);
                                } else {
                                  selectedItemsList[selectedFilterIndex].remove(i);
                                }
                              });
                            },
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                listOfFilters[selectedFilterIndex][i],
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

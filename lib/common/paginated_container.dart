import 'package:flutter/material.dart';

class PaginatedContainer extends StatelessWidget {
  const PaginatedContainer({
    Key? key,
    required this.onNext,
    required this.onPrevious,
    required this.child,
    required this.hasNext,
    required this.onPageClick,
    required this.hasPrevious,
    required this.pageIndex,
    required this.totalCount,
  }) : super(key: key);
  final Widget child;
  final VoidCallback onPrevious;
  final Function(int i) onPageClick;
  final VoidCallback onNext;
  final bool? hasPrevious;
  final bool? hasNext;
  final int pageIndex;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: [
        Expanded(child: child),
        Container(
          color: theme.colorScheme.onInverseSurface.withOpacity(0.6),
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ///Left Off here working on the bottom ribbon shape
              Container(
                color: Colors.red,
                child: IconButton(
                  onPressed: () => onPrevious(),
                  iconSize: 18,
                  splashRadius: 15,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color:
                        hasPrevious ?? false ? Colors.white : theme.focusColor,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: totalCount,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                    onTap: () => onPageClick(index),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        color: theme.highlightColor,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 15),
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: index == pageIndex - 1
                              ? theme.primaryColor
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => onNext(),
                iconSize: 18,
                splashRadius: 15,
                icon: Icon(Icons.arrow_forward_ios,
                    color: hasNext ?? false ? Colors.white : theme.focusColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class ScrollToSectionPage extends StatefulWidget {
  const ScrollToSectionPage({super.key});

  @override
  _ScrollToSectionPageState createState() => _ScrollToSectionPageState();
}

class _ScrollToSectionPageState extends State<ScrollToSectionPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _targetKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSection();
    });
  }

  void _scrollToSection() {
    final context = _targetKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scroll to Section'),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: List.generate(20, (index) {
            if (index == 10) {
              return Container(
                key: _targetKey,
                height: 100,
                color: Colors.red,
                child: Center(
                  child: Text(
                    'Target Item',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              );
            }
            return Container(
              height: 100,
              color: index % 2 == 0 ? Colors.blue : Colors.green,
              child: Center(
                child: Text(
                  'Item $index',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

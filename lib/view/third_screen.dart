import 'package:flutter/material.dart';
import 'package:flutter_suitmedia/model/model_data.dart';
import 'package:flutter_suitmedia/view/second_screen.dart';
import 'package:flutter_suitmedia/viewmodel/thirdscreen_viewmodel.dart';
import 'package:provider/provider.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  final _scrollController = ScrollController();
  late final vm = Provider.of<ThirdScreenViewModel>(context, listen: false);
  int page = 10;

  @override
  void initState() {
    vm.getData(page);
    _scaffoldKey = GlobalKey();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scaffoldKey.currentState?.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _scrollListener() async {
    if (vm.isLoading) return;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      page = page + 1;
      vm.getDataScroll(page);
      print('scroll cal api');
    } else {
      print('not call api');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          'Third Screen',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: RefreshIndicator(onRefresh: () async {
        await vm.getData(page);
      }, child: Consumer<ThirdScreenViewModel>(
        builder: (context, value, _) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (value.data.isEmpty) {
            return const Center(
              child: Text('No Data'),
            );
          } else {
            return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(10),
                itemCount: value.data.length + 1,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  if (index < value.data.length) {
                    Data data = value.data[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondScreen(
                                    name: '${data.firstName} ${data.lastName} ',
                                    select: data.email)));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(data.avatar!),
                        ),
                        title: Text("${data.firstName!} ${data.lastName!}"),
                        subtitle: Text(data.email!),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32.0),
                      child: Center(
                          child: value.isLimit
                              ? const Text('No data to load')
                              : const CircularProgressIndicator()),
                    );
                  }
                });
          }
        },
      )),
    );
  }
}

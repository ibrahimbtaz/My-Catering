import 'package:flutter/material.dart';
import 'package:mycatering/screen/cart/components/CartDB.dart';
import 'package:mycatering/screen/cart/components/CartModel.dart';
import 'package:mycatering/screen/home/Home.dart';
import 'package:mycatering/screen/home/components/SearchDelegate.dart';
import 'package:mycatering/screen/home/components/HomeNotify.dart';
import 'package:mycatering/screen/inputlogin/auth/auth.dart';
import 'package:mycatering/utils/constant.dart';

class MainCart extends StatefulWidget {
  const MainCart({super.key});

  @override
  State<MainCart> createState() => _MainCartState();
}

class _MainCartState extends State<MainCart> {
  List<CartModel> dataListFavorite = [];
  bool isLoading = false;
  Future read() async {
    setState(() {
      isLoading = true;
    });
    dataListFavorite = await CartDB.instance.readAll();
    print("Length List ${dataListFavorite.length}");
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    read();
  }

  showDeleteDialog(BuildContext context, String? name) {
    // set up the button
    Widget cancelButton = TextButton(
        child: const Text("Tidak"),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop('dialog');
        });
    Widget okButton = TextButton(
        child: const Text("Hapus"),
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          await CartDB.instance.delete(name);
          read();
          setState(() {
            isLoading = false;
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MyHomePage()));
          Navigator.pop(context);
          Navigator.of(context, rootNavigator: true).pop('dialog');
        });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: const Text("Apakah anda yakin ingin menghapus?"),
      actions: [cancelButton, okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Auth auth = Auth();
    return Scaffold(
      appBar: HomeAppBar(context),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 14),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: secondary,
                  ),
                )
              : dataListFavorite.isEmpty
                  ? const Center(
                      child: Text("Kamu Tidak Memiliki Menu"),
                    )
                  : ListView.builder(
                      itemCount: dataListFavorite.length,
                      itemBuilder: (c, index) {
                        final item = dataListFavorite[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 20),
                          child: Container(
                            height: 80,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: quaternary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      child: FutureBuilder(
                                        future: auth.downloadURL(
                                          item.image,
                                        ),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<String> snapshot) {
                                          if (snapshot.connectionState ==
                                                  ConnectionState.done &&
                                              snapshot.hasData) {
                                            return SizedBox(
                                              height: 40,
                                              width: 40,
                                              child: Image.network(
                                                snapshot.data!,
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          }
                                          if (snapshot.connectionState ==
                                                  ConnectionState.waiting ||
                                              !snapshot.hasData) {
                                            return const CircularProgressIndicator(
                                              color: secondary,
                                            );
                                          }
                                          return Container();
                                        },
                                      )),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text(
                                          item.name,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          item.price,
                                          style: const TextStyle(
                                              fontSize: 14, color: secondary),
                                        ),
                                      ]),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      showDeleteDialog(context, item.name);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }

  AppBar HomeAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: 80,
      leading: const Image(
        image: AssetImage("assets/images/project - logo.png"),
        // repeat: ImageRepeat.repeat,
      ),
      centerTitle: true,
      title: Center(
        child: Text(
          'Your Cart'.toUpperCase(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: secondary, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      actions: [
        IconButton(
            onPressed: () =>
                showSearch(context: context, delegate: CustomSearchDelegate()),
            icon: const Icon(
              Icons.search,
              color: Colors.black,
              size: 24,
            )),
        IconButton(
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return FadeTransition(
                        opacity: animation, child: const NotifikasiPage());
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.black,
              size: 24,
            )),
      ],
    );
  }
}

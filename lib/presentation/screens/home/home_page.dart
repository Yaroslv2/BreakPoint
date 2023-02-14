import 'package:brandpoint/application/home/bloc/home_bloc.dart';
import 'package:brandpoint/application/home/home_service.dart';
import 'package:brandpoint/models/product_list.dart';
import 'package:brandpoint/presentation/design.dart';
import 'package:brandpoint/presentation/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String filterString = "";
  late String searchString = "";

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget productCard(product) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 0,
        semanticContainer: true,
        child: InkResponse(
          borderRadius: BorderRadius.circular(25),
          highlightShape: BoxShape.rectangle,
          containedInkWell: true,
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.network(
                product.mainPhoto,
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height * 0.15,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  product.label,
                  style: GoogleFonts.openSans(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  softWrap: false,
                  textDirection: TextDirection.ltr,
                  overflow: TextOverflow.fade,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  "${product.price} USD",
                  style:
                      GoogleFonts.openSans(color: Colors.black, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      );
    }

    gridView(productList, event) {
      return NotificationListener<ScrollNotification>(
        child: GridView.builder(
          itemCount: productList.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
            mainAxisExtent: MediaQuery.of(context).size.height * 0.25,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return productCard(productList.elementAt(index));
          },
        ),
        onNotification: (ScrollNotification notification) {
          if (notification.metrics.pixels ==
              notification.metrics.maxScrollExtent) {
            if (event == "getSearch") {
              BlocProvider.of<HomeBloc>(context)
                  .add(GetSearchList(filter: searchString));
            } else if (event == "getProducts") {
              BlocProvider.of<HomeBloc>(context)
                  .add(GetProductList(filter: filterString));
            }
          }
          return true;
        },
      );
    }

    return SafeArea(
      child: RepositoryProvider(
        create: (context) => HomeService(),
        child: BlocProvider(
          create: (context) =>
              HomeBloc(RepositoryProvider.of<HomeService>(context))
                ..add(GetProductList(filter: filterString)),
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 100,
              backgroundColor: Colors.white10,
              elevation: 0,
              title: TextField(
                onChanged: (value) {
                  setState(() {
                    searchString = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 0.5)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(25)),
                  hintText: "Search",
                  hintStyle: textStyleGray,
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (searchString != filterString) {
                    itemCounter = 0;
                    productList.clear();
                    state.productList.clear();
                    filterString = searchString;
                    BlocProvider.of<HomeBloc>(context)
                        .add(GetSearchList(filter: searchString));
                  }
                  if (state.homestate == homeState.ok) {
                    print("status ok");
                    print(state.productList);
                    return NotificationListener<ScrollNotification>(
                      child: GridView.builder(
                        controller: _scrollController,
                        itemCount: state.productList.length + 1,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent:
                              MediaQuery.of(context).size.width / 2,
                          mainAxisExtent:
                              MediaQuery.of(context).size.height * 0.25,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          if (index < state.productList.length) {
                            return productCard(
                                state.productList.elementAt(index));
                          } else {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 32),
                              child: hasMore
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Text("NoMore"),
                            );
                          }
                        },
                      ),
                      onNotification: (ScrollNotification notification) {
                        if (_scrollController.position.maxScrollExtent ==
                            _scrollController.offset) {
                          print("update scroll");
                          setState(() {
                            BlocProvider.of<HomeBloc>(context)
                                .add(LoadingMore(filter: filterString));
                          });

                          print(state.productList);
                        }
                        return false;
                      },
                    );
                  }
                  if (state.homestate == homeState.failureLoadiing) {
                    return const Center(
                      child: Text(
                          "Something going wrong...\nResfresh the page or close app"),
                    );
                  }
                  if (state.homestate == homeState.okSearch) {
                    return gridView(state.productList, "getSearch");
                  }
                  if (state.homestate == homeState.emptySearch) {
                    return const Center(
                      child: Text("Can't find something"),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:brandpoint/application/home/bloc/home_bloc.dart';
import 'package:brandpoint/application/home/home_service.dart';
import 'package:brandpoint/presentation/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            children: [
              Image.network(
                product.mainPhoto,
                height: 130,
                loadingBuilder: (context, child, loadingProgress) =>
                    CircularProgressIndicator(),
              ),
              Text(
                product.label,
              ),
              Text(
                "${product.price} RUB",
              ),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.white10,
          elevation: 0,
          title: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Colors.grey, width: 0.5)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 0.8),
                  borderRadius: BorderRadius.circular(25)),
              hintText: "Search",
              hintStyle: textStyleGray,
              prefixIcon: const Icon(Icons.search),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: RepositoryProvider(
            create: (context) => HomeService(),
            child: BlocProvider<HomeBloc>(
              create: (context) =>
                  HomeBloc(RepositoryProvider.of<HomeService>(context))
                    ..add(GetProductList(filter: "")),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state.homestate == homeState.ok) {
                    return GridView.builder(
                      itemCount: state.productList.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                            MediaQuery.of(context).size.width / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return productCard(state.productList.elementAt(index));
                      },
                    );
                  }
                  if (state.homestate == homeState.failureLoadiing) {
                    return const Center(
                      child: Text(
                          "Something going wrong...\nResfresh the page or close app"),
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

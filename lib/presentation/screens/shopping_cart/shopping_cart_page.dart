import 'package:brandpoint/application/cart/bloc/cart_bloc.dart';
import 'package:brandpoint/application/cart/service/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: RepositoryProvider(
      create: (context) => CartService(),
      child: BlocProvider(
        create: (context) =>
            CartBloc(RepositoryProvider.of<CartService>(context))
              ..add(CartLoadingEvent()),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartEmpty) {
              return const _CartEmptyPage();
            }
            if (state is CartLoaded) {
              return const _CartLoadedPage();
            }

            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    ));
  }
}

class _CartEmptyPage extends StatelessWidget {
  const _CartEmptyPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Your shopping cart is empty...",
          style: GoogleFonts.openSans(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _CartLoadedPage extends StatelessWidget {
  const _CartLoadedPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: Text(
          "Shopping cart",
          style: GoogleFonts.openSans(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

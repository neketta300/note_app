import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/helpers/responsive_size.dart';

import '../../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252525),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create_new_note');
        },
        backgroundColor: Color(0xff252525),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveSize.fromFigmaWidth(context, 21),
        ).copyWith(top: ResponsiveSize.fromFigmaHeight(context, 15)),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                'Noter',
                style: GoogleFonts.nunito(
                  fontSize: ResponsiveSize.responsiveFontSize(
                    context,
                    43,
                  ),
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              floating: true,
              actions: [
                AppBarButton(
                  icon: Icons.search,
                  onTap: () =>
                      Navigator.pushNamed(context, '/search_note'),
                ),
                SizedBox(
                  width: ResponsiveSize.fromFigmaWidth(context, 21),
                ),
                AppBarButton(
                  icon: Icons.info_outline_rounded,
                  onTap: () {},
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: ResponsiveSize.fromFigmaHeight(context, 21),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return NoteTile(
                  color: Colors.purple,
                  text: 'My first tile',
                  onTap: () {},
                );
              }, childCount: 1),
            ),
          ],
        ),
      ),
    );
  }
}

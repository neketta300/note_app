import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/helpers/responsive_size.dart';

import '../../../widgets/widgets.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252525),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: ResponsiveSize.fromFigmaHeight(context, 88),
              ),
            ),
            SliverToBoxAdapter(
              child: Theme(
                data: Theme.of(context).copyWith(
                  textSelectionTheme: const TextSelectionThemeData(
                    selectionColor: Color(0xff9A9A9A),
                    selectionHandleColor: Color(0xff9A9A9A),
                  ),
                ),
                child: TextField(
                  cursorColor: Color(0xff9A9A9A),
                  style: GoogleFonts.nunito(
                    fontSize: ResponsiveSize.responsiveFontSize(
                      context,
                      20,
                    ),
                    fontWeight: FontWeight.w300,
                    color: Color(0xffCCCCCC),
                  ),
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.cancel,
                        color: Color(0xffCCCCCC),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: ResponsiveSize.responsiveFontSize(
                        context,
                        30,
                      ),
                    ),
                    filled: true,
                    fillColor: Color(0xff3B3B3B),
                    hintText: 'Search by the keyword...',
                    hintStyle: GoogleFonts.nunito(
                      color: Color(0xFFCCCCCC),
                      fontWeight: FontWeight.w300,
                      fontSize: ResponsiveSize.responsiveFontSize(
                        context,
                        20,
                      ),
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: ResponsiveSize.fromFigmaHeight(context, 21),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return NoteTile(
                  color: Colors.transparent,
                  text: '',
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharm_point/screens/Pharm/villes_screen.dart';
import 'package:pharm_point/screens/centreSante/sante_screen.dart';
import 'package:pharm_point/screens/clinics/clinic_screen.dart';


class GridScreen extends StatelessWidget {
  Widget buildServiceContainer(
    BuildContext context,
    String title,
    Image image,
    Color color,
    Function serviceRoute,
  ) {
    return InkWell(
      onTap: serviceRoute,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.9),
                color,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 70,
              child: image,
            ),
            SizedBox(
              height: 15,
            ),
            FittedBox(
              child: Text(title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.aclonica(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(20),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        crossAxisSpacing: 25,
        mainAxisSpacing: 20,
        childAspectRatio: 3 / 2.3,
        maxCrossAxisExtent: 200,
      ),
      children: [
        buildServiceContainer(
          context,
          'Parmarcies',
          Image.asset('assets/images/pharm.png'),
          // Color(0x7CBEB1),
          Colors.white12,
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VilleScreen(),
              ),
            );
          },
        ),
        buildServiceContainer(
          context,
          'Cliniques',
          Image.asset('assets/images/hand.png'),
          // Color(0xBF9C65),
          Colors.white12,
          () {
            Navigator.pushNamed(
              context,
              ClinicScreen.nameRoute,
            );
          },
        ),
        buildServiceContainer(
          context,
          'Centres de santé',
          Image.asset('assets/images/HOSPITAL.png'),
          // Color(0x7D71B1),
          Colors.white12,
          () {
            Navigator.pushNamed(
              context,
              SanteScreen.nameRoute,
            );
          },
        ),
        buildServiceContainer(
          context,
          'Avis',
          Image.asset('assets/images/info.png'),
          // Colors.black26,
          Colors.white12,
          () {},
        ),
        buildServiceContainer(
          context,
          'Abonnement',
          Image.asset('assets/images/argent.png'),
          // Color(0x5773A0),
          Colors.white12,
          () {},
        ),
      ],
    );
  }
}

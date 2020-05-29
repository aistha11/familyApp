import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    bool showIcon = false;

    return Scaffold(
      body: ListView(
        children: [
          //Profile Details Section (Cover Photo, DP, Full Name, Address)
          Container(
            child: Column(
              children: <Widget>[
                //Profile
                buildDP(
                    'https://www.kindpng.com/picc/m/404-4042774_profile-photo-circle-circle-profile-picture-png-transparent.png'),
                //Profile Details
                buildProfileDetails('Deadpool', 'Kathmandu', 'Nepal', showIcon),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDP(String img, {double radius = 80}) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: radius,
      child: CircleAvatar(
        radius: radius - 2,
        backgroundImage: NetworkImage(img),
      ),
    );
  }

  Widget buildProfileDetails(
      String name, String city, String country, bool showIcon) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, top: 10.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.location_on,
                size: 16.0,
                color: Colors.grey,
              ),
              Text(
                "$city, $country",
                style: TextStyle(color: Colors.grey.shade600),
              )
            ],
          ),
          //Social Links Icons
          showIcon ? buildIconRow() : Padding(padding: EdgeInsets.all(0.0)),
        ],
      ),
    );
  }

  Widget buildIconRow() {
    return Row(
      children: <Widget>[
        IconButton(
          color: Colors.grey,
          icon: Icon(FontAwesomeIcons.instagram),
          onPressed: () {},
        ),
        IconButton(
          color: Colors.grey,
          icon: Icon(FontAwesomeIcons.facebookF),
          onPressed: () {},
        ),
        IconButton(
          color: Colors.grey.shade600,
          icon: Icon(FontAwesomeIcons.twitter),
          onPressed: () {},
        ),
      ],
    );
  }
}

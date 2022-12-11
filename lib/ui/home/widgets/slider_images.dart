import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:naql/utils/urls.dart';
import 'package:naql/custom_widgets/carousel_slider/carousel_with_indicator.dart';
import 'package:naql/models/slider.dart';
import 'package:naql/utils/app_colors.dart';
import 'package:naql/utils/urls.dart';
import 'package:naql/networking/api_provider.dart';
import 'package:naql/providers/auth_provider.dart';

class SliderImages extends StatefulWidget {
  @override
  _SliderImagesState createState() => _SliderImagesState();
}

class _SliderImagesState extends State<SliderImages> {
  // int _currentPageValue = 0;
  // int _previousPageValue = 0;
  // PageController _controller;
  ApiProvider _apiProvider = ApiProvider();
  bool _initialRun = true;

  Future<List<SliderModel>> _sliderImages;

  Future<List<SliderModel>> _getsliderImages() async {
    Map<String, dynamic> results = await _apiProvider.get(Urls.SLIDER_URL);
    List sliderList = List<SliderModel>();
    if (results['response'] == '1') {
      Iterable iterable = results['slider'];
      sliderList =
          iterable.map((model) => SliderModel.fromJson(model)).toList();
    } else {
      print('error');
    }
    return sliderList;
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    // _controller = PageController(initialPage: _currentPageValue);
  }

  @override
  void didChangeDependencies() {
    if (_initialRun) {
      _sliderImages = _getsliderImages();
      _initialRun = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<List<SliderModel>>(
            future: _sliderImages,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
            return    CarouselWithIndicator(
              imgList:snapshot.data ,
            );
                // return Stack(
                //   alignment: AlignmentDirectional.bottomCenter,
                //   children: <Widget>[
                //     PageView.builder(
                //       physics: ClampingScrollPhysics(),
                //       itemCount: snapshot.data.length,
                //       onPageChanged: (int page) {
                //         getChangedPageAndMoveBar(page);
                //       },
                //       controller: _controller,
                //       itemBuilder: (context, index) {
                //         return Column(
                //           children: <Widget>[
                //             Container(
                //               margin: EdgeInsets.symmetric(
                //                   horizontal:
                //                       MediaQuery.of(context).size.width * 0.02),
                //               decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.all(
                //                   const Radius.circular(10.00),
                //                 ),
                //               ),
                //               child: Center(
                //                 child: Image.network(
                //                   snapshot.data[index].photo,
                //                   fit: BoxFit.cover,
                //                 ),
                //               ),
                //             ),
                //             Container(
                //                 margin: EdgeInsets.only(top: 5),
                //                 child: DotsIndicator(
                //                   dotsCount: snapshot.data.length,
                //                   position: _currentPageValue.toDouble(),
                //                   decorator: DotsDecorator(
                //                     size: const Size(24.0, 5.0),
                //                     shape: RoundedRectangleBorder(
                //                         borderRadius:
                //                             BorderRadius.circular(3.0)),
                //                     activeSize: const Size(24.0, 5.0),
                //                     activeColor: cAccentColor,
                //                     color: Color(0xffEEEEEE),
                //                     activeShape: RoundedRectangleBorder(
                //                       borderRadius: BorderRadius.circular(3.0),
                //                     ),
                //                   ),
                //                 )),
                //           ],
                //         );
                //       },
                //     ),
                //   ],
                // );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return Center(
                  child: SpinKitSquareCircle(color: mainAppColor, size: 25));
            });
  }

  // void getChangedPageAndMoveBar(int page) {
  //   print('page is $page');

  //   _currentPageValue = page;

  //   if (_previousPageValue == 0) {
  //     _previousPageValue = _currentPageValue;
  //   } else {
  //     if (_previousPageValue < _currentPageValue) {
  //       _previousPageValue = _currentPageValue;
  //     } else {
  //       _previousPageValue = _currentPageValue;
  //     }
  //   }

  //   setState(() {});
  // }
}

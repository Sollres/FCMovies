import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';

class Screenshot extends Equatable{
  final String aspect;
  final String imagePath;
  final int height;
  final int width;
  final String countryCode;
  final double voteAverage;
  final int voteCount;


  Screenshot(
    {required this.aspect,
    required this.imagePath,
    required this.height,
    required this.width, 
    required this.countryCode,
    required this.voteAverage,
    required this.voteCount});
  
  factory Screenshot.fromJson(Map<String, dynamic> json){
    if(json == null){
      return Screenshot(aspect: '', countryCode: '', height: 0, imagePath: '', voteAverage: 0, voteCount: 0, width: 0);
    }

    return Screenshot(
      aspect: json['aspect_ratio'].toString(), //double.tryParse(json['aspect_ratio'])?.toString() ?? 1.0,
      imagePath: json['file_path'],
      height: json['height'],
      width: json['width'],
      countryCode: json['iso_639_1'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count']);
  }


  @override 
  List<Object> get props =>
      [aspect, imagePath, height, width, countryCode, voteAverage, voteCount];


}
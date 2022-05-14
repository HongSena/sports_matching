import 'package:flutter/material.dart';

CategoryNotifier categoryNotifier = CategoryNotifier();

class CategoryNotifier extends ChangeNotifier{
  String _selectedCategoryInEng = 'none';
  String get currentCategoryInEng => _selectedCategoryInEng;
  String get currentCategoryInKor => categoriesMapEngToKor[_selectedCategoryInEng]!;

  void setNewCategoryWithEng(String newCategory){
    if(categoriesMapEngToKor.keys.contains(newCategory)){
      _selectedCategoryInEng = newCategory;
      notifyListeners();
    }
  }

  void setNewCategoryWithKor(String newCategory){
    if(categoriesMapKorToEng.keys.contains(newCategory)){
      _selectedCategoryInEng = categoriesMapKorToEng[newCategory]!;
      notifyListeners();
    }
  }
}

const Map<String, String> categoriesMapEngToKor = {
  'none': '선택',
  'football': '축구',
  'baskeyball': '농구',
  'baseball': '야구',
  'bodybuilding': '보디빌딩',
  'crossfit': '크로스핏',
  'powerlifting': '파워리프팅',
  'running': '런닝',
  'fencing': '펜싱'
};

const Map<String, String> categoriesMapKorToEng = {
  '선택':'none',
  '축구':'football',
  '농구':'baskeyball' ,
  '야구':'baseball' ,
  '보디빌딩':'bodybuilding',
  '크로스핏':'crossfit' ,
  '파워리프팅':'powerlifting',
  '런닝':'running',
  '펜싱':'fencing'
};
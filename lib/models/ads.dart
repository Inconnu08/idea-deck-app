class Advertisement {
  final String id;
  final String title;
  final String description;
  final String offerEnds;
  final String created;
  final String thumbnail;
  final String brand;

  Advertisement(this.id, this.title, this.description, this.offerEnds,
      this.created, this.thumbnail, this.brand);
}

var ads = [
  Advertisement(
      "1",
      "Win a small pizza!",
      "extStyle(debugLabel: (englishLike display4 2014).merge(((blackMountainView headline1).apply).merge(unknown)), inherit: false, color: Color(0xffffffff), family: NotoSans, size:",
      "March 3 2021",
      "March 1 2021",
      "https://i.ytimg.com/vi/9pDleIHaz5s/maxresdefault.jpg",
      "Cheez"),
  Advertisement(
      "2",
      "All in or nothing, win a pair of boots!",
      "Sadidas extStyle(debugLabel: (englishLike display4 2014).merge(((blackMountainView headline1).apply).merge(unknown)), inherit: false, color: Color(0xFF2222), family: NotoSans, size:",
      "March 8 2021",
      "February 23 2021",
      "https://www.designyourway.net/blog/wp-content/uploads/2017/12/alliornothing.jpg",
      "Adidas"),
];

getAds() {
  return ads;
}
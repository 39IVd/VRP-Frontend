// Marzipano viewer 객체 생성
//  var viewer = new Marzipano.Viewer();
var viewer = new Marzipano.Viewer(document.getElementById("pano"));

// 이미지 로드
var source = Marzipano.ImageUrlSource.fromString(
  // "https://i.ibb.co/Y3mbBDk/IMG-2573.jpg"
  "https://i.ibb.co/hdB6Jc7/scene.jpg"
);

// Geometry 설정
var geometry = new Marzipano.EquirectGeometry([{ width: 4000 }]);

var limiter = Marzipano.RectilinearView.limit.traditional(
  1024,
  (100 * Math.PI) / 180
);
// RectilinearView : 사각 평면 이미지로 설정
var view = new Marzipano.RectilinearView({ yaw: Math.PI }, limiter);

// 전체 공간 출력
var scene = viewer.createScene({
  source: source,
  geometry: geometry,
  view: view,
  pinFirstLevel: true,
});
// var imgHotspot1 = document.createElement("hotspot");
// imgHotspot1.className = "hotspot";
// imgHotspot1.addEventListener("click", function () {
//   switchScene(findSceneById(hotspot.target));
// });
// let option = {
//   perspective: {
//     extraTransforms: "translate(-50%, -50%)",
//   },
// };
// var pos1 = {yaw: -0.19510492915867036, pitch: 0.4434064678021598 };
// scene.hotspotContainer().createHotspot(imgHotspot1, pos1, option);

// Display scene.
scene.switchTo();

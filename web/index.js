// Create viewer.
var viewer = new Marzipano.Viewer(document.getElementById("pano"));

// Create source.
var source = Marzipano.ImageUrlSource.fromString(
  "https://i.ibb.co/Y3mbBDk/IMG-2573.jpg"
);

// Create geometry.
var geometry = new Marzipano.EquirectGeometry([{ width: 4000 }]);

// Create view.
var limiter = Marzipano.RectilinearView.limit.traditional(
  1024,
  (100 * Math.PI) / 180
);
var view = new Marzipano.RectilinearView({ yaw: Math.PI }, limiter);

// Create scene.
var scene = viewer.createScene({
  source: source,
  geometry: geometry,
  view: view,
  pinFirstLevel: true,
});

// var imgHotspot1 = document.createElement("div");
// imgHotspot1.className = "hotspot";
// imgHotspot1.addEventListener("click", function () {
//   switchScene(findSceneById(hotspot.target));
// });
// var imgHotspot2 = document.createElement("div");
// imgHotspot2.className = "hotspot";
// imgHotspot2.addEventListener("click", function () {
//   switchScene(findSceneById(hotspot.target));
// });
// let option = {
//   perspective: {
//     extraTransforms: "translate(-50%, -50%)",
//   },
// };
// var pos1 = { yaw: -0.27052603405912107, pitch: -0.17889624832941878 };
// var pos2 = { yaw: 1.0908307824964558, pitch: 0.13962634015954636 };
// scene.hotspotContainer().createHotspot(imgHotspot1, pos1, option);
// scene.hotspotContainer().createHotspot(imgHotspot2, pos2, option);

// Display scene.
scene.switchTo();

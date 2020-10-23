
var infoHotspot = document.querySelector("#info");
var pos = {yaw: -0.19510492915867036, pitch: 0.4434064678021598};
var icon_wrapper = document.querySelector("#info .icon_wrapper");
icon_wrapper.addEventListener("click", function () {
  document.querySelector("#info").classList.toggle("expanded");
  document.querySelector("#inner_icon").classList.toggle("closeIcon");
});
var close = document.querySelector("#info .close");
close.addEventListener("click", function () {
  document.querySelector("#info").classList.remove("expanded");
  document.querySelector("#inner_icon").classList.remove("closeIcon");
});
scene.hotspotContainer().createHotspot(infoHotspot, pos);

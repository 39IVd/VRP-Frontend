// yaw, pitch 값을 설정한 Hotspot 생성
scene.hotspotContainer().createHotspot(document.querySelector("#info"), {
  yaw: -0.19510492915867036,
  pitch: 0.4434064678021598,
});
document
  .querySelector("#info .icon_wrapper")
  .addEventListener("click", function () {
    document.querySelector("#info").classList.toggle("expanded");
    document.querySelector("#inner_icon").classList.toggle("closeIcon");
  });
document.querySelector("#info .close").addEventListener("click", function () {
  document.querySelector("#info").classList.remove("expanded");
  document.querySelector("#inner_icon").classList.remove("closeIcon");
});

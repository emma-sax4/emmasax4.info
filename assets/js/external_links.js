/*
To open an EXTERNAL link in the CURRENT tab, write your link like this:
  <a href="https://github.com" target="_self">GitHub</a>

To open an INTERNAL link in a NEW tab, write your link like this:
  <a href="https://emmasax4.com" target="_blank">My website</a>
*/
var links = document.getElementsByTagName("a");

for (counter = 0; counter < links.length; counter++) {
  var link = links[counter];

  if (link.target == "_self") {
    link.getAttribute("href") && link.hostname !== location.hostname && (link.target = "_self");
  } else {
    link.getAttribute("href") && link.hostname !== location.hostname && (link.target = "_blank");
  };
};

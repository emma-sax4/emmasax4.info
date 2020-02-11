/*
To open an EXTERNAL link in the CURRENT tab, write your link like this:
  <a href="https://github.com" target="_self">GitHub</a>

To open an INTERNAL link in a NEW tab, write your link like this:
  <a href="https://emmasax4.info" target="_blank">My website</a>
*/

for(var c = document.getElementsByTagName('a'), a = 0; a < c.length; a++) {
  var b = c[a];
  if (b.target == '_self') {
    b.getAttribute('href') && b.hostname !== location.hostname && (b.target = '_self');
  } else {
    b.getAttribute('href') && b.hostname !== location.hostname && (b.target = '_blank');
  };
};

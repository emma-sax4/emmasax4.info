/*
This will take all of the dates for the blog posts (written with the class 'date-meta'),
and will render them in the readers' local time, instead of in UTC.

An incoming date/time will be formatted like this:
  2019-12-29 03:00:00 +0000

And it will be turned into this (CST):
  Sat Dec 28 2019 21:00:00 GMT-0600

And written like this:
  December 28, 2019
*/

var monthNames = ['January', 'February', 'March', 'April', 'May', 'June',
                  'July','August', 'September', 'October','November', 'December'
];

for(var c = document.getElementsByClassName('post-meta'), a = 0; a < c.length; a++) {
  var b = c[a];

  if (b.innerHTML.match(/[A-Za-z]+/)) {
    // Skip because the content is not a date
  } else {
    var d = b.innerHTML.trim().split(/[^0-9]/);
    var date = new Date(Date.UTC(d[0], d[1]-1, d[2], d[3], d[4], d[5]));
    var day = date.getDate();
    var year = date.getFullYear();
    var monthIndex = date.getMonth();

    b.innerHTML = monthNames[monthIndex] + ' ' + day + ', ' + year;
  };
};

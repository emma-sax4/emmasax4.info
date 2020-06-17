/*
This will take all of the dates for the blog posts (written with the class 'date-meta'),
and will render them in the readers' local time, instead of in UTC.

An incoming date/time will be formatted like this:
  2019-12-29 03:00:00 +0000
or like this:
  2019-12-28 21:00:00 -0600

And it will be turned into this (CST) if in UTC time:
  Sat Dec 28 2019 21:00:00 GMT-0600

And written like this:
  December 28, 2019
*/

var dates = document.getElementsByClassName('date-meta');
var monthNames = ['January', 'February', 'March', 'April', 'May', 'June',
                  'July','August', 'September', 'October','November', 'December'
];

for (counter = 0; counter < dates.length; counter++) {
  var htmlDate = dates[counter];
  var dateArray = htmlDate.innerHTML.trim().split(/[^0-9]/);
  var timezone_as_digits = dateArray[dateArray.length - 1];

  if (timezone_as_digits == "+0000") { // UTC timezone
    var localDate = new Date(
      Date.UTC(dateArray[0], dateArray[1]-1, dateArray[2], dateArray[3], dateArray[4], dateArray[5])
    );
  } else {
    var localDate = new Date(
      dateArray[0], dateArray[1]-1, dateArray[2], dateArray[3], dateArray[4], dateArray[5]
    );
  };

  var day = localDate.getDate();
  var year = localDate.getFullYear();
  var monthIndex = localDate.getMonth();
  htmlDate.innerHTML = monthNames[monthIndex] + ' ' + day + ', ' + year;
};

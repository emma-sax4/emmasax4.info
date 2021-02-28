/*
This will take all of the dates for the blog posts (written with the class "date-meta"),
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

const dates = document.getElementsByClassName('date-meta')
const monthNames = ['January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December'
]
let counter = null

for (counter = 0; counter < dates.length; counter++) {
  const htmlDate = dates[counter]
  const dateArrayByDigit = htmlDate.innerHTML.trim().split(/[^0-9]/)
  const dateArrayBySpace = htmlDate.innerHTML.split(' ')
  const timezoneAsDigit = dateArrayBySpace[dateArrayBySpace.length - 1]
  let localDate = null

  if (timezoneAsDigit === '+0000') {
    // Get the local date when it's written as in UTC timezone
    localDate = new Date(
      Date.UTC(
        dateArrayByDigit[0], dateArrayByDigit[1] - 1, dateArrayByDigit[2],
        dateArrayByDigit[3], dateArrayByDigit[4], dateArrayByDigit[5]
      )
    )
  } else {
    // Get the written date in the local timezone (which may not be written timezone)
    const writtenDate = new Date(
      dateArrayByDigit[0], dateArrayByDigit[1] - 1, dateArrayByDigit[2],
      dateArrayByDigit[3], dateArrayByDigit[4], dateArrayByDigit[5]
    )

    // Convert written date in local timezone to UTC timezone
    const utcDateAsNumbers = writtenDate.getTime() - (timezoneAsDigit * 60 * 60 * 10)
    const utcDate = new Date(utcDateAsNumbers)
    const utcYear = utcDate.getFullYear()
    const utcMonth = utcDate.getMonth()
    const utcDay = utcDate.getDate()
    const utcHour = utcDate.getHours()
    const utcMinute = utcDate.getMinutes()
    const utcMilliseconds = utcDate.getMilliseconds()

    // Get the local date when it's written as in UTC timezone
    localDate = new Date(
      Date.UTC(utcYear, utcMonth, utcDay, utcHour, utcMinute, utcMilliseconds)
    )
  };

  const day = localDate.getDate()
  const year = localDate.getFullYear()
  const monthIndex = localDate.getMonth()
  htmlDate.innerHTML = monthNames[monthIndex] + ' ' + day + ', ' + year
};

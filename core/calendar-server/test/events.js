const insertEvent = {
  summary: "Rameses Meeting",
  location: "Cebu City",
  description: "Monthly",
  start: {
    dateTime: "2020-09-10T09:00:00-07:00",
    timeZone: "Asia/Manila"
  },
  end: {
    dateTime: "2020-09-10T12:00:00-07:00",
    timeZone: "Asia/Manila"
  },
  recurrence: ["RRULE:FREQ=DAILY;COUNT=1"],
  attendees: [
    { email: "jzamss@gmail.com" },
    { email: "elmonazareno@gmail.com" }
  ],
  reminders: {
    useDefault: false,
    overrides: [
      { method: "email", minutes: 1440 },
      { method: "popup", minutes: 10 }
    ]
  }
}

module.exports = {
  insertEvent
}
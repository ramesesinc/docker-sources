# Calendar Server

Offers support to manage Google Calendar events. 

## Create Test Credential Account
This guide uses a test account and credential. For production,
LGU should enable a Google Account and Credential.

1. Open web browser and visit https://developers.google.com/calendar/quickstart/nodejs

1. Under Step 1: Turn on the Google Calendar API, click on Enable the Google Calendar API. 

1. Enter <LGUNAME> on the Enter new project name and click Next.

1. On the Configure your OAuth Client, select Desktop App.

1. Click on DOWNLOAD CLIENT CONFIGURATION and save the file "credentials.json". 

1. Copy both the Client ID and Client Key and save it on a file for later reference.

1. Click on Done.

## Configuring and Running Calendar Server

1. Copy "credentials.json" on the "docker/calendar/credentials" folder.

1. Open "docker/calendar/docker-compose" and verify that the credentials
   folder is properly mounted.

1. Run calendar container.


## API

1. Insert event

   __Url__:     /calender/event/insert

   __Method__:  POST

   __Body__ (example json event) : 
   ```json
   {
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
   ```

1. List events

   __Url__:     /calender/event/list

   __Method__:  GET

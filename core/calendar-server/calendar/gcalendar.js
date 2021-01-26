const path = require("path");
const fs = require('fs');
const util = require('util');
const readline = require('readline');
const {google} = require('googleapis');

// If modifying these scopes, delete token.json.
const SCOPES = [
    'https://www.googleapis.com/auth/calendar.readonly', 
    'https://www.googleapis.com/auth/calendar.events'
];

const TOKEN_PATH = path.resolve("credentials",'token.json');
const CREDENTIALS_PATH = path.resolve("credentials",'credentials.json');
let CREDENTIALS;

const loadCredentials = () => {
  const content = fs.readFileSync(CREDENTIALS_PATH);
  CREDENTIALS = JSON.parse(content);
}

let appServer;

const init = (app) => {
  appServer = app;
  loadCredentials();
}

const insertEvent = (req, event) => {
  const insert = (auth, newEvent) => {
    return new Promise((resolve, reject) => {
      const calendar = google.calendar({version: 'v3', auth});
      calendar.events.insert({
        auth: auth,
        calendarId: 'primary',
        resource: newEvent,
      }, function(err, event) {
        if (err) {
          reject('There was an error contacting the Calendar service: ' + err);
        } else {
          console.log(`Event ${event.data.htmlLink} successfully posted`);
          resolve({htmlLink: event.data.htmlLink});
        }
      });
    });
  };
  return authorize(req, event, insert);
}

const listEvents = (req, params) => {
  const list = (auth) => {
    const calendar = google.calendar({version: 'v3', auth});
    return new Promise((resolve, reject) => {
      calendar.events.list({
        calendarId: 'primary',
        timeMin: (new Date()).toISOString(),
        maxResults: 10,
        singleEvents: true,
        orderBy: 'startTime',
      }, (err, res) => {
        if (err) {
          reject('There was an error contacting the Calendar service: ' + err);
        } else {
          const events = res.data.items.map(item => {
            const event = { 
              kind: item.kind, 
              etag: item.etag, 
              creator: item.creator, 
              status: item.status, 
              htmlLink: item.htmlLink, 
              summary: item.summary, 
              description: item.description, 
              location: item.location, 
              start: item.start, 
              end: item.end,
              attendees: item.attendees,
              hangoutLink: item.hangoutLink,
              reminders: item.reminders,
            };
            return event;
          })
          resolve(events);
        }
      });
    });
  };

  return authorize(req, params, list);
}

const authorize = (req, event, callback) => {
  const oAuth2Client = req.oAuth2Client;
  return new Promise((resolve, reject) => {
    fs.readFile(TOKEN_PATH, (err, token) => {
      if (err) {
        reject(getAccessToken(oAuth2Client, callback));
      } else {
        oAuth2Client.setCredentials(JSON.parse(token));
        callback(oAuth2Client, event).then(data => resolve(data));
      }
    });
  });
}

const getAccessTokenUrl = (oAuth2Client) => {
  return oAuth2Client.generateAuthUrl({
    access_type: 'offline',
    scope: SCOPES,
  });
}

const saveAccessToken = (oAuth2Client, accessToken) => {
  return new Promise((resolve, reject) => {
    oAuth2Client.getToken(accessToken, (err, token) => {
      if (err) {
        reject(`Error retrieving access token: ${err}`);
      } else {
        fs.writeFile(TOKEN_PATH, JSON.stringify(token), (err) => {
          if (err) {
            reject(err)
          } else {
            resolve({status: "OK"});
          }
        });
      }
    });
  });
}

const getOAuthClient = () => {
  const {client_secret, client_id, redirect_uris} = CREDENTIALS.installed;
  return new google.auth.OAuth2(client_id, client_secret, redirect_uris[0]);
}

const useCheckAuthorization = async (req, res, next) => {
  try {
    req.oAuth2Client = await checkAuthorization();
    next();
  } catch(err) {
    res.status(401).send("Unauth­orized");
  }
}

const checkAuthorization = () => {
  return new Promise((resolve, reject) => {
    const oAuth2Client = getOAuthClient();
    fs.readFile(TOKEN_PATH, (err, token) => {
      if (err) {
        const authUrl = oAuth2Client.generateAuthUrl({
          access_type: 'offline',
          scope: SCOPES,
        });
        const error = `Invalid credentials. Authorize this app by visiting this url: ${authUrl}`;
        const status = { error }
        reject(status);
      } else {
        oAuth2Client.setCredentials(JSON.parse(token));
        resolve(oAuth2Client);
      }
    });
  });

}

module.exports = {
  init,
  getOAuthClient,
  useCheckAuthorization,
  insertEvent,
  listEvents,
  getAccessTokenUrl,
  saveAccessToken
}
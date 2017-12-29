if (Meteor.isClient) {
  // Replace with your client ID from the developer console.
  var CLIENT_ID = '448772036403-855bf216jb8ht0p1qivht8lkajan854c.apps.googleusercontent.com';
  // Replace with your view ID.
  var VIEW_ID = '9817856';
  // Set the discovery URL.
  var DISCOVERY = 'https://analyticsreporting.googleapis.com/$discovery/rest';
  var SCOPES = ['https://www.googleapis.com/auth/analytics.readonly'];

  function queryReports() {
      // Load the API from the client discovery URL. !!!!!!This function needs to start from an onclick of the button. Otherwise the button disappears when the page is loaded!!!!!!!
      gapi.client.load(DISCOVERY).then(function () {
          // Call the Analytics Reporting API V4 batchGet method. !!!!!! Need to set up an arrangement to enter date ranges and metrics !!!!!! !!!!Results showed 429 sessions, matched in GA Range 2/25 to 3/4!!!!!!!!!
          gapi.client.analyticsreporting.reports.batchGet({
              "reportRequests": [
                  {
                      "viewId": VIEW_ID,
                      "dateRanges": [
                          {
                              "startDate": "30daysAgo",
                              "endDate": "today"
                          }
                      ],
                      "metrics": [
                          {
                              "expression": "ga:sessions"
                          }
                      ]
                  }
              ]
          }).then(function (response) {
              var formattedJson = JSON.stringify(response.result, null, 2);
              document.getElementById('query-output').value = formattedJson;
          }).then(null, function (err) {
              // Log any errors.
              console.log(err);
          });
      });
  }
  function authorize(event) {
      // Handles the authorization flow. `immediate` should be false when invoked from the button click.
      var useImmdiate = event
          ? false
          : true;
      var authData = {
          client_id: CLIENT_ID,
          scope: SCOPES,
          immediate: useImmdiate
      };

      gapi.auth.authorize(authData, function (response) {
          // var authButton = document.getElementById('auth-button');
          if (response.error) {
              // authButton.hidden = false;
          } else {
              // authButton.hidden = true;
              queryReports();
          }
      });
  }

  function executeAnalytics() {
      console.log('gapi -> ', gapi)
    authorize()
  }
Template.gabutton.events({
  //onclick code for Button
  //no function as of 12/26 9:49am
    'click button': function(){
      console.log('You clicked the authorize button. It works')
      executeAnalytics()
    }
});
  // require ('./CallServer.js');

}

if (Meteor.isServer) {
  Meteor.startup(function () {
    // code to run on server at startup
  });
}

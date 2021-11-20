## Not run:
library(RGoogleAnalytics)
# Generate the oauth_token object obtained from Google Developer Console. 
# From the projects list, select a project or create a new one.
# Create a credential, then select a native app.
# Label it.  Google rllll. 
oauth_token <- Auth(client.id = "48148430071-tb4ofiocmaautdlfvp6fafeh9sbn4kvq.apps.googleusercontent.com",
                    client.secret = "g8zMdVjAeMy5rL1WIZStUpD7")
# code for this project: 4/Xx8euxACah80SKNPLWlP9MhVirnNeNiJw7l3RG4r-kA
# Save the token object for future sessions
save(oauth_token, file="oauth_token")
# Load the token object
load("oauth_token")
## End(Not run)
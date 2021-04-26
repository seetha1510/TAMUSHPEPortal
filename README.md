ReadMe 

##  What Does It Do?   

Our product was developed to serve as a networking application for the TAMU SHPE student organization. TAMU Society of Hispanic Professional Engineers, is a student organization at Texas A&M University and is branch of the SHPE national organization.  

Members and alumni of this organization can create profiles, add personal information, and search for other members and alumni based on several criteria. The intention of the application is to increase the interaction between current members and alumni of the organization. We developed the application using a combination of Ruby on Rails, Heroku, GitHub, RSpec, Jira, and others.  

Our goal for the product we developed is to aid TAMU SHPE in their goals of increasing member’s network outreach potential. 
##  What Is Needed To Use It? 

The prerequisite of this application are: 

The following packages and tools were used in the project: 

•Ruby 3.0.0   

•Rails 6.1.2   

•Bootstrap 5.0.0 –To aid in frontend design and mobile friendliness   

•rspec-rails–To aid in testing source code   

•Heroku   

•PostgreSQL13.2   

•GitHub   

•Active-Storage-Validations –To aid in validating image attachments in rails models   

•AWS-SDK-s3 –To aid in connecting rails to AWS S3 service   

•Omniauth 1.9.1 -To configure rails to allow Google Cloud Authentication   

•Devise –To aid in directing application use for authenticated and unauthenticated users   

•Omniauth-google-oauth2 –To configure rails to allow Google Cloud Authentication   
##  How Do I Install It? 

To install our application, you first need to clone this GitHub repository. After downloading the source code onto your machine, ensure that you have the dependencies listed above installed on your machine. Next, you will need to run the following commands from inside the source code directory, to make our application operational:   

1)  bundle install  

2) yarn install  

The project is now set up but not operational. The following commands will instantiate the database and populate it with our models.   

1) rails db:create  

2) rails db:migrate  

Now, everything should be set up for the application. If you want to run the application locally, you may run the following command:   

1) rails server 

 

##  How Do I Update the Online App? 

In order to update the application that is hosted on Heroku, you must add new code to the master branch on you GitHub remote repository. This can be in the form of a git commit, merge, or push. Once this is done, the GitHub actions that are set in place on the repository will handle the CI/CD process such as regression testing, integration testing, and deployment to Heroku. 

 

##  How Do I Test It? 

To run the default test for this application, do: 

1.) Open a new terminal in the root folder 

2.) Bundle exec rspec spec 

To add more test for this application: 

1.) go to spec folder inside root 

2.) add test under the respective folders. 

To learn more about rspec testing, go to rspec documentation 

##  How Do I Use It? 

The product is an interactive website. The website is secure and can be accessed only by those approved by the admins in the organization.  

 

== Example Usage == 

The following is the way to approve your account in the console while developing, after you logged in with Google Oauth 

rails console 

User.find(1).update(approved_status: true) 

quit 

 

== Example Usage == 

The following is the way to make the your account an admin after signing in.  

rails console 

User.find(1).update(admin_status: true) 

quit 

 

 

##  How Do I Get Support? 

We have created user and admin documentation for support on how to use the website. Under the “Help” section you will see “FAQ” and “User Guide” pages. The “FAQ” section will provide solutions to issues we think many users will encounter. The “User Guide” page contains extensive user documentation that explains in detail the functionality of each page on the website. Lastly, Admins have access to documentation specific to them which can be found in “Admin” -> “Documentation”. This page provides a detailed description of the features in each page that only Admins have access to. 

This is a Rails application so the best source for development support would be the Ruby on Rails website. Our team found this to be a very useful resource when trying to figure out an issue. 

https://guides.rubyonrails.org/ 

###Other Resources for Maintaining Code 

Google OAuth:  https://developers.google.com/identity/protocols/oauth2 

Amazon S3:  https://docs.aws.amazon.com/s3/index.html 

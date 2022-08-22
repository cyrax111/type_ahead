# Type Ahead Test App

This is a solution of a test task.

## From author

This app additional support:
* two languages: English and Arabian. It is easy to add new ones;
* light and dark themes;
* animation while switching to a details screen and back.

What needs to do (I had only a weekend):
* add golden tests and widget tests;
* add handling of exceptions;
* add support of large screens.

## Test task description

#### Summary
Write a type ahead (search view with results – Search and Listing screen) against the Seat Geek API. The type ahead should update a list of results as the search query changes. Results can be tapped to view them on a details screen.

#### Requirements
* Write a type ahead against the Seat Geek API - (search view with results – Search and Listing screen)
* Make a detail screen so the user can drill down into a result
* Include instructions for building the application and any relevant documentation in a README.md file
* Please post your submission on Github, Bitbucket or Gitlab
* Make this flutter app work for both iOS and Android platforms


#### Optional
* Mac Desktop support
* The detail screen should allow the user to favorite/unfavorite the event
* Type ahead results should reflect the favorited state of each event
* Favorited results should be saved between launches of the app

## How to build

#### Update localization
for updating localization run:
`flutter pub run easy_localization:generate -S assets/translations -f keys -o locale_keys.g.dart`

#### Android
for building an android app run:
`flutter build appbundle`

#### Ios
for building an ios app run:
`flutter build ios`

#### Mac
for building a macos app run:
`flutter build macos`

#### Seat Geek API account for testing
Client ID: Mjg1NjA4MTZ8MTY2MDk4NDc5MS40MzM1ODY
0a3836d4bb5b1c85719f4bd6f2c1f91cb5649960591b399ba5a4e18eb687e473
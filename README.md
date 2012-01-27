Embedded Buildpack
==================

Usage
-----

To embedded an app-specific buildpack, create a `.buildpack` directory in the root of your app
with your buildpack inside. Then set this the Embedded Buildpack as your app's actual buildpack:

    heroku create --stack cedar --buildpack git://github.com/rbrainard/heroku-buildpack-embedded.git

During the build phases, the Embedded Buildpack will forward the commands to your own buildpack.

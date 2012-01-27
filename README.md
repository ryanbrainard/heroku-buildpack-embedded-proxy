Embedded Buildpack Proxy
========================

A buildpack that proxies execution to a custom buildpack embedded within an app.

Usage
-----

To embedded an app-specific buildpack, create a `.buildpack` directory in the root of your app
with your buildpack inside. Then set this the Embedded Buildpack Proxy as your app's actual buildpack:

    heroku create --stack cedar --buildpack git://github.com/rbrainard/heroku-buildpack-embedded-proxy.git

During the build phases, the Embedded Buildpack Proxy will forward the commands to your own buildpack.

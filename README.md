# The Blog

Simple app that displays blog posts

- The project was setup with configuration files in order to facilitates the edition of some settings and algo the API base url.
- The project uses the Ivorywhite framework as an abstraction to the network client libraey. The Ivorywhite framework is developed by me as well and is a work in progress.
- The Services module has the implementations of the Ivorywhite protocols and the BlogApi service used by the main app
- There is a specific worker for downloading images, it is called ImageWorker. The image cache is injected to this worker in order to avoid redownloading the displayed images.
- It is assumed that all posts have an imageURL. If this url is broken some way, the app displays an image placeholder.

App icon made by Flat Icons - https://www.flaticon.com

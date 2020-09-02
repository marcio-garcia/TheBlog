#The Blog

Simple app that displays blog posts

- The project was setup with configuration files in order to facilitates the edition of some settings as the API base url.
- The project uses the Ivorywhite framework as an abstraction to the network client library. The Ivorywhite framework is under development by me as well in a different repo.
- The Services module has the implementations of the Ivorywhite protocols and the BlogApi service used by the main app.
- There is a specific worker for downloading images, it is called ImageWorker. The image cache is injected to this worker in order to avoid redownloading the displayed images.
- It is assumed that all posts have an imageURL. If this url is broken some way, the app displays an image placeholder. I'd rather display a different cell with no imageView.
- I concentrated the unit tests on the business logic, that being said, the total test coverage is still low, around 24%.
- The Services and DesignSystem frameworks were created in a project subfolder in order to keep the code in one repo. The only exception is the Ivorywhite module as it is in development as a separated project.

## Installation

Run the following command in the directory of the TheBlog and Services projects in order to install the dependency.

```ogdl
carthage bootstrap
```

App icon made by Flat Icons - https://www.flaticon.com

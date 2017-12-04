# InstaClient
App build using Xcode9 + cocoapods1.3.1

# Task
The test task is to implement a simplified version of Instagram client.
It should contain:
* Auth via Instagram (implicit version)
* Display recent media of user, which ID can be entered in text field. List item should contain: author name, text, likes count. Do not spend too much time on UI layout.
* Implement your own cache for images. Cache parameters: LRU, 25Mb, RAM-only.
* Cover your code with unit tests.
* Use Instagram API in Sandbox mode.

## Notes:
* SDK

Sandbox mode for some reasons prevents pagination info to be fetched, so only 1 page could be retrieved ¯\_(ツ)_/¯ 

Also other user can’t be used to get recent media but ID of my current user works. On the Dev Console there is an invite opportunity to test other accounts. 

* Oauth 

There are some issues with Instagram Oauth. I’ve spent some time trying to use SFSafariViewController and SFAuthenticationSession but no luck. The thing is instagram doesn’t allow to use url-schema as callback url. Maybe there is some neat way to solve this issue but I went with regular UIWebView request sniff. 

* Tests

Mine Xcode have some issues with code coverage reports. Don’t know if this is a configuration issue. It says the coverage is 0%, but you can clearly see test cases steps on the right panel. 
All services are covered. I left models and viewControllers alone, but it’s pretty easy to cover them too.



This is a reference project I am working on to test and demonstrate some new technologies.
It is a cloud based static site RSS reader influenced by [Google Reader](https://www.google.com/reader/about/).
I was quite pissed when it went offline, so decided to build my own, using technologies I am familiar with.


This project uses the Jekyll blogging engine, though I'm not using any of its blogging capabilities. I will probably strip it down at some point.
The UI is based on [Minimal Block](https://github.com/drvy/minimal-block) Jekyll Theme.
User management and data is storage is hanled by [Kii Cloud](http://en.kii.com/), a mBaas provider I used to work for.
I use [angular-strap](https://github.com/mgcrea/angular-strap) as js/css scaffolding of the site. The js is written in [CoffeeScript](http://coffeescript.org/),
templates are in [slim](http://slim-lang.com/), js dependencies are managed by [bower](http://bower.io/).


I am planning to add iOS and Android versions, and also versions built with [Cordova](https://cordova.apache.org/), [RubyMotion](http://www.rubymotion.com/) (if I can make the Kii iOS SDK work with it),
[ionic](http://ionicframework.com/) and [flutter](http://flutter.io/). And also maybe setup Kii analytics.


You can see a live version [here](http://kiiss.coze.org)


License
----------------
The MIT License (MIT)

    Copyright (c) 2015 Arda Karaduman

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.

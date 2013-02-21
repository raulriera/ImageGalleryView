#ImageGalleryView:
**ImageGalleryView** is multi platform (iOS and Android) view to display images very similar to the `Photos.app` on the iPhone. 

![Listing](https://github.com/raulriera/ImageGalleryView/blob/master/examples/List.png) ![Detail](https://github.com/raulriera/ImageGalleryView/blob/master/examples/Detail.png)

##Usage:
In your app.coffee (or elsewhere), call:

```coffeescript
ImageGallery = require "ImageGalleryView"

images = [
	id: 0
	small: 'http://placekitten.com/g/120/80'
	large: 'http://placekitten.com/g/960/640'
,
	id: 1
	small: 'http://placekitten.com/g/120/80'
	large: 'http://placekitten.com/g/960/640'
,
	id: 0
	small: 'http://placekitten.com/g/120/80'
	large: 'http://placekitten.com/g/960/640'
,
	id: 1
	small: 'http://placekitten.com/g/120/80'
	large: 'http://placekitten.com/g/960/640'
,
	id: 0
	small: 'http://placekitten.com/g/120/80'
	large: 'http://placekitten.com/g/960/640'
,
	id: 1
	small: 'http://placekitten.com/g/120/80'
	large: 'http://placekitten.com/g/960/640'
,
	id: 0
	small: 'http://placekitten.com/g/120/80'
	large: 'http://placekitten.com/g/960/640'
,
	id: 1
	small: 'http://placekitten.com/g/120/80'
	large: 'http://placekitten.com/g/960/640'
]

imageGallery = new ImageGallery images
```

In your app.js (or elsewhere), call
```javascript
ImageGallery = require("ImageGalleryView");

images = [
  {
    id: 0,
    small: 'http://placekitten.com/g/120/80',
    large: 'http://placekitten.com/g/960/640'
  }, 
  {
    id: 1,
    small: 'http://placekitten.com/g/120/80',
    large: 'http://placekitten.com/g/960/640'
  }, 
  {
    id: 0,
    small: 'http://placekitten.com/g/120/80',
    large: 'http://placekitten.com/g/960/640'
  }, 
  {
    id: 1,
    small: 'http://placekitten.com/g/120/80',
    large: 'http://placekitten.com/g/960/640'
  }, 
  {
    id: 0,
    small: 'http://placekitten.com/g/120/80',
    large: 'http://placekitten.com/g/960/640'
  }, 
  {
    id: 1,
    small: 'http://placekitten.com/g/120/80',
    large: 'http://placekitten.com/g/960/640'
  }, 
  {
    id: 0,
    small: 'http://placekitten.com/g/120/80',
    large: 'http://placekitten.com/g/960/640'
  }, 
  {
    id: 1,
    small: 'http://placekitten.com/g/120/80',
    large: 'http://placekitten.com/g/960/640'
  }
];

imageGallery = new ImageGallery(images);
```

##About:
Created by Raul Riera, [@raulriera](http://twitter.com/raulriera)  

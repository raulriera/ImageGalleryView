###
	ImageGalleryView, it will accept an array of 'image' objects,
	composed of 'id,small,large'. Optionally you can also pass a 
	headerView and a footerView pretty much like a TableView
	
	Created by @raulriera but heavily inspired by https://github.com/codeboxed/Titanium-Image-Gallery
###
ImageGalleryView = (images, headerView, footerView) ->
	
	isAndroid = Titanium.Platform.osname is "android"
	
	# create the container that will hold all the thumbnails	
	self = Ti.UI.createScrollView
		top: 0
		bottom: 0
		right: -1
		left: -1
		contentWidth: Titanium.UI.FILL
		contentHeight: "auto"
		layout: "horizontal"
	
	createGalleryWindow = (currentPhoto = 0) ->
		imageWindow = Titanium.UI.createWindow
			backgroundColor: '#000'
			tabBarHidden: true
			navBarHidden: true
			orientationModes: [Ti.UI.LANDSCAPE_LEFT, Ti.UI.LANDSCAPE_RIGHT, Ti.UI.PORTRAIT]
		
		closeButton = Titanium.UI.createButton
			backgroundColor: "#55000000"
			backgroundImage: null
			borderColor: '#fff'
			borderRadius: 4
			borderWidth: 1
			width: '44dp'
			height: '24dp'
			font:
				fontSize: '11dp'
			color: '#fff'
			title: L("gallery_close")
			top: '10dp'
			left: '10dp'
			
		viewsArray = []
	  
		photosView = Titanium.UI.createScrollableView
			top: 0
			left: 0
			right: 0
			bottom: 0
			showPagingControl: false
			currentPage: 0

		i = 0
		b = images.length
	
		while i < b
			
			image = Ti.UI.createImageView
				backgroundColor: "#000"
				image: images[i].large
				width: '100%'
			
			if not isAndroid
				scrollView = Titanium.UI.createScrollView
					maxZoomScale: 4
					minZoomScale: 1
			
				scrollView.add image
			
			viewsArray.push if isAndroid then image else scrollView
			i++
	    
		photosView.views = viewsArray
		photosView.currentPage = currentPhoto
		
		closeButton.addEventListener "click", (e) ->
			imageWindow.close()
				
		imageWindow.add photosView
		imageWindow.add closeButton
		
		imageWindow
	
	createThumbnail = (image, index) ->
		view = Ti.UI.createImageView
			image: image.small
			width: '70dp'
			height: '70dp'
			top: '8dp'
			left: '8dp'
			id: image.id
			index: index
	
	onThumbnailTouched = (e) ->
		if e.source.id?
			self.fireEvent "thumbnailTouched", { image: e.source }
			window = createGalleryWindow e.source.index
			window.open()

	self.addEventListener "click", onThumbnailTouched
	
	if headerView
		self.add headerView
	
	for image,index in images
		self.add createThumbnail image, index
	
	if footerView
		self.add footerView
	
	self

module.exports = ImageGalleryView
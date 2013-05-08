###
	ImageGalleryView, it will accept an array of 'image' objects,
	composed of 'id,small,large'. Optionally you can also pass a 
	headerView and a pageSize (for paginated galleries)
	
	@params
	@images: array of image objects with the properties "id, small, large"
	@headerView: a view to place on before the actual thumbnails
	@pageSize: specify a value greater than 0 in order to paginate the gallery
	
	Created by @raulriera but heavily inspired by https://github.com/codeboxed/Titanium-Image-Gallery
###
ImageGalleryView = (images, headerView, pageSize = 0) ->
	
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
		showVerticalScrollIndicator: true
			
	# removed the ability to specify a "footer" view" and changed it for a
	# load more button if the pageSize is greater than 0	
	if pageSize > 0
		# these flags let's us control the pagination
		currentPage = 1
		
		loadMoreButton = Titanium.UI.createButton
			title: "Load more"
			height: 44
			left: 10
			right: 10
			top: 10
			bottom: 10
	
	createGalleryWindow = (currentPhoto = 0) ->
		imageWindow = Titanium.UI.createWindow
			backgroundColor: '#000'
			tabBarHidden: true
			navBarHidden: true
			orientationModes: [Ti.UI.LANDSCAPE_LEFT, Ti.UI.LANDSCAPE_RIGHT, Ti.UI.PORTRAIT]
		
		closeButton = Titanium.UI.createButton
			backgroundColor: '#55000000'
			backgroundImage: null
			borderColor: '#fff'
			borderRadius: 4
			borderWidth: 1
			width: '44dp'
			height: '24dp'
			font:
				fontSize: '11dp'
			color: '#fff'
			title: 'Close'
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
	
	addImagesToQueue = ->
		# if the pageSize is 0, or the image count is lower than the pageSie
		# then display all the images
		if pageSize is 0 || images.length < pageSize 
			for image in images
				self.add createThumbnail image
		# otherwise, start our pagination	
		else			
			if currentPage > 1
				# remove the load more button
				self.remove loadMoreButton
			
			# set the boundaries
			startsAt = (currentPage-1) * pageSize
			endsAt = currentPage * pageSize
			
			# divide the array into pieces
			imagesPaginated = images.slice startsAt, endsAt
			currentPage = currentPage + 1
			
			# fill the gallery
			for image in imagesPaginated
				self.add createThumbnail image
				
			# add the load more button
			if (currentPage-1) < Math.ceil images.length / pageSize
				self.add loadMoreButton	

	self.addEventListener "click", onThumbnailTouched
	if pageSize > 0
		loadMoreButton.addEventListener "click", addImagesToQueue
	
	if headerView
		self.add headerView
	
	# start adding the images
	addImagesToQueue()
	
	self

module.exports = ImageGalleryView

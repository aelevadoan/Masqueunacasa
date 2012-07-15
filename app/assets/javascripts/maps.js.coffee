
options = (center) ->
  mapOptions =
    center: center,
    zoom: 5,
    mapTypeId: google.maps.MapTypeId.HYBRID,
    streetViewControl: false

extractLocations = (divs) ->
  locations = []
  divs.each ->
    lat = $(this).data('latitude')
    lon = $(this).data('longitude')
    location = new google.maps.LatLng(lat, lon)
    locations.push location
  locations

createMap = (container, center) ->
  mapCanvas = container
  mapCanvas.css({'width': '100%'}).height(mapCanvas.width())
  map = new google.maps.Map(mapCanvas.get(0),
          options(center))

$.fn.extend
  showMap: ->
    return this.each ->
      center = new google.maps.LatLng(40.24, -3.24)
      map = createMap $(this).find('.map'), center

      locations = extractLocations $(this).find('.location')
      $.each locations, ->
        new google.maps.Marker
          position: this,
          map: map

$.fn.extend
  mapForForm: ->
    return this.each ->
      center = new google.maps.LatLng(40, -3)
      map = createMap $(this).find('.map'), center

      inputLat = $(this).find('[id*="latitude"]')
      inputLon = $(this).find('[id*="longitude"]')
      lat = inputLat.val()
      lon = inputLon.val()

      # TODO: repasar esto!
      #inputLat.attr('disabled', 'disabled')
      #inputLon.attr('disabled', 'disabled')


      marker = new google.maps.Marker
        map: map

      if lat and lon
        position = new google.maps.LatLng(lat, lon)
        marker.setPosition(position)

      google.maps.event.addListener map, 'click', (event) ->
        position = event.latLng.toUrlValue().split(",")
        inputLat.val(position[0])
        inputLon.val(position[1])
        marker.setPosition(event.latLng)
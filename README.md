Telll Web Services
===================

# End Points

# POST /login 
Login with username and password

+ Request (application/json)

    + Headers

            X-API-Key: 123

    + Body

            {
                "user_name": "smokemachine",
                "password": "12345",
                "model": "iPad"
            }

+ Response 200 (application/json;charset=UTF-8)

    + Headers

            Access-Control-Allow-Methods: GET, PUT, POST, DELETE, OPTIONS
            Access-Control-Max-Age: 3600
            Vary: Origin
            Access-Control-Allow-Origin: *
            Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With, X-API-Key, X-Auth-Key

    + Body

            {"auth_key":"ab151c3ed8135147509b32c0a9f3d6381ef0a8c2","device":"1461"}

- - -
# POST /login/461
Login with device Id

+ Request (application/json)

    + Headers

            X-API-Key: 123

    + Body

            {
                "user_name": "smokemachine",
                "password": "12345"
            }

+ Response 200 (application/json;charset=UTF-8)

    + Headers

            Access-Control-Allow-Methods: GET, PUT, POST, DELETE, OPTIONS
            Vary: Origin
            Access-Control-Max-Age: 3600
            Access-Control-Allow-Origin: *
            Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With, X-API-Key, X-Auth-Key

    + Body

            {"device":"1461","auth_key":"65b8e748b316f340cf87425426cc431d82960123"}

- - -

# POST /app/track_motion/54/click

+ Request (application/json)

    + Headers

            X-Auth-Key: 24cba4ea481ffbd5ef11eb003e6c541f4c42f7a3
            X-API-Key: 123

    + Body

            {
                "x": 0,
                "y": 0,
                "t": 0
            }

+ Response 200 (application/json;charset=UTF-8)

    + Headers

            Access-Control-Allow-Origin: *
            Access-Control-Max-Age: 3600
            Access-Control-Allow-Methods: GET, PUT, POST, DELETE, OPTIONS
            Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With, X-API-Key, X-Auth-Key
            Vary: Origin, Origin

    + Body

            {"sent":true}

- - - 
- - - 

Movie operations
----------------

# POST /app/movie
movie create

+ Request (application/json)

    + Headers

            X-Auth-Key: ab151c3ed8135147509b32c0a9f3d6381ef0a8c2
            X-API-Key: 123

    + Body

            {
                "title": "",
                "description": ""
            }

+ Response 201 (application/json;charset=UTF-8)

    + Headers

            Access-Control-Allow-Methods: GET, PUT, POST, DELETE, OPTIONS
            Access-Control-Max-Age: 3600
            Vary: Origin
            Access-Control-Allow-Origin: *
            Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With, X-API-Key, X-Auth-Key

    + Body

            {"id":"112","created":true}

- - -

# GET /app/movie/112
get movie by id

+ Request (application/json)

    + Headers

            X-Auth-Key: ab151c3ed8135147509b32c0a9f3d6381ef0a8c2
            X-API-Key: 123

    + Body

            {}

+ Response 200 (application/json;charset=UTF-8)

    + Headers

            Access-Control-Max-Age: 3600
            Access-Control-Allow-Methods: GET, PUT, POST, DELETE, OPTIONS
            Vary: Origin, Origin
            Access-Control-Allow-Origin: *
            Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With, X-API-Key, X-Auth-Key

    + Body

            {"id":"112","category":"NYI","author":"NYI","cript":"NYI","player":{"_":"NYI"},"description":"","media":{"_":"NYI"},"title":""}

- - - 

# GET /app/movie/0/photolinks
get photolinks from movie with movieId

+ Request

    + Headers

            X-Auth-Key: ab151c3ed8135147509b32c0a9f3d6381ef0a8c2
            X-API-Key: 123



+ Response 200 (application/json;charset=UTF-8)

    + Headers

            Vary: Origin, Origin
            Access-Control-Max-Age: 3600
            Access-Control-Allow-Methods: GET, PUT, POST, DELETE, OPTIONS
            Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With, X-API-Key, X-Auth-Key
            Access-Control-Allow-Origin: *

    + Body

            {"photolinks":[{"thumb":"http:\/\/www.clker.com\/cliparts\/6\/f\/f\/3\/1197086068917675051egore_Thumb_Up_.svg","photolink":{"title":null,"description":null,"link":[],"sponsor":"NYI","id":"1","role":"NYI","category":"NYI"}},{"thumb":"http:\/\/www.clker.com\/cliparts\/6\/f\/f\/3\/1197086068917675051egore_Thumb_Up_.svg","photolink":{"title":null,"description":null,"sponsor":"NYI","link":[],"role":"NYI","id":"1","category":"NYI"}},{"photolink":{"category":"NYI","sponsor":"NYI","link":[],"id":"1010","role":"NYI","description":"jLSS682HmX4vYmV83dfhyKAgsntDyo0kKWnStGp2bkuo54lWrC2rtLrhwbuN3lHNAYRHY7w1fitCXPnd3G6ONkoGwpuYtwThxA6oReVbfK1JsvHFycPsqjrq77Qeh5OxWcVculjc5HwlIy1j8utcCrbgqxO0rGmDSwelwp7tpQLSka8yjK0eBT6bGsipobQOJTvNwsqvDQfTio33DgqgDjhqTkuB8XyTKt6ybicuHMMGhqAn5MFgWipyi1","title":"cvIFieeHRVktF8H6rwmlr0hibxwqG1Am"},"thumb":"http:\/\/www.clker.com\/cliparts\/6\/f\/f\/3\/1197086068917675051egore_Thumb_Up_.svg"},{"thumb":"http:\/\/www.clker.com\/cliparts\/6\/f\/f\/3\/1197086068917675051egore_Thumb_Up_.svg","photolink":{"title":"QvoIi5Jl6l6wSm3S6uLXxRKyOy1l4Su5","description":"LuSsr3PLOVX8v1bhI4lBHu7gb7v6e26jJ77dtcsfUEuQVxkCEDXnFoD04FKmHappnOFtYAkoaN0YRXwrVbwFEN43pS3q3hcwfgSLPyHG68lH0jP0b5W6iU0BVrkvYTE56uCN13r35YFyQtUDy10DTiBWoaVDPXeXuPEhH2e0dj2fDDNrYXljaMOIdg0Xy3AnY7TcFQXVSjlys31QOwgWSf4niurNjiC3DoQYR8gxR75dn3XVJNpRb8ILJs","link":[],"role":"NYI","sponsor":"NYI","id":"1016","category":"NYI"}},{"thumb":"http:\/\/www.clker.com\/cliparts\/6\/f\/f\/3\/1197086068917675051egore_Thumb_Up_.svg","photolink":{"category":"NYI","role":"NYI","link":[],"sponsor":"NYI","id":"1017","description":"g47pSO1IbRgJS7s30RGBMuLuCn7vE2dcGNlBRiaYBSKEkKkoS5bkAtyQxWec1TasC1RfGD3mdPjuHVqiseKtGpHqRGmXcIyPnbeIYIfuCArSx2wNpX23b6frvLofMr4onXPf1pbH1W0TO3KLQKNoAGFR5RuTmfl58JMVGo7Nbfss5Co1PYpoOjDe4w4YyF2B6krpTULkToc7Pf5K1xbDuAwaQLBATR5SJIOd6gyeywl7ciHPWBJe2vyOdi","title":"sF6gntHK1kDa6PaysKPUVAiC2sNxm2p6"}},{"thumb":"http:\/\/www.clker.com\/cliparts\/6\/f\/f 
......


- - -

# DELETE /app/movie/112
delete movie by movie id

+ Request

    + Headers

            X-Auth-Key: ab151c3ed8135147509b32c0a9f3d6381ef0a8c2
            X-API-Key: 123



+ Response 200 (application/json;charset=UTF-8)

    + Headers

            Access-Control-Allow-Methods: GET, PUT, POST, DELETE, OPTIONS
            Access-Control-Max-Age: 3600
            Access-Control-Allow-Origin: *
            Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With, X-API-Key, X-Auth-Key
            Vary: Origin, Origin

    + Body

            {"deleted":true}

- - - 


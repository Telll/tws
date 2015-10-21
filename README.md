# tws
Telll web services.

It responds to player, sender and receiver calls.

## Features
-   Auth
-   
# End Points

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


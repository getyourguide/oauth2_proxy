# Development Environment

Clone the repository under your $GOPATH. Ex. if your $GOPATH is `~/go` the repository should be cloned to `~/go/src/github.com/getyourguide/oauth2_proxy`.

Inside the project directory get the dependencies by running:

```bash
~/go/src/github.com/getyourguide/oauth2_proxy$ go get .
```

This is necessary for the first time. Now you can build by running:

```bash
~/go/src/github.com/getyourguide/oauth2_proxy$ go build .
```

This will create the binary `oauth2_proxy` in the same directory. You can now run locally with the latest changes. You can set a few configuration flags as the following:

```bash
export OAUTH2_PROXY_CLIENT_ID=xxxxxxxxxxxxxxxxxxxx.apps.googleusercontent.com
export OAUTH2_PROXY_CLIENT_SECRET=xxxxxxxxxxxxx
export OAUTH2_PROXY_UPSTREAM=http://host.docker.internal:8081/
```

```bash
~/go/src/github.com/getyourguide/oauth2_proxy$ ./oauth2_proxy --email-domain=getyourguide.com --cookie-secure=false --cookie-secret=xxxxxxxxxxxxxxxxxxx  --oidc-issuer-url=https://accounts.google.com --set-id-token
2018/06/21 10:12:52 oauthproxy.go:159: OAuthProxy configured for Google Client ID: xxxxxxxxxxxxxxxxxxxx.apps.googleusercontent.com
2018/06/21 10:12:52 oauthproxy.go:165: Cookie settings: name:_oauth2_proxy secure(https):false httponly:true expiry:168h0m0s domain: refresh:disabled
2018/06/21 10:12:52 http.go:49: HTTP: listening on 127.0.0.1:4180
```

The nginx example uses `oauth2_proxy` to authenticate and returns the id_token from google. You can run using the example docker-compose.

````bash
~/go/src/github.com/getyourguide/oauth2_proxy/examples/nginx$ docker-compose stop && docker-compose rm -f && sudo docker-compose up
Going to remove nginx_nginx_1
Removing nginx_nginx_1 ... done
Creating nginx_nginx_1 ... done
Attaching to nginx_nginx_1
nginx_1  | 172.23.0.1 - - [21/Jun/2018:08:19:43 +0000] "GET / HTTP/1.1" 200 2541 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36" "-" "" "" ""
nginx_1  | 172.23.0.1 - - [21/Jun/2018:08:19:44 +0000] "GET /favicon.ico HTTP/1.1" 200 2552 "http://localhost/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36" "-" "" "" ""
```

On your browser access http://localhost and sign in. If everything worked is expected to see the id token on nginx logs on the last column.

```
nginx_1  | 172.23.0.1 - - [21/Jun/2018:08:22:50 +0000] "GET /favicon.ico HTTP/1.1" 502 575 "http://localhost/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36" "-" "" "" "eyJhbGciOiJSUzI1NiIsImtpZCI6ImRhZDQ0NzM5NTc2NDg1ZWMzMGQyMjg4NDJlNzNhY2UwYmMzNjdiYzQifQ.eyJhenAiOiIxMDgyODA5OTk0ODI0LTdqaTk5cWZxbmYwcDJsZ3ZzazFwb2JncGdwcTJ2cDliLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwiYXVkIjoiMTA4MjgwOTk5NDgyNC03amk5OXFmcW5mMHAybGd2c2sxcG9iZ3BncHEydnA5Yi5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsInN1YiI6IjEwNzI3MTI2MzY5NzYyMzEwNzQyNyIsImhkIjoiZ2V0eW91cmd1aWRlLmNvbSIsImVtYWlsIjoiZmVybmFuZG8uY2FpbmVsbGlAZ2V0eW91cmd1aWRlLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiTDBncURUaHdaaV9PQmx0MTBheVdHUSIsImV4cCI6MTUyOTU3Mjk2NSwiaXNzIjoiaHR0cHM6Ly9hY2NvdW50cy5nb29nbGUuY29tIiwiaWF0IjoxNTI5NTY5MzY1LCJuYW1lIjoiRmVybmFuZG8gQ2FpbmVsbGkiLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDQuZ29vZ2xldXNlcmNvbnRlbnQuY29tLy1FTTRjbkhRR1FGVS9BQUFBQUFBQUFBSS9BQUFBQUFBQUFCUS91aC1TczNqdGM0TS9zOTYtYy9waG90by5qcGciLCJnaXZlbl9uYW1lIjoiRmVybmFuZG8iLCJmYW1pbHlfbmFtZSI6IkNhaW5lbGxpIiwibG9jYWxlIjoiZW4ifQ.fVZhI26l0YX64UpV0EF8C3I8lIFyrkHlfV7SD1g0UOMzJagcJ_huqF1-Y_Nnz1WY2RGHi_mgDklF0eVDcc9wDu7zy3k1qKQKzgG0s6sRRyh7Q-DhDL_aSn9ojNq6llxpFmAZ-IUFb0NC509cDHhfsQyhuSfGG0hUbs1NT__x5fKq34a5s4DbPzqEqCgv4bBhmnAQKrm85FbFcUisS1qHDfpAQrXNWS78NsYURz2XQ-1RBwP9m-CAg6qLSUWlEEHontg7WA15apb1j9c_01Os5st_d2tzbJHRNP3gGQCaHXNxJ5-sjSmrSaRDoAWaMHo0nDt6tgYebuG0hEKuLCPBBB"
```

> Note: The development environment was tested using Go 10.1.2

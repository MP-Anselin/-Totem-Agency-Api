TOTEM AGENCY API DOCUMENT
=======

SETUP DOCKER

1) be sure you have docker on your devise

2) sudo usermod -aG docker $USER (current user)

3) docker-compose up --build

4) stop docker "docker-compose stop"

5) to see the routes available run command "rails routes"

6) first you need api jwt key use the route "client/authentification" in post and pass email and password as parameter
    email: agencytotem59gmail.com
    password: TotO/gen]1.XxZ

7) now you have the jwt key you can execute the other requests

HEADER

change jwt_token by your jxt_token
parameter {Content-Type: 'application/json', Authorization: jwt_token}

[ API KEY JWT ]

```
> |POST| /client/authentication(.:format)
> parameter {"email":"agencytotem59@gmail.com","password":"Tot0/gen]1.XxZ"}
```



                                     USER_PRIVATE                                      

[ USER GENERATE TOKEN ]

```
> GET /user/account/generate(.:format)
> parameter {}
```


[ USER LOG IN / OUT (registered true if the user is already registered) ]

```
> |POST| /user/account/signep(.:format)
> parameter {email: .., password: .., registered: ..}
```


[ USER DELETE ACCOUNT ]

```
> |POST| /user/account/delete(.:format)
> parameter {idToken: ..}
```


[ USER REFRESH TOKEN ]

```
> |POST| /user/account/id/refresh(.:format)
> parameter {grant_type: .., refresh_token}
```


[ USER CHANGE PASSWORD OR EMAIL ]

```
> |POST| /user/account/id/change(.:format)
> parameter {email: .., password: .., idToken: ..}
```


[ USER SEND MAIL TO RESET PWD ]

```
> |POST| /user/account/id/pwd/reset/code/mail(.:format)
> parameter {email: .., requestType: ..}
```


[ USER CHECK PASSWORD WAS CHANGED ]

```
> |POST| /user/account/id/pwd/reset/code/validation(.:format)
> parameter {oobCode: .., newPassword: ..}
```


[ USER SEND MAIL TO CHECK EMAIL USER ]

```
> |POST| /user/account/id/email/code/mail(.:format)
> parameter {idToken: .., requestType: ..}
```


[ USER CHECK EMAIL WAS VALIDATE ]

```
> |POST| /user/account/id/email/code/validation(.:format)
> parameter {oobCode: }
```


[ USER UPDATE USER INFORMATION ]

```
> |POST| /user/account/data/manage(.:format)
> parameter {idToken: .., displayName: .., photoUrl: ..}
```


                                    PRODUCTS

[ PRODUCTS LIST DOCUMENT ]

```
> GET /products/list(.:format)
> parameter {}
```


[ PRODUCTS GET DOCUMENT BY ID]

```
> |POST| /products/product(.:format)
> parameter {id: ..}
```


[ PRODUCTS ADD DOCUMENT]

```
> |POST| /products/product/new(.:format)
> parameter {brand: .., name: .., url: ..}
```


[ PRODUCTS UPDATE DOCUMENT BY ID]

```
> |POST| /products/product/update(.:format)
> parameter {id: .., brand: .., name: ..}
```


[ PRODUCTS DELETE DOCUMENT BY ID]

```
> |POST| /products/product/delete(.:format)
> parameter {id: ..}
```


                                    USERS

[ USER LIST USERS ]

```
> GET /users/list(.:format)
> parameter {}
```


[ USER LIST USER INFORMATION BY ID ]

```
> |POST| /users/user(.:format)
> parameter {}
```


[ USER ADD USER BY ID ]

```
> |POST| /users/user/new(.:format)
> parameter {id: .., firstName: .., lastName: ..}
```


[ USER UPDATE USER BY ID ]

```
> |POST| /users/user/update(.:format)
> parameter {id: .., firstName: .., lastName: ..}
```


[ USER DELETE USER BY ID ]

```
> |POST| /users/user/delete(.:format)
> parameter {id: ..}
```


                                    ASSET_BUCKET

[ BUCKET LIST BUCKET ]

```
> GET /assets/bucket/list(.:format)
> parameter {}
```


[ BUCKET LIST BUCKET FILE ]

```
> |POST| /assets/bucket/multimedia/list(.:format)
> parameter {bucketName: ..}
```


[ BUCKET DOWNLOAD FILE ]

```
> |POST| /assets/bucket/multimedia/download(.:format)
> parameter {bucketName: .., folderPath: .., fileName: .., folderDestination: .., fileNewName: ..}
```


[ BUCKET ADD FILE ]

```
> |POST| /assets/bucket/multimedia/new(.:format)
> parameter {bucketName: .., folderPath: .., fileName: .., folderDestination: .., fileNewName: ..}

> /assets/bucket/multimedia/delete(.:format)
> parameter {bucketName: .., folderPath: .., fileName: ..}
```


                                    MULTIMEDIA


[ MULTIMEDIA LIST DOCUMENTS ]

```
> GET /multimedia/list(.:format)
> parameter {}
```


[ MULTIMEDIA GET DOCUMENT BY ID ]

```
> |POST| /multimedia/media(.:format)
> parameter {id: ..}
```


[ MULTIMEDIA UPDATE DOCUMENTS BY ID ]

```
> |POST| /multimedia/media/update(.:format)
> parameter {id: .., name: .., storage_id: .., storage_path: .., type: ..}
```


[ MULTIMEDIA DELETE DOCUMENTS BY ID ]

```
> |POST| /multimedia/media/delete(.:format)
> parameter {id: ..}
```


                                    USERS_MULTIMEDIA


[ USERS_MULTIMEDIA LIST DOCUMENTS ]

```
> GET /users_multimedia/list(.:format)
> parameter {}
```


[ USERS_MULTIMEDIA GET DOCUMENT BY ID]

```
> |POST| /users_multimedia/information(.:format)
> parameter {id: ..}
```


[ USERS_MULTIMEDIA GET DOCUMENT BY USER ID]

```
> |POST| /users_multimedia/information/user(.:format)
> parameter {user_id: ..}
```


[ USERS_MULTIMEDIA GET DOCUMENT BY MULTIMEDIA ID]

```
> |POST| /users_multimedia/information/multimedia(.:format)
> parameter {multimedia_id: ..}
```


[ USERS_MULTIMEDIA ADD DOCUMENT ]

```
> |POST| /users_multimedia/new(.:format)
> parameter {user_id: .., multimedia_id ..}
```


[ USERS_MULTIMEDIA UPDATE DOCUMENT BY ID ]

```
> |POST| /users_multimedia/update(.:format)
> parameter {id: .., user_id: .., multimedia_id ..}
```


[ USERS_MULTIMEDIA DELETE DOCUMENT BY ID ]

```
> |POST| /users_multimedia/delete(.:format)
> parameter {id: ..}
```

                                    PRODUCTS_MULTIMEDIA


[ PRODUCTS_MULTIMEDIA LIST DOCUMENTS ]

```
> GET /products_multimedia/list(.:format)
> parameter {}
```


[ PRODUCTS_MULTIMEDIA GET DOCUMENT INFORMATION BY ID ]

```
> |POST| /products_multimedia/information(.:format)
> parameter {id: ..}
```


[ PRODUCTS_MULTIMEDIA GET DOCUMENT BY PRODUCT ID ]

```
> /products_multimedia/information/product(.:format)
> parameter {product_id: ..}
```


[ PRODUCTS_MULTIMEDIA GET DOCUMENT BY MULTIMEDIA ID ]

```
> |POST| /products_multimedia/information/multimedia(.:format)
> parameter {multimedia_id: ..}
```


[ PRODUCTS_MULTIMEDIA ADD DOCUMENT ]

```
> |POST| /products_multimedia/new(.:format)
> parameter {multimedia_id: .., product_id: ..}
```


[ PRODUCTS_MULTIMEDIA UPDATE DOCUMENT BY ID]

```
> |POST| /products_multimedia/update(.:format)
> parameter {id: .., multimedia_id: .., product_id: ..}
```

[ PRODUCTS_MULTIMEDIA DELETE DOCUMENT BY ID ]

```
> |POST| /products_multimedia/delete(.:format)
> parameter {id: ..}
```


                                    BEACON_PATHS


[ BEACON_PATHS LIST DOCUMENT ]

```
> GET /beacon/paths/list(.:format)
> parameter {}
```


[ BEACON_PATHS GET DOCUMENT BY ID]

```
> |POST| /beacon/path(.:format)
> parameter {id: ..}
```


[ BEACON_PATHS ADD DOCUMENT]

```
> |POST| /beacon/path/new(.:format)
> parameter {y_axe: .., x_axe: .., z_axe: ..}
```

[ BEACON_PATHS DELETE DOCUMENT BY ID]

```
> |POST| /beacon/path/delete(.:format)
> parameter {id: ..}
```


                                    BEACON_PATH_COORDINATES


[ BEACON_PATH_COORDINATES LIST DOCUMENT ]

```
> GET /beacon/path/coordinates/list(.:format)
> parameter {path_id: ..}
```


[ BEACON_PATH_COORDINATES GET DOCUMENT BY ID]

```
> |POST| /beacon/path(.:format)
> parameter {path_id: .., id: ..}
```


[ BEACON_PATH_COORDINATES ADD DOCUMENT]

```
> |POST| /beacon/path/new(.:format)
> parameter {path_id: .., y_axe: .., x_axe: .., z_axe: ..}
```


[ BEACON_PATH_COORDINATES UPDATE DOCUMENT BY ID]

```
> |POST| /beacon/path/update(.:format)
> parameter {path_id: .., id: .., y_axe: .., x_axe: .., z_axe: ..}
```


[ BEACON_PATH_COORDINATES DELETE DOCUMENT BY ID]

```
> |POST| /beacon/path/delete(.:format)
> parameter {path_di: .., id: ..}
```

..coming soon

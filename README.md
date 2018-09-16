# AWS S3 Signer for Vapor 3

## Purpose

This fork of https://github.com/LiveUI/S3 includes only the S3 signer code, which requires no dependencies other than Vapor itself (other dependencies are currently [causing problems](https://github.com/LiveUI/S3/issues/12) for the original project). Signing requests is relatively complex, and simpler aspects of making requests can be handled by Vapor.

## Usage

Add to dependencies
```swift
.package(url: "https://github.com/rausnitz/S3.git", .branch("master"))
```

Register service in your configure method

```swift
let s3signer = try S3Signer(S3Signer.Config(accessKey: "YOUR_ACCESS_KEY", secretKey: "YOUR_SECRET_KEY", region: Region.usEast1))
services.register(s3signer)
```

use in RouteCollection

```swift
import S3Signer

router.post("upload") { req -> Future<HTTPStatus> in
            guard let data = req.http.body.data else { throw Abort(.badRequest) }
            let s3 = try req.makeS3Signer()
            let url = "https://" + s3.config.region.host.appending("YOUR_BUCKET_NAME/test.png")
            let headers = try s3.headers(for: .PUT, urlString: url, payload: Payload.bytes(data))
            return try req.make(Client.self).put(url, headers: headers) { put in
                return put.http.body = HTTPBody(data: data)
                }.map {
                    return $0.http.status
            }
}
```

## License

See the LICENSE file for more info.

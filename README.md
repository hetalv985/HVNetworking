# HVNetworking
My little Swift networking library attempt. 

How to integrate with the framework:
```
let request = HVHTTPRequest<Cakes>(httpMethod: HVHTTPMethodType.GET,
                                           httpHeaders: nil,
                                           httpBody: nil,
                                           httpUrlString: "http://127.0.0.1:5000/cakes.json",
                                           dataModel: Cakes.self)

let nm = HVAPINetworkManager()
nm.load(httpRequest: request, completion:{
      (cakes: Cakes?) in
      if let cakes = cakes {
          print(cakes)
      }
})
```

where the model `Cakes` may be defined as

```
struct Cake: HVAPIResourceParseable {
    let cakeId: Int
    let cakeName: String
    let cakePrice: Float
    let icing: Icing?
}

struct Cakes: HVAPIResourceParseable{
    let cakes: [Cake]
}
```



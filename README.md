# pokeSearchApp

pokeSearchApp is a sample app that uses pokeFW to provide users to search pokemons and read Shakespearean Style description. 
Users are able to add/remove pokemons to their favorites.

## pokeSearchApp Dependencies

pokeSearchApp deployment target is IOS 13.0. pokeSearchApp uses following pods for API calls, download images and keep/remove favorited data:
```
pod 'Alamofire'
pod 'AlamofireImage'
pod 'CodableAlamofire'
pod 'KeychainSwift'
```

pokeSearchApp uses pokeFW framework, which is attached as XCFramework by adding existing frameworks to the project.

>To include a framework to Xcode project, choose Project > Add to Project and select the framework directory.
>Alternatively, you can control-click your project group and choose Add Files > Existing Frameworks from the contextual menu.

For more information about pokeFW framework, follow the link: [pokeFW](https://github.com/burcukutluay/pokeFW/)

## pokeSearchApp How to Use

pokeSearchApp contains a search bar which allows to users to type and when the search is clicked, pokeFW framework functions will be fired.
to run the pokeSearchApp, you can open pokeSearchApp.xcworkspace and run or download dependencies and adding pokeFW.framework and run the project.

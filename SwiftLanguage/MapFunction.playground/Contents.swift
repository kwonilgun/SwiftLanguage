import UIKit

struct Article {
    let id: Int
    //let source: URL
    let title: String
    //let body: String
}


//KeyPath를 받아서 map 처리를 한다. 결국 article[keyPath: \.id]를 처리하는 것이다. 
extension Sequence {
    func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        return map { $0[keyPath: keyPath] }
    }
}

var articles: [Article] = Array<Article>()
var article = Article(id: 1, title:"kwon")
articles.append(article)
article = Article(id: 2, title:"Park")
articles.append(article)
print(articles)


//KeyPath 타입이다.
let articleIDs = articles.map(\.id)
print(articleIDs)

let articleString = articles.map(\.title)
print(articleString)

let articleId = articles.map { $0.id }
print(articleId)

let articleSt = articles.map { $0.title }
print(articleSt)

let keyPath = \Article.id
print(type(of: keyPath))
let keyPathS = \Article.title
print(type(of: keyPathS))

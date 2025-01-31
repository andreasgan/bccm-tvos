// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension API {
  class GetConfigQuery: GraphQLQuery {
    public static let operationName: String = "GetConfig"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query GetConfig {
          application {
            __typename
            page {
              __typename
              code
            }
          }
          languages
        }
        """#
      ))

    public init() {}

    public struct Data: API.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: Apollo.ParentType { API.Objects.QueryRoot }
      public static var __selections: [Apollo.Selection] { [
        .field("application", Application.self),
        .field("languages", [API.Language].self),
      ] }

      public var application: Application { __data["application"] }
      public var languages: [API.Language] { __data["languages"] }

      /// Application
      ///
      /// Parent Type: `Application`
      public struct Application: API.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: Apollo.ParentType { API.Objects.Application }
        public static var __selections: [Apollo.Selection] { [
          .field("page", Page?.self),
        ] }

        public var page: Page? { __data["page"] }

        /// Application.Page
        ///
        /// Parent Type: `Page`
        public struct Page: API.SelectionSet {
          public let __data: DataDict
          public init(data: DataDict) { __data = data }

          public static var __parentType: Apollo.ParentType { API.Objects.Page }
          public static var __selections: [Apollo.Selection] { [
            .field("code", String.self),
          ] }

          public var code: String { __data["code"] }
        }
      }
    }
  }

}
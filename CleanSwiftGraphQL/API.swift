//  This file was automatically generated and should not be edited.

import Apollo

public final class AllPostsQuery: GraphQLQuery {
  public static let operationDefinition =
    "query AllPosts {" +
    "  posts {" +
    "    __typename" +
    "    ...PostDetails" +
    "  }" +
    "}"
  public static let queryDocument = operationDefinition.appending(PostDetails.fragmentDefinition)
  public init() {
  }

  public struct Data: GraphQLMappable {
    public let posts: [Post]

    public init(reader: GraphQLResultReader) throws {
      posts = try reader.list(for: Field(responseName: "posts"))
    }

    public struct Post: GraphQLMappable {
      public let __typename: String

      public let fragments: Fragments

      public init(reader: GraphQLResultReader) throws {
        __typename = try reader.value(for: Field(responseName: "__typename"))

        let postDetails = try PostDetails(reader: reader)
        fragments = Fragments(postDetails: postDetails)
      }

      public struct Fragments {
        public let postDetails: PostDetails
      }
    }
  }
}

public final class UpvotePostMutation: GraphQLMutation {
  public static let operationDefinition =
    "mutation UpvotePost($postId: Int!) {" +
    "  upvotePost(postId: $postId) {" +
    "    __typename" +
    "    ...PostDetails" +
    "  }" +
    "}"
  public static let queryDocument = operationDefinition.appending(PostDetails.fragmentDefinition)

  public let postId: Int

  public init(postId: Int) {
    self.postId = postId
  }

  public var variables: GraphQLMap? {
    return ["postId": postId]
  }

  public struct Data: GraphQLMappable {
    public let upvotePost: UpvotePost?

    public init(reader: GraphQLResultReader) throws {
      upvotePost = try reader.optionalValue(for: Field(responseName: "upvotePost", arguments: ["postId": reader.variables["postId"]]))
    }

    public struct UpvotePost: GraphQLMappable {
      public let __typename: String

      public let fragments: Fragments

      public init(reader: GraphQLResultReader) throws {
        __typename = try reader.value(for: Field(responseName: "__typename"))

        let postDetails = try PostDetails(reader: reader)
        fragments = Fragments(postDetails: postDetails)
      }

      public struct Fragments {
        public let postDetails: PostDetails
      }
    }
  }
}

public struct PostDetails: GraphQLNamedFragment {
  public static let fragmentDefinition =
    "fragment PostDetails on Post {" +
    "  __typename" +
    "  id" +
    "  title" +
    "  votes" +
    "  author {" +
    "    __typename" +
    "    firstName" +
    "    lastName" +
    "  }" +
    "}"

  public static let possibleTypes = ["Post"]

  public let __typename: String
  public let id: Int
  public let title: String?
  public let votes: Int?
  public let author: Author?

  public init(reader: GraphQLResultReader) throws {
    __typename = try reader.value(for: Field(responseName: "__typename"))
    id = try reader.value(for: Field(responseName: "id"))
    title = try reader.optionalValue(for: Field(responseName: "title"))
    votes = try reader.optionalValue(for: Field(responseName: "votes"))
    author = try reader.optionalValue(for: Field(responseName: "author"))
  }

  public struct Author: GraphQLMappable {
    public let __typename: String
    public let firstName: String?
    public let lastName: String?

    public init(reader: GraphQLResultReader) throws {
      __typename = try reader.value(for: Field(responseName: "__typename"))
      firstName = try reader.optionalValue(for: Field(responseName: "firstName"))
      lastName = try reader.optionalValue(for: Field(responseName: "lastName"))
    }
  }
}
import UIKit

protocol PostTableViewCellDelegate : class {
    func userVotedPost(_ postID: Int)
}

class PostTableViewCell: UITableViewCell {
  var postId: Int?
  weak var cellDelegate: PostTableViewCellDelegate?

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var bylineLabel: UILabel!
  @IBOutlet weak var votesLabel: UILabel!

  func configure(with post: PostListViewModel.DisplayedPost) {
    postId = post.postId

    titleLabel?.text = post.title
    bylineLabel?.text = post.author
    votesLabel?.text = post.votes
  }

  @IBAction func upvote() {
    guard let postId = postId else { return }
    cellDelegate?.userVotedPost(postId)
  }
}

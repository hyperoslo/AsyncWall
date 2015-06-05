import Quick
import Nimble

class PostSpec: QuickSpec {

  override func spec() {
    describe("User") {
      let text = "Test post"
      let date = NSDate()
      let user = User(
        name: "John Hyperseed",
        avatar: Image("https://avatars2.githubusercontent.com/u/1340892?v=3&s=200"))
      let group = "Group"
      let location = "Oslo"
      let attachments: [Attachment] = [Image("http://lorempixel.com/300/200/")]

      var post: Post!

      beforeEach {
        post = Post(text: text, date: date, author: user, attachments: attachments)
      }

      describe("#init") {
        it("sets text") {
          expect(post.text).to(equal(text))
        }

        it("sets date") {
          expect(post.date).to(equal(date))
        }

        it("sets default values") {
          expect(post.group).to(beNil())
          expect(post.location).to(beNil())
          expect(post.likes).to(equal(0))
          expect(post.views).to(equal(0))
          expect(post.parent).to(beNil())
          expect(post.comments.count).to(equal(0))
        }

        context("with required parameters") {
          beforeEach {
            post = Post(text: text, date: date)
          }

          it("sets default values") {
            expect(post.author).to(beNil())
            expect(post.attachments).to(beNil())
          }
        }

        context("with all parameters") {
          it("sets author") {
            expect(post.author).notTo(beNil())
            expect(post.author?.name).to(equal(user.name))
            expect(post.author?.avatar?.thumbnail.string).to(
              equal(user.avatar?.thumbnail.string))
          }

          it("sets attachments") {
            expect(post.attachments).notTo(beNil())
            expect(post.attachments?.count).to(equal(attachments.count))
          }
        }
      }
    }
  }
}

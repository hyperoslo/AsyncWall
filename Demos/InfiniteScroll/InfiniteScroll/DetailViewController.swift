import Foundation
import Wall

class DetailViewController: WallController {

  override func viewDidLoad() {
    super.viewDidLoad()

    title = post!.text
  }

}

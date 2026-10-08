import SwiftUI
import XCTest
@testable import LazyPager

final class LazyPagerTests: XCTestCase {
    @MainActor
    func testSelectedPageIsVisibleOnFirstLayout() {
        for initialPage in [1, 2] {
            var config = Config<Int>()
            config.preloadAmount = 99
            let provider = ViewDataProvider(
                data: [0, 1, 2], page: .constant(initialPage), config: config,
                viewLoader: { Text("Image \($0)") }
            )
            provider.view.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
            provider.view.layoutIfNeeded()

            let pager = provider.pagerView
            XCTAssertEqual(pager.loadedViews[safe: pager.relativeIndex]?.index, initialPage,
                           "The first layout must show the selected image before queued loading runs")
        }
    }
}

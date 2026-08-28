import Testing
@testable import SwiftUITabToolbarLab

struct SwiftUITabToolbarLabTests {
    @Test func demoDataIsDeterministic() {
        let people = DemoData.generatePeople(count: 3)

        #expect(people == ["Emma Smith", "Liam Johnson", "Olivia Williams"])
    }
}

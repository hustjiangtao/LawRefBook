import Foundation
import CoreSpotlight
import MobileCoreServices

func SpotlightIndex(id: UUID, lawID: UUID, content: String) {
    let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
    attributeSet.title = LawProvider.shared.getLawTitleByUUID(lawID)
    attributeSet.contentDescription = content

    let item = CSSearchableItem(uniqueIdentifier: "\(id)", domainIdentifier: "xyz.rankki.law-handbook", attributeSet: attributeSet)
    CSSearchableIndex.default().indexSearchableItems([item]) { error in
        if let error = error {
            print("Indexing error: \(error.localizedDescription)")
        } else {
            print("Search item successfully indexed!")
        }
    }
}


func SpotlightDeIndex(id: UUID) {
    CSSearchableIndex.default().deleteSearchableItems(withIdentifiers: ["\(id)"]) { error in
        if let error = error {
            print("Deindexing error: \(error.localizedDescription)")
        } else {
            print("Search item successfully removed!")
        }
    }
}

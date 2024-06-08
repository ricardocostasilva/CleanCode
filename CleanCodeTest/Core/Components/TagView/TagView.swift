//
//  TagView.swift
//  CleanCodeTest
//
//  Created by ricardo silva on 30/04/2024.
//

import SwiftUI

struct TagsView: View {
    var tags: [String]
    
    @State private var rows: [[String]] = []

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // Iterate through the calculated rows
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 3) {
                    // Iterate through the tags in the current row
                    ForEach(row, id: \.self) { tag in
                        // Create a Text view for each tag
                        Text(tag)
                            .font(.system(size: 10))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(
                                Capsule()
                                    .fill(Color.gray.opacity(0.3))
                            )
                            .padding(.trailing, 3)
                    }
                }
            }
        }
        .padding(24)
        .onAppear {
            calculateRows()
        }
        .onChange(of: tags) { _ in
            calculateRows()
        }
    }

    // Method to calculate the rows of tags based on the available screen width
    private func calculateRows() {
        // Clear the existing rows
        rows = []
        var currentRow: [String] = []
        var currentRowWidth: CGFloat = 0
        let screenWidth = UIScreen.main.bounds.width  // Adjusted for padding

        // Iterate through the tags
        for tag in tags {
            let tagWidth = tagWidth(for: tag)

            // Check if adding the tag will exceed the current row width
            if currentRowWidth + tagWidth > screenWidth {
                // If so, add the current row to the rows array and start a new row
                rows.append(currentRow)
                currentRow = []
                currentRowWidth = 0
            }

            // Add the tag to the current row
            currentRow.append(tag)
            currentRowWidth += tagWidth
        }

        // Add the last row if it isn't empty
        if !currentRow.isEmpty {
            rows.append(currentRow)
        }
    }

    // Method to calculate the width of a tag
    private func tagWidth(for tag: String) -> CGFloat {
        // Calculate the width of the tag's text
        let font = UIFont.systemFont(ofSize: 10)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let tagWidth = (tag as NSString).size(withAttributes: attributes).width
        
        // Include padding and spacing adjustments
        return tagWidth + 40
    }
}

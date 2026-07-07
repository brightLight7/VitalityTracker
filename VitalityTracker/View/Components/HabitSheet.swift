import SwiftUI
import SwiftData

struct HabitSheet: View
{
    let item: Item
    let onSave: (String) -> Void
    @State private var editedTitle: String = ""
    @State private var selectedFrequency: HabitTargetFrequency
    @State private var titleText: String
    @Environment(\.dismiss) private var dismiss
    
    init(item: Item, onSave: @escaping (String) -> Void) {
        self.item = item
        self.onSave = onSave
        _titleText = State(initialValue: item.title)
        _selectedFrequency = State(initialValue: item.targetFrequency)
        
    }
    
    private func saveChanges()
    {
        item.title = editedTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        item.targetFrequency = selectedFrequency
        dismiss()
    }
    private func formattedDate(_ date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    var body: some View
    {
        NavigationStack
        {
            Form
            {
            Section("Habit Details")
                {
                    TextField("Habit title", text: $editedTitle)
                    
                    HStack
                    {
                        Text("Category")
                        Spacer()
                        Text(item.category?.name ?? "Uncategorised")
                            .foregroundStyle(.secondary)
                    }
                    
                    HStack
                    {
                        Text("Created")
                        Spacer()
                        Text(formattedDate(item.createdDate))
                            .foregroundStyle(.secondary)
                    }
                }
                
                Section("Target Frequency")
                {
                    Picker("Frequency", selection: $selectedFrequency)
                    {
                        ForEach(HabitTargetFrequency.allCases, id: \.self)
                        {
                            frequency in Text(
                                frequency.rawValue
                            ).tag(frequency)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .navigationTitle("Edit Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar
            {
                ToolbarItem(placement: .cancellationAction)
                {
                    Button("Cancel") {dismiss()}
                }
                ToolbarItem(placement: .confirmationAction)
                {
                    Button("Save")
                    {
                        saveChanges()
                    }
                    .disabled(editedTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            .onAppear
            {
                editedTitle = item.title
                selectedFrequency = item.targetFrequency
            }
        }
    }
    
    
}

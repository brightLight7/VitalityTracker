import SwiftUI

struct HabitRowView: View
{
    let item: Item
    let viewingDate: Date
    let onTap: () -> Void
    //let onLongPress: () -> Void
    
    @EnvironmentObject var streaksController: StreaksController
    
    private var done: Bool
    {
        streaksController.isCompleted(item.id, on: viewingDate)
    }
    
    private var s: Int
    {
        streaksController.streak(for: item, endingOn: viewingDate)
    }
    
    private var isToday: Bool
    {
        Calendar.current.isDateInToday(viewingDate)
    }
    var body: some View
    {
        
        HStack (spacing: 12)
        {
            Button
            {
                guard isToday else {return}
                streaksController.toggleCompletion(item.id, on: viewingDate)
            }
        label:
            {
                Image(systemName: done ? "checkmark.square.fill" : "square")
                    .font(.title3)
            }
            .buttonStyle(.plain)
            
            Text(item.title)
                .strikethrough(done)
            
            Spacer()
            if s > 0
            {
                HStack(spacing: 4)
                {
                    Text("🔥")
                    Text("\(s)")
                        .font(.caption)
                        .bold()
                        .foregroundStyle(.orange)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(.thinMaterial)
                .clipShape(Capsule())
                
            }
            
            
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
    }
    
}

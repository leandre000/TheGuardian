//
//  NotificationsView.swift
//  BabyGuardian
//
//  Notifications screen with Today and This week sections
//

import SwiftUI
import DesignSystem

struct NotificationsView: View {
    @EnvironmentObject var alertManager: AlertManager
    @State private var showMenu = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 0) {
                        // Today Section
                        NotificationSection(
                            title: "Today",
                            count: 3,
                            notifications: todayNotifications
                        )
                        
                        // This week Section
                        NotificationSection(
                            title: "This week",
                            count: nil,
                            notifications: weekNotifications
                        )
                    }
                }
            }
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showMenu = true
                    }) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.primary)
                    }
                }
            }
            .sheet(isPresented: $showMenu) {
                NotificationsMenuView()
            }
        }
    }
    
    var todayNotifications: [NotificationItem] {
        [
            NotificationItem(
                type: .health,
                icon: "heart.fill",
                iconColor: .red,
                title: "Baby's heart rate is above normal may be active or stressed.",
                time: "48min ago",
                isNew: true
            ),
            NotificationItem(
                type: .cry,
                icon: "waveform",
                iconColor: .orange,
                title: "Jesper's cry was detected. Please check in to see what's wrong",
                time: "2h ago",
                isNew: true
            ),
            NotificationItem(
                type: .ai,
                icon: "brain",
                iconColor: .blue,
                title: "Check out the new trends in Jesper's health",
                time: "2h ago",
                isNew: true
            )
        ]
    }
    
    var weekNotifications: [NotificationItem] {
        [
            NotificationItem(
                type: .fall,
                icon: "exclamationmark.triangle.fill",
                iconColor: .red,
                title: "Possible fall detected! Please check on your baby immediately",
                date: "28 Oct",
                isNew: false
            ),
            NotificationItem(
                type: .sleep,
                icon: "moon.fill",
                iconColor: .blue,
                title: "Jesper has been asleep for a while, time to check comfort and posture",
                date: "19 Oct",
                isNew: false
            ),
            NotificationItem(
                type: .environment,
                icon: "thermometer",
                iconColor: .orange,
                title: "Room temperature is too warm, risk of overheating.",
                date: "24 Oct",
                isNew: false
            ),
            NotificationItem(
                type: .feeding,
                icon: "babybottle.fill",
                iconColor: .blue,
                title: "It's feeding time! Jesper may be getting hungry",
                date: "19 Oct",
                isNew: false
            )
        ]
    }
}

struct NotificationSection: View {
    let title: String
    let count: Int?
    let notifications: [NotificationItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Section Header
            HStack {
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                
                if let count = count {
                    Text("(\(count) new)")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(AppTheme.primaryOrange)
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            // Notifications List
            VStack(spacing: 12) {
                ForEach(notifications) { notification in
                    NotificationRow(notification: notification)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .background(Color(.systemBackground))
        .padding(.top, 8)
    }
}

struct NotificationItem: Identifiable {
    let id = UUID()
    let type: NotificationType
    let icon: String
    let iconColor: Color
    let title: String
    let time: String?
    let date: String?
    let isNew: Bool
    
    enum NotificationType {
        case health, cry, ai, fall, sleep, environment, feeding
    }
    
    init(type: NotificationType, icon: String, iconColor: Color, title: String, time: String? = nil, date: String? = nil, isNew: Bool) {
        self.type = type
        self.icon = icon
        self.iconColor = iconColor
        self.title = title
        self.time = time
        self.date = date
        self.isNew = isNew
    }
}

struct NotificationRow: View {
    let notification: NotificationItem
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Icon
            ZStack {
                Circle()
                    .fill(notification.iconColor.opacity(0.2))
                    .frame(width: 44, height: 44)
                
                Image(systemName: notification.icon)
                    .font(.system(size: 20))
                    .foregroundColor(notification.iconColor)
            }
            
            // Content
            VStack(alignment: .leading, spacing: 6) {
                Text(notification.title)
                    .font(.system(size: 15))
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
                
                HStack {
                    if let time = notification.time {
                        Text(time)
                            .font(.system(size: 13))
                            .foregroundColor(.secondary)
                    } else if let date = notification.date {
                        Text(date)
                            .font(.system(size: 13))
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    if notification.isNew {
                        Circle()
                            .fill(notification.iconColor)
                            .frame(width: 8, height: 8)
                    }
                }
            }
            
            Spacer()
        }
        .padding(16)
        .background(Color(.systemGroupedBackground))
        .cornerRadius(12)
    }
}

struct NotificationsMenuView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Menu Options")
                    .font(.title)
                    .padding()
                // TODO: Add menu options
            }
            .navigationTitle("Menu")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

